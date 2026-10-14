import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';
import '../services/brevo_transactional_email_service.dart';

/// Endpoint providing secure passwordless Email OTP authentication for EquipLink.
///
/// Features:
/// - Cryptographic challenge-bound single-use verification codes.
/// - Request context and IP tracking with risk detection.
/// - Expiration, single-use, and attempt count enforcement.
/// - Reuses official Serverpod token manager and AuthSuccess token issuance.
class OtpAuthEndpoint extends Endpoint {
  /// Request a single-use login code sent to the specified email.
  Future<OtpChallengeResponse> requestLoginCode(
    Session session, {
    required String email,
    String? preAuthNonce,
  }) async {
    final normalizedEmail = email.trim().toLowerCase();

    // 1. Validate email format
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(normalizedEmail)) {
      throw FormatException('Invalid email address format.');
    }

    // 2. Throttle / Rate limiting check
    final recentWindow = DateTime.now().subtract(const Duration(minutes: 10));
    final recentChallenges = await EmailOtpChallenge.db.find(
      session,
      where: (t) =>
          (t.email.equals(normalizedEmail)) & (t.issuedAt >= recentWindow),
    );

    if (recentChallenges.length >= 5) {
      session.log(
        'Rate limit exceeded for OTP requests to ${BrevoTransactionalEmailService.maskEmail(normalizedEmail)}',
        level: LogLevel.warning,
      );
      // Return generic response to prevent abuse
      return OtpChallengeResponse(
        challengeId: '',
        expiresInSeconds: 0,
        message: 'Too many requests. Please try again in 10 minutes.',
      );
    }

    // 3. Generate cryptographically secure 6-digit OTP
    final rng = Random.secure();
    final otpCodeInt = 100000 + rng.nextInt(900000);
    final rawCode = otpCodeInt.toString();

    // 4. Generate random salt and hash the OTP (never store plain OTP)
    final saltBytes = List<int>.generate(16, (_) => rng.nextInt(256));
    final salt = base64UrlEncode(saltBytes);
    final codeHash = sha256.convert(utf8.encode('$salt:$rawCode')).toString();

    // 5. Build unguessable challenge ID
    final challengeId = const Uuid().v4();

    // 6. Extract IP and User-Agent context
    String? requestIp;
    String? userAgent;
    if (session is MethodCallSession) {
      try {
        requestIp = session.request.remoteInfo;
        final rawUserAgent = session.request.headers['user-agent']?.firstOrNull;
        if (rawUserAgent != null) {
          userAgent = rawUserAgent.length > 255
              ? rawUserAgent.substring(0, 255)
              : rawUserAgent;
        }
      } catch (_) {}
    }

    final challenge = EmailOtpChallenge(
      challengeId: challengeId,
      email: normalizedEmail,
      codeHash: codeHash,
      salt: salt,
      issuedAt: DateTime.now(),
      expiresAt: DateTime.now().add(const Duration(minutes: 10)),
      attempts: 0,
      maxAttempts: 5,
      consumed: false,
      requestIp: requestIp,
      userAgent: userAgent,
      preAuthNonce: preAuthNonce,
    );

    await EmailOtpChallenge.db.insertRow(session, challenge);

    // 7. Dispatch verification email via Brevo
    final sendResult = await BrevoTransactionalEmailService.instance
        .sendLoginOtpCode(
          recipientEmail: normalizedEmail,
          code: rawCode,
          expiration: const Duration(minutes: 10),
        );

    if (!sendResult.success) {
      challenge.consumed = true;
      await EmailOtpChallenge.db.updateRow(session, challenge);
      session.log(
        'Failed to deliver OTP to ${BrevoTransactionalEmailService.maskEmail(normalizedEmail)}.',
        level: LogLevel.error,
      );
      throw EquipLinkException(
        message: 'Unable to send a verification code. Please try again later.',
        statusCode: 503,
      );
    }

    return OtpChallengeResponse(
      challengeId: challengeId,
      expiresInSeconds: 600,
      message: 'Verification code sent to registered email address.',
    );
  }

  /// Verifies a login code, binds the requesting context, and issues an official Serverpod session token.
  Future<AuthSuccess> verifyLoginCode(
    Session session, {
    required String challengeId,
    required String code,
    String? preAuthNonce,
  }) async {
    // 1. Fetch challenge
    final challenges = await EmailOtpChallenge.db.find(
      session,
      where: (t) => t.challengeId.equals(challengeId),
      limit: 1,
    );

    final challenge = challenges.firstOrNull;
    if (challenge == null) {
      throw EquipLinkException(
        message: 'Invalid or expired verification challenge.',
        statusCode: 400,
      );
    }

    // 2. Security checks
    if (challenge.consumed) {
      throw EquipLinkException(
        message: 'This verification code has already been redeemed.',
        statusCode: 400,
      );
    }

    if (DateTime.now().isAfter(challenge.expiresAt)) {
      throw EquipLinkException(
        message:
            'The verification code has expired. Please request a new code.',
        statusCode: 400,
      );
    }

    if (challenge.attempts >= challenge.maxAttempts) {
      throw EquipLinkException(
        message:
            'Maximum verification attempts exceeded. Challenge invalidated.',
        statusCode: 400,
      );
    }

    // 3. Pre-auth context verification & Risk evaluation
    if (challenge.preAuthNonce != null &&
        challenge.preAuthNonce != preAuthNonce) {
      session.log(
        'Pre-auth nonce mismatch for challenge $challengeId',
        level: LogLevel.warning,
      );
      throw EquipLinkException(
        message: 'Security verification context mismatch.',
        statusCode: 403,
      );
    }

    String? currentIp;
    if (session is MethodCallSession) {
      try {
        currentIp = session.request.remoteInfo;
      } catch (_) {}
    }

    if (challenge.requestIp != null &&
        currentIp != null &&
        challenge.requestIp != currentIp) {
      session.log(
        'Risk signal: IP changed during OTP verification from ${challenge.requestIp} to $currentIp.',
        level: LogLevel.warning,
      );
      // We log risk without blocking mobile network handoffs
    }

    // 4. Verify code hash
    final submittedHash = sha256
        .convert(utf8.encode('${challenge.salt}:${code.trim()}'))
        .toString();

    if (submittedHash != challenge.codeHash) {
      challenge.attempts += 1;
      if (challenge.attempts >= challenge.maxAttempts) {
        challenge.consumed = true;
      }
      await EmailOtpChallenge.db.updateRow(session, challenge);

      final remaining = challenge.maxAttempts - challenge.attempts;
      throw EquipLinkException(
        message:
            'Invalid verification code. ($remaining attempt(s) remaining).',
        statusCode: 400,
      );
    }

    // 5. Consume challenge immediately (prevents concurrency reuse)
    challenge.consumed = true;
    await EmailOtpChallenge.db.updateRow(session, challenge);

    // 6. Find or create user identity
    final email = challenge.email;
    final profiles = await AuthServices.instance.userProfiles.admin
        .listUserProfiles(
          session,
          email: email,
          limit: 1,
        );

    UuidValue authUserId;
    var profile = profiles.firstOrNull;

    if (profile == null) {
      // Create new authenticated user
      final authUser = await AuthServices.instance.authUsers.create(session);
      authUserId = authUser.id;

      await AuthServices.instance.userProfiles.createUserProfile(
        session,
        authUserId,
        UserProfileData(
          email: email,
        ),
      );

      // Auto-create StudentProfile placeholder
      final initialName = email.split('@').first;
      final studentProfile = StudentProfile(
        authUserId: authUserId,
        fullName: initialName,
        email: email,
        university: 'Campus Member',
        isVerified: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await StudentProfile.db.insertRow(session, studentProfile);
    } else {
      authUserId = profile.authUserId;
    }

    // 7. Issue official Serverpod Auth token
    final authSuccess = await AuthServices.instance.tokenManager.issueToken(
      session,
      authUserId: authUserId,
      method: 'email_otp',
    );

    session.log(
      'Successfully authenticated user $authUserId via passwordless OTP.',
      level: LogLevel.info,
    );

    return authSuccess;
  }
}
