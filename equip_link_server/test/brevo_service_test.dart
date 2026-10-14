import 'dart:convert';

import 'package:equip_link_server/src/config/brevo_config.dart';
import 'package:equip_link_server/src/services/brevo_transactional_email_service.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  group('BrevoTransactionalEmailService', () {
    test(
      'sends email with correct endpoint, headers, and payload structure',
      () async {
        late Uri capturedUri;
        late Map<String, String> capturedHeaders;
        late Map<String, dynamic> capturedBody;

        final mockClient = MockClient((request) async {
          capturedUri = request.url;
          capturedHeaders = request.headers;
          capturedBody = jsonDecode(request.body) as Map<String, dynamic>;

          return http.Response(
            jsonEncode({'messageId': '<test-msg-12345@brevo.com>'}),
            201,
            headers: {'content-type': 'application/json'},
          );
        });

        const testConfig = BrevoConfig(
          apiKey: 'xkeysib-test-actual-key-value-999',
          senderEmail: 'auth@equiplink.com',
          senderName: 'EquipLink Verification',
        );

        final service = BrevoTransactionalEmailService(
          client: mockClient,
          config: testConfig,
        );

        final result = await service.sendRegistrationVerificationCode(
          recipientEmail: 'student@stanford.edu',
          code: '123456',
          expiration: const Duration(minutes: 15),
        );

        expect(result.success, isTrue);
        expect(result.messageId, equals('<test-msg-12345@brevo.com>'));

        // Validate Endpoint
        expect(
          capturedUri.toString(),
          equals('https://api.brevo.com/v3/smtp/email'),
        );

        // Validate Headers
        expect(
          capturedHeaders['api-key'],
          equals('xkeysib-test-actual-key-value-999'),
        );
        expect(capturedHeaders['Content-Type'], equals('application/json'));
        expect(capturedHeaders['Accept'], equals('application/json'));

        // Validate Payload
        expect(capturedBody['sender']['email'], equals('auth@equiplink.com'));
        expect(
          capturedBody['sender']['name'],
          equals('EquipLink Verification'),
        );
        expect(capturedBody['to'][0]['email'], equals('student@stanford.edu'));
        expect(
          capturedBody['subject'],
          equals('Verify your EquipLink account'),
        );
        expect(capturedBody['htmlContent'], contains('123456'));
        expect(capturedBody['textContent'], contains('123456'));
        expect(capturedBody['tags'], contains('registration'));
      },
    );

    test('handles Brevo HTTP error responses gracefully', () async {
      final mockClient = MockClient((request) async {
        return http.Response(
          jsonEncode({
            'code': 'unauthorized',
            'message': 'Key not recognized or account suspended',
          }),
          401,
          headers: {'content-type': 'application/json'},
        );
      });

      const testConfig = BrevoConfig(
        apiKey: 'xkeysib-invalid-key-example',
        senderEmail: 'auth@equiplink.com',
        senderName: 'EquipLink',
      );

      final service = BrevoTransactionalEmailService(
        client: mockClient,
        config: testConfig,
      );

      final result = await service.sendPasswordResetVerificationCode(
        recipientEmail: 'student@berkeley.edu',
        code: '654321',
      );

      expect(result.success, isFalse);
      expect(
        result.error,
        equals(
          'Brevo rejected the API key (HTTP 401). Check BREVO_API_KEY in the Serverpod runtime settings.',
        ),
      );
    });

    test('handles network timeouts safely without crashing', () async {
      final mockClient = MockClient((request) async {
        await Future.delayed(const Duration(milliseconds: 150));
        return http.Response('{}', 200);
      });

      const testConfig = BrevoConfig(
        apiKey: 'xkeysib-valid-looking-key',
        senderEmail: 'auth@equiplink.com',
        senderName: 'EquipLink',
      );

      final service = BrevoTransactionalEmailService(
        client: mockClient,
        config: testConfig,
        timeout: const Duration(milliseconds: 50),
      );

      final result = await service.sendLoginOtpCode(
        recipientEmail: 'user@mit.edu',
        code: '888999',
      );

      expect(result.success, isFalse);
      expect(result.error, contains('timed out'));
    });

    test(
      'reports configuration failure without making HTTP calls',
      () async {
        var callMade = false;
        final mockClient = MockClient((request) async {
          callMade = true;
          return http.Response('{}', 200);
        });

        const unconfigured = BrevoConfig(
          apiKey: null,
          senderEmail: null,
          senderName: null,
        );

        final service = BrevoTransactionalEmailService(
          client: mockClient,
          config: unconfigured,
        );

        final result = await service.sendRegistrationVerificationCode(
          recipientEmail: 'unconfigured@test.edu',
          code: '112233',
        );

        expect(callMade, isFalse);
        expect(result.success, isFalse);
        expect(result.error, contains('not configured'));
      },
    );

    test('sanitizes email addresses to prevent PII leakage in logs', () {
      expect(
        BrevoTransactionalEmailService.maskEmail('john.doe@university.edu'),
        equals('jo***@university.edu'),
      );
      expect(
        BrevoTransactionalEmailService.maskEmail('al@mit.edu'),
        equals('a***@mit.edu'),
      );
    });

    test(
      'formats login OTP, password reset, and registration subjects distinctly',
      () async {
        final subjects = <String>[];
        final mockClient = MockClient((request) async {
          final body = jsonDecode(request.body) as Map<String, dynamic>;
          subjects.add(body['subject'] as String);
          return http.Response(jsonEncode({'messageId': 'id'}), 200);
        });

        const testConfig = BrevoConfig(
          apiKey: 'xkeysib-valid-key',
          senderEmail: 'noreply@equiplink.com',
          senderName: 'EquipLink',
        );

        final service = BrevoTransactionalEmailService(
          client: mockClient,
          config: testConfig,
        );

        await service.sendRegistrationVerificationCode(
          recipientEmail: 'a@b.com',
          code: '111111',
        );
        await service.sendPasswordResetVerificationCode(
          recipientEmail: 'a@b.com',
          code: '222222',
        );
        await service.sendLoginOtpCode(
          recipientEmail: 'a@b.com',
          code: '333333',
        );

        expect(subjects.length, equals(3));
        expect(subjects[0], equals('Verify your EquipLink account'));
        expect(subjects[1], equals('Reset your EquipLink password'));
        expect(subjects[2], equals('Your EquipLink sign-in code'));
        expect(subjects.toSet().length, equals(3)); // Distinct subjects
      },
    );
  });
}
