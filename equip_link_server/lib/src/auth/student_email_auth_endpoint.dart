import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';
import '../services/brevo_transactional_email_service.dart';

final studentEmailPattern = RegExp(
  r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.edu\.in$',
);

String normalizeStudentEmail(String value) => value.trim().toLowerCase();

class StudentEmailAuthEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<StudentIdentity> getStudentEligibilityStatus(Session session) async {
    final authUserId = session.authenticated!.authUserId;
    final existing = await _getIdentity(session, authUserId);
    if (existing != null) {
      final now = DateTime.now();
      if (existing.studentIdExpiresAt != null &&
          now.isAfter(existing.studentIdExpiresAt!) &&
          existing.eligibilityStatus != 'expired') {
        existing.eligibilityStatus = 'expired';
        existing.updatedAt = now;
        return StudentIdentity.db.updateRow(session, existing);
      }
      if (existing.eligibilityStatus == 'eligible' &&
          (!existing.emailVerified ||
              !existing.studentIdCardVerified ||
              existing.studentIdCardPath == null ||
              existing.studentIdExpiresAt == null)) {
        existing.eligibilityStatus = 'pending';
        existing.emailVerified = false;
        existing.updatedAt = now;
        return StudentIdentity.db.updateRow(session, existing);
      }
      return existing;
    }

    final now = DateTime.now();
    final identity = StudentIdentity(
      authUserId: authUserId,
      emailVerified: false,
      eligibilityStatus: 'pending',
      createdAt: now,
      updatedAt: now,
    );
    return StudentIdentity.db.insertRow(session, identity);
  }

  /// Creates a private, user-scoped upload authorization for a student ID card.
  Future<StudentIdCardUpload> prepareStudentIdCardUpload(
    Session session, {
    required String university,
    required DateTime expiresAt,
    required String fileName,
    required int fileSizeBytes,
  }) async {
    final authUserId = session.authenticated!.authUserId;
    final normalizedUniversity = university.trim();
    if (normalizedUniversity.isEmpty || normalizedUniversity.length > 160) {
      throw FormatException('Enter a valid university or campus name.');
    }

    final now = DateTime.now();
    final expirationDate = DateTime(
      expiresAt.year,
      expiresAt.month,
      expiresAt.day,
      23,
      59,
      59,
    );
    if (!expirationDate.isAfter(now) ||
        expirationDate.isAfter(DateTime(now.year + 8, now.month, now.day))) {
      throw FormatException(
        'The student ID expiry date must be within the next 8 years.',
      );
    }
    if (fileSizeBytes <= 0 || fileSizeBytes > 8 * 1024 * 1024) {
      throw FormatException('Choose an image up to 8 MB.');
    }

    final extension = fileName.split('.').last.toLowerCase();
    if (!const {'jpg', 'jpeg', 'png', 'webp'}.contains(extension)) {
      throw FormatException('Choose a JPG, PNG, or WebP image.');
    }

    final path = 'student-id-cards/$authUserId/${const Uuid().v4()}.$extension';
    final identity =
        await _getIdentity(session, authUserId) ??
        StudentIdentity(
          authUserId: authUserId,
          emailVerified: false,
          eligibilityStatus: 'pending',
          createdAt: now,
          updatedAt: now,
        );
    identity
      ..university = normalizedUniversity
      ..studentIdCardPath = path
      ..studentIdExpiresAt = expirationDate
      ..studentIdCardVerified = false
      ..emailVerified = false
      ..eligibilityStatus = 'pending'
      ..updatedAt = now;
    if (identity.id == null) {
      await StudentIdentity.db.insertRow(session, identity);
    } else {
      await StudentIdentity.db.updateRow(session, identity);
    }

    final description = await session.storage.createUploadDescription(
      storageId: 'private',
      path: path,
      options: UploadOptions(
        contentLength: fileSizeBytes,
        maxFileSize: 8 * 1024 * 1024,
        preventOverwrite: true,
      ),
    );
    return StudentIdCardUpload(path: path, uploadDescription: description);
  }

  /// Confirms that the authenticated student's private ID-card upload completed.
  Future<bool> verifyStudentIdCardUpload(
    Session session, {
    required String path,
  }) async {
    final authUserId = session.authenticated!.authUserId;
    final identity = await _getIdentity(session, authUserId);
    if (identity == null || identity.studentIdCardPath != path) {
      throw EquipLinkException(
        message: 'Student ID upload does not belong to this account.',
        statusCode: 403,
      );
    }
    if (identity.studentIdExpiresAt == null ||
        DateTime.now().isAfter(identity.studentIdExpiresAt!)) {
      throw FormatException('The student ID card has expired.');
    }

    final verified = await session.storage.verifyUpload(
      storageId: 'private',
      path: path,
    );
    if (!verified) {
      throw EquipLinkException(
        message: 'The student ID image upload could not be verified.',
        statusCode: 400,
      );
    }
    identity
      ..studentIdCardVerified = true
      ..updatedAt = DateTime.now();
    await StudentIdentity.db.updateRow(session, identity);
    return true;
  }

  Future<StudentEmailChallengeResponse> requestStudentEmailVerification(
    Session session, {
    required String email,
  }) async {
    final authUserId = session.authenticated!.authUserId;
    final normalizedEmail = _validateEmail(email);
    final identity = await _getIdentity(session, authUserId);
    if (identity == null ||
        identity.university == null ||
        !identity.studentIdCardVerified ||
        identity.studentIdExpiresAt == null ||
        DateTime.now().isAfter(identity.studentIdExpiresAt!)) {
      throw EquipLinkException(
        message:
            'Upload a valid, unexpired student ID card before verifying your email.',
        statusCode: 400,
      );
    }
    final authenticatedProfile = await session.authenticated!.userProfile(
      session,
    );
    if (identity.googleProviderIdentity == null &&
        normalizeStudentEmail(authenticatedProfile?.email ?? '') ==
            normalizedEmail) {
      await _activateStudentIdentity(
        session,
        identity: identity,
        email: normalizedEmail,
      );
      return StudentEmailChallengeResponse(
        challengeId: '',
        expiresInSeconds: 0,
        message: 'Your email was already verified during account creation.',
      );
    }
    final recentWindow = DateTime.now().subtract(const Duration(minutes: 10));
    final recent = await StudentEmailVerificationChallenge.db.find(
      session,
      where: (t) =>
          (t.authUserId.equals(authUserId)) &
          (t.issuedAt >= recentWindow) &
          (t.email.equals(normalizedEmail)),
    );
    if (recent.length >= 3) {
      throw EquipLinkException(
        message: 'Too many verification requests. Please try again later.',
        statusCode: 429,
      );
    }

    final rng = Random.secure();
    final code = (100000 + rng.nextInt(900000)).toString();
    final salt = base64UrlEncode(
      List<int>.generate(16, (_) => rng.nextInt(256)),
    );
    final now = DateTime.now();
    final challenge = StudentEmailVerificationChallenge(
      challengeId: const Uuid().v4(),
      authUserId: authUserId,
      email: normalizedEmail,
      codeHash: sha256.convert(utf8.encode('$salt:$code')).toString(),
      salt: salt,
      issuedAt: now,
      expiresAt: now.add(const Duration(minutes: 10)),
      attempts: 0,
      maxAttempts: 5,
      consumed: false,
      requestIp: _requestIp(session),
      userAgent: _userAgent(session),
    );
    final stored = await StudentEmailVerificationChallenge.db.insertRow(
      session,
      challenge,
    );

    final result = await BrevoTransactionalEmailService.instance
        .sendStudentEmailVerificationCode(
          recipientEmail: normalizedEmail,
          code: code,
          expiration: const Duration(minutes: 10),
        );
    if (!result.success) {
      // Do not depend on the auto-generated database id returned by insertRow.
      // Some Serverpod Cloud database adapters can return an inserted row
      // without its id; updateRow would then throw and turn the intended 503
      // email-provider error into an unhandled HTTP 500.
      await StudentEmailVerificationChallenge.db.updateWhere(
        session,
        columnValues: (t) => [t.consumed(true)],
        where: (t) =>
            (t.challengeId.equals(stored.challengeId)) &
            (t.authUserId.equals(authUserId)),
        noReturn: true,
      );
      throw EquipLinkException(
        message:
            result.error ??
            'Unable to send a verification code. Please try again later.',
        statusCode: 503,
      );
    }

    return StudentEmailChallengeResponse(
      challengeId: stored.challengeId,
      expiresInSeconds: 600,
      message: 'Verification code sent.',
    );
  }

  Future<StudentIdentity> verifyStudentEmail(
    Session session, {
    required String challengeId,
    required String code,
  }) async {
    final authUserId = session.authenticated!.authUserId;
    final challenge = (await StudentEmailVerificationChallenge.db.find(
      session,
      where: (t) =>
          (t.challengeId.equals(challengeId)) &
          (t.authUserId.equals(authUserId)),
      limit: 1,
    )).firstOrNull;
    if (challenge == null ||
        challenge.consumed ||
        DateTime.now().isAfter(challenge.expiresAt)) {
      throw EquipLinkException(
        message: 'Invalid or expired verification challenge.',
        statusCode: 400,
      );
    }
    if (challenge.attempts >= challenge.maxAttempts) {
      throw EquipLinkException(
        message: 'Maximum verification attempts exceeded.',
        statusCode: 400,
      );
    }

    final submittedHash = sha256
        .convert(utf8.encode('${challenge.salt}:${code.trim()}'))
        .toString();
    if (submittedHash != challenge.codeHash) {
      challenge.attempts += 1;
      if (challenge.attempts >= challenge.maxAttempts) {
        challenge.consumed = true;
      }
      await StudentEmailVerificationChallenge.db.updateRow(session, challenge);
      throw EquipLinkException(
        message: 'Invalid verification code.',
        statusCode: 400,
      );
    }

    challenge.consumed = true;
    await StudentEmailVerificationChallenge.db.updateRow(session, challenge);

    final now = DateTime.now();
    final identity =
        await _getIdentity(session, authUserId) ??
        StudentIdentity(
          authUserId: authUserId,
          emailVerified: false,
          eligibilityStatus: 'pending',
          createdAt: now,
          updatedAt: now,
        );
    if (!identity.studentIdCardVerified ||
        identity.studentIdCardPath == null ||
        identity.studentIdExpiresAt == null ||
        now.isAfter(identity.studentIdExpiresAt!)) {
      throw EquipLinkException(
        message: 'Upload a valid, unexpired student ID card first.',
        statusCode: 400,
      );
    }
    return _activateStudentIdentity(
      session,
      identity: identity,
      email: challenge.email,
    );
  }

  Future<StudentIdentity> _activateStudentIdentity(
    Session session, {
    required StudentIdentity identity,
    required String email,
  }) async {
    final authUserId = session.authenticated!.authUserId;
    final now = DateTime.now();
    identity
      ..studentEmail = email
      ..emailVerified = true
      ..verifiedAt = now
      ..lastRevalidatedAt = now
      ..revalidationDueAt = identity.studentIdExpiresAt
      ..eligibilityStatus = 'eligible'
      ..updatedAt = now;
    final savedIdentity = identity.id == null
        ? await StudentIdentity.db.insertRow(session, identity)
        : await StudentIdentity.db.updateRow(session, identity);
    final profile = (await StudentProfile.db.find(
      session,
      where: (t) => t.authUserId.equals(authUserId),
      limit: 1,
    )).firstOrNull;
    if (profile == null) {
      final userProfile = await session.authenticated!.userProfile(session);
      await StudentProfile.db.insertRow(
        session,
        StudentProfile(
          authUserId: authUserId,
          fullName: userProfile?.fullName ?? email.split('@').first,
          email: email,
          university: identity.university!,
          isVerified: true,
          createdAt: now,
          updatedAt: now,
        ),
      );
    } else {
      profile
        ..email = email
        ..university = identity.university!
        ..isVerified = true
        ..updatedAt = now;
      await StudentProfile.db.updateRow(session, profile);
    }
    return savedIdentity;
  }

  String _validateEmail(String value) {
    final normalized = normalizeStudentEmail(value);
    if (normalized.length > 320 || !studentEmailPattern.hasMatch(normalized)) {
      throw FormatException('A valid .edu.in student email is required.');
    }
    return normalized;
  }

  Future<StudentIdentity?> _getIdentity(
    Session session,
    UuidValue authUserId,
  ) async {
    return (await StudentIdentity.db.find(
      session,
      where: (t) => t.authUserId.equals(authUserId),
      limit: 1,
    )).firstOrNull;
  }

  String? _requestIp(Session session) {
    if (session is MethodCallSession) return session.request.remoteInfo;
    return null;
  }

  String? _userAgent(Session session) {
    if (session is! MethodCallSession) return null;
    final value = session.request.headers['user-agent']?.firstOrNull;
    return value == null || value.length <= 255
        ? value
        : value.substring(0, 255);
  }
}
