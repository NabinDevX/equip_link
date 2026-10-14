/// Configuration for Brevo Transactional Email service.
///
/// Brevo sends transactional verification and authentication emails.
/// Uses endpoint: POST https://api.brevo.com/v3/smtp/email
class BrevoConfig {
  static const String defaultEndpoint = 'https://api.brevo.com/v3/smtp/email';

  /// The Brevo API secret key. Must remain server-side and never be exposed to clients.
  final String? apiKey;

  /// Verified sender email registered in Brevo.
  final String? senderEmail;

  /// Display name for the sender.
  final String? senderName;

  /// Optional Brevo transactional template ID for OTP/verification emails.
  final int? templateId;

  const BrevoConfig({
    required this.apiKey,
    required this.senderEmail,
    required this.senderName,
    this.templateId,
  });

  /// Whether all required settings to send emails are configured.
  bool get isConfigured =>
      apiKey != null &&
      apiKey!.trim().isNotEmpty &&
      senderEmail != null &&
      senderEmail!.trim().isNotEmpty;

  /// Masked API key safe for logging and diagnostics (e.g. `xkey...yleS`).
  String get maskedApiKey {
    if (apiKey == null || apiKey!.isEmpty) return '(not configured)';
    final key = apiKey!;
    if (key.length <= 8) return '****';
    return '${key.substring(0, 4)}...${key.substring(key.length - 4)}';
  }

  /// Headers required for Brevo API requests.
  Map<String, String> get requestHeaders => {
    'api-key': apiKey ?? '',
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  @override
  String toString() {
    return 'BrevoConfig(sender: $senderName <$senderEmail>, apiKey: $maskedApiKey, templateId: $templateId, configured: $isConfigured)';
  }
}
