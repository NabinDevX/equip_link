import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../config/brevo_config.dart';
import '../config/infrastructure_config.dart';

/// Exception thrown when Brevo API calls fail.
class BrevoApiException implements Exception {
  final int statusCode;
  final String message;
  final String? code;

  BrevoApiException({
    required this.statusCode,
    required this.message,
    this.code,
  });

  @override
  String toString() =>
      'BrevoApiException(statusCode: $statusCode, code: $code, message: $message)';
}

/// Result of sending a transactional email via Brevo.
class BrevoSendResult {
  final bool success;
  final String? messageId;
  final String? error;

  const BrevoSendResult({
    required this.success,
    this.messageId,
    this.error,
  });

  @override
  String toString() =>
      'BrevoSendResult(success: $success, messageId: $messageId, error: $error)';
}

/// Server-side service for sending transactional emails via Brevo.
///
/// Uses POST https://api.brevo.com/v3/smtp/email
class BrevoTransactionalEmailService {
  static BrevoTransactionalEmailService? _instance;

  /// Singleton instance
  static BrevoTransactionalEmailService get instance =>
      _instance ??= BrevoTransactionalEmailService();

  /// Setter for testing or custom configuration
  static set instance(BrevoTransactionalEmailService service) {
    _instance = service;
  }

  final http.Client _client;
  final BrevoConfig? _explicitConfig;
  final Duration timeout;

  BrevoTransactionalEmailService({
    http.Client? client,
    BrevoConfig? config,
    this.timeout = const Duration(seconds: 10),
  }) : _client = client ?? http.Client(),
       _explicitConfig = config;

  /// Resolves the current Brevo configuration.
  BrevoConfig get config =>
      _explicitConfig ?? InfrastructureConfig.getBrevoConfig();

  /// Safely masks an email address for logging (e.g. `jo***@example.com`).
  static String maskEmail(String email) {
    final parts = email.split('@');
    if (parts.length != 2) return '***';
    final user = parts[0];
    final domain = parts[1];
    if (user.length <= 2) {
      return '${user.substring(0, 1)}***@$domain';
    }
    return '${user.substring(0, 2)}***@$domain';
  }

  /// Low-level method to send a transactional email via Brevo.
  ///
  /// Never logs API keys, verification codes, or authorization headers.
  Future<BrevoSendResult> sendEmail({
    required String recipientEmail,
    required String subject,
    required String htmlContent,
    required String textContent,
    List<String> tags = const [],
    int? templateId,
  }) async {
    final activeConfig = config;
    final apiKey = activeConfig.apiKey?.trim();

    // Missing credentials are a delivery failure, never a successful simulation.
    if (!activeConfig.isConfigured ||
        apiKey == null ||
        apiKey.isEmpty ||
        apiKey.startsWith('your_') ||
        apiKey == 'test-key') {
      stdout.writeln(
        '[BrevoEmailService] Brevo is not configured; email delivery was not attempted for ${maskEmail(recipientEmail)}.',
      );
      return const BrevoSendResult(
        success: false,
        error: 'Transactional email service is not configured.',
      );
    }

    final endpoint = Uri.parse(BrevoConfig.defaultEndpoint);

    final payload = <String, dynamic>{
      'sender': {
        'name': activeConfig.senderName ?? 'EquipLink',
        'email': activeConfig.senderEmail,
      },
      'to': [
        {'email': recipientEmail.trim().toLowerCase()},
      ],
      'subject': subject,
      'htmlContent': htmlContent,
      'textContent': textContent,
    };

    if (tags.isNotEmpty) {
      payload['tags'] = tags;
    }

    if (templateId != null) {
      payload['templateId'] = templateId;
    }

    try {
      final response = await _client
          .post(
            endpoint,
            headers: activeConfig.requestHeaders,
            body: jsonEncode(payload),
          )
          .timeout(timeout);

      if (response.statusCode == HttpStatus.ok ||
          response.statusCode == HttpStatus.created ||
          response.statusCode == HttpStatus.accepted) {
        String? messageId;
        try {
          final decoded = jsonDecode(response.body) as Map<String, dynamic>;
          messageId = decoded['messageId'] as String?;
        } catch (_) {
          // If response body is not JSON or does not contain messageId
        }

        stdout.writeln(
          '[BrevoEmailService] Transactional email sent to ${maskEmail(recipientEmail)} (status: ${response.statusCode}, messageId: $messageId).',
        );
        return BrevoSendResult(
          success: true,
          messageId: messageId,
        );
      } else {
        String? errorCode;
        try {
          final decoded = jsonDecode(response.body) as Map<String, dynamic>;
          errorCode = decoded['code'] as String?;
        } catch (_) {
          // Do not expose provider response bodies to logs or callers.
        }

        final safeError = _describeProviderRejection(
          response.statusCode,
          errorCode,
        );
        stderr.writeln(
          '[BrevoEmailService] Failed to send email to ${maskEmail(recipientEmail)}. $safeError${errorCode == null ? '' : ' Provider code: $errorCode.'}',
        );

        return BrevoSendResult(
          success: false,
          error: safeError,
        );
      }
    } on TimeoutException {
      stderr.writeln(
        '[BrevoEmailService] Connection timed out after ${timeout.inSeconds}s when sending email to ${maskEmail(recipientEmail)}.',
      );
      return const BrevoSendResult(
        success: false,
        error: 'Connection timed out while contacting email service.',
      );
    } catch (_) {
      stderr.writeln(
        '[BrevoEmailService] Network or unexpected error sending email to ${maskEmail(recipientEmail)}.',
      );
      return BrevoSendResult(
        success: false,
        error: 'Unable to contact transactional email provider.',
      );
    }
  }

  static String _describeProviderRejection(int statusCode, String? code) {
    switch (statusCode) {
      case HttpStatus.unauthorized:
        return 'Brevo rejected the API key (HTTP 401). Check BREVO_API_KEY in the Serverpod runtime settings.';
      case HttpStatus.forbidden:
        return 'Brevo denied transactional email delivery (HTTP 403). Check the Brevo account and sending permissions.';
      case HttpStatus.badRequest:
        return 'Brevo rejected the email request (HTTP 400). Check that BREVO_SENDER_EMAIL is a verified Brevo sender and the request configuration is valid.';
      case HttpStatus.tooManyRequests:
        return 'Brevo rate limited the email request (HTTP 429). Retry after the provider limit resets.';
      default:
        if (statusCode >= 500) {
          return 'Brevo is temporarily unavailable (HTTP $statusCode). Retry later.';
        }
        return 'Brevo rejected the email request (HTTP $statusCode).${code == null ? '' : ' Provider code: $code.'}';
    }
  }

  /// Sends registration email verification code.
  Future<BrevoSendResult> sendRegistrationVerificationCode({
    required String recipientEmail,
    required String code,
    Duration expiration = const Duration(minutes: 15),
  }) async {
    final expMinutes = expiration.inMinutes;
    final subject = 'Verify your EquipLink account';

    final textContent =
        '''
Hello,

Welcome to EquipLink! Your email verification code is:

$code

This verification code will expire in $expMinutes minutes.

If you did not create an EquipLink account, please ignore this email.

— EquipLink Team
''';

    final htmlContent =
        '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>EquipLink Verification</title>
</head>
<body style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif; background-color: #f8fafc; margin: 0; padding: 24px; color: #1e293b;">
  <div style="max-width: 540px; margin: 0 auto; background: #ffffff; border-radius: 12px; border: 1px solid #e2e8f0; padding: 32px; box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);">
    <div style="text-align: center; margin-bottom: 24px;">
      <h1 style="color: #0f172a; margin: 0; font-size: 24px; font-weight: 700;">EquipLink</h1>
      <p style="color: #64748b; font-size: 14px; margin-top: 4px;">Campus Equipment Sharing Network</p>
    </div>
    <h2 style="font-size: 18px; color: #1e293b; margin-top: 0;">Verify your email address</h2>
    <p style="font-size: 15px; color: #475569; line-height: 1.5;">
      Use the following verification code to complete your EquipLink registration.
    </p>
    <div style="background: #f1f5f9; border-radius: 8px; padding: 18px; text-align: center; margin: 24px 0; border: 1px solid #cbd5e1;">
      <span style="font-family: 'Courier New', Courier, monospace; font-size: 32px; font-weight: 700; letter-spacing: 6px; color: #2563eb;">$code</span>
    </div>
    <p style="font-size: 13px; color: #64748b; line-height: 1.5;">
      This verification code is valid for <strong>$expMinutes minutes</strong>. Never share this code with anyone.
    </p>
    <hr style="border: none; border-top: 1px solid #e2e8f0; margin: 24px 0;">
    <p style="font-size: 12px; color: #94a3b8; text-align: center; margin: 0;">
      If you did not sign up for EquipLink, you can safely ignore this email.
    </p>
  </div>
</body>
</html>
''';

    return sendEmail(
      recipientEmail: recipientEmail,
      subject: subject,
      htmlContent: htmlContent,
      textContent: textContent,
      tags: const ['auth', 'registration', 'otp'],
      templateId: config.templateId,
    );
  }

  Future<BrevoSendResult> sendStudentEmailVerificationCode({
    required String recipientEmail,
    required String code,
    Duration expiration = const Duration(minutes: 10),
  }) {
    final minutes = expiration.inMinutes;
    return sendEmail(
      recipientEmail: recipientEmail,
      subject: 'Verify your EquipLink student email',
      htmlContent:
          '<p>Your EquipLink student email verification code is <strong>$code</strong>.</p><p>This code expires in $minutes minutes.</p>',
      textContent:
          'Your EquipLink student email verification code is $code. It expires in $minutes minutes.',
      tags: const ['student-email-verification'],
    );
  }

  /// Sends password reset verification code.
  Future<BrevoSendResult> sendPasswordResetVerificationCode({
    required String recipientEmail,
    required String code,
    Duration expiration = const Duration(minutes: 15),
  }) async {
    final expMinutes = expiration.inMinutes;
    final subject = 'Reset your EquipLink password';

    final textContent =
        '''
Hello,

A password reset request was received for your EquipLink account. Your verification code is:

$code

This verification code will expire in $expMinutes minutes.

If you did not request a password reset, please secure your account immediately or ignore this email.

— EquipLink Team
''';

    final htmlContent =
        '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Reset EquipLink Password</title>
</head>
<body style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif; background-color: #f8fafc; margin: 0; padding: 24px; color: #1e293b;">
  <div style="max-width: 540px; margin: 0 auto; background: #ffffff; border-radius: 12px; border: 1px solid #e2e8f0; padding: 32px; box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);">
    <div style="text-align: center; margin-bottom: 24px;">
      <h1 style="color: #0f172a; margin: 0; font-size: 24px; font-weight: 700;">EquipLink</h1>
      <p style="color: #64748b; font-size: 14px; margin-top: 4px;">Security & Account Recovery</p>
    </div>
    <h2 style="font-size: 18px; color: #1e293b; margin-top: 0;">Password Reset Request</h2>
    <p style="font-size: 15px; color: #475569; line-height: 1.5;">
      Use the verification code below to reset your password.
    </p>
    <div style="background: #fef2f2; border-radius: 8px; padding: 18px; text-align: center; margin: 24px 0; border: 1px solid #fecaca;">
      <span style="font-family: 'Courier New', Courier, monospace; font-size: 32px; font-weight: 700; letter-spacing: 6px; color: #dc2626;">$code</span>
    </div>
    <p style="font-size: 13px; color: #64748b; line-height: 1.5;">
      This code will expire in <strong>$expMinutes minutes</strong>. If you did not make this request, someone may be trying to access your account.
    </p>
    <hr style="border: none; border-top: 1px solid #e2e8f0; margin: 24px 0;">
    <p style="font-size: 12px; color: #94a3b8; text-align: center; margin: 0;">
      EquipLink Support — Never share your one-time passwords with anyone.
    </p>
  </div>
</body>
</html>
''';

    return sendEmail(
      recipientEmail: recipientEmail,
      subject: subject,
      htmlContent: htmlContent,
      textContent: textContent,
      tags: const ['auth', 'password-reset', 'otp'],
      templateId: config.templateId,
    );
  }

  /// Sends passwordless login OTP code.
  Future<BrevoSendResult> sendLoginOtpCode({
    required String recipientEmail,
    required String code,
    Duration expiration = const Duration(minutes: 10),
  }) async {
    final expMinutes = expiration.inMinutes;
    final subject = 'Your EquipLink sign-in code';

    final textContent =
        '''
Hello,

Your single-use sign-in code for EquipLink is:

$code

This code is valid for $expMinutes minutes and can only be used once.

If you did not request this login code, please ignore this email.

— EquipLink Team
''';

    final htmlContent =
        '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>EquipLink Sign-in Code</title>
</head>
<body style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif; background-color: #f8fafc; margin: 0; padding: 24px; color: #1e293b;">
  <div style="max-width: 540px; margin: 0 auto; background: #ffffff; border-radius: 12px; border: 1px solid #e2e8f0; padding: 32px; box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);">
    <div style="text-align: center; margin-bottom: 24px;">
      <h1 style="color: #0f172a; margin: 0; font-size: 24px; font-weight: 700;">EquipLink</h1>
      <p style="color: #64748b; font-size: 14px; margin-top: 4px;">Passwordless Access</p>
    </div>
    <h2 style="font-size: 18px; color: #1e293b; margin-top: 0;">Sign in to EquipLink</h2>
    <p style="font-size: 15px; color: #475569; line-height: 1.5;">
      Here is your single-use verification code to log in:
    </p>
    <div style="background: #eff6ff; border-radius: 8px; padding: 18px; text-align: center; margin: 24px 0; border: 1px solid #bfdbfe;">
      <span style="font-family: 'Courier New', Courier, monospace; font-size: 32px; font-weight: 700; letter-spacing: 6px; color: #1d4ed8;">$code</span>
    </div>
    <p style="font-size: 13px; color: #64748b; line-height: 1.5;">
      This single-use code is valid for <strong>$expMinutes minutes</strong>.
    </p>
    <hr style="border: none; border-top: 1px solid #e2e8f0; margin: 24px 0;">
    <p style="font-size: 12px; color: #94a3b8; text-align: center; margin: 0;">
      If you did not request this code, no action is needed. Your account is safe.
    </p>
  </div>
</body>
</html>
''';

    return sendEmail(
      recipientEmail: recipientEmail,
      subject: subject,
      htmlContent: htmlContent,
      textContent: textContent,
      tags: const ['auth', 'login-otp'],
      templateId: config.templateId,
    );
  }
}
