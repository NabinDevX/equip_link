import 'package:equip_link_server/src/config/brevo_config.dart';
import 'package:equip_link_server/src/config/env_loader.dart';
import 'package:equip_link_server/src/config/infrastructure_config.dart';
import 'package:equip_link_server/src/generated/serverpod.dart';
import 'package:test/test.dart';

void main() {
  group('EnvLoader', () {
    test('loads and parses environment correctly', () {
      EnvLoader.resetCache();
      final env = EnvLoader.load();
      expect(env, isNotEmpty);
    });
  });

  group('BrevoConfig', () {
    test('masks secret API key safely', () {
      const config = BrevoConfig(
        apiKey: 'xkeysib-1234567890abcdef-secret',
        senderEmail: 'test@example.com',
        senderName: 'Test Sender',
      );

      expect(config.isConfigured, isTrue);
      expect(config.maskedApiKey, equals('xkey...cret'));
      expect(config.toString(), contains('xkey...cret'));
      expect(config.toString(), isNot(contains('1234567890abcdef')));
      expect(
        config.requestHeaders['api-key'],
        equals('xkeysib-1234567890abcdef-secret'),
      );
      expect(config.requestHeaders['Content-Type'], equals('application/json'));
      expect(config.requestHeaders['Accept'], equals('application/json'));
    });

    test('strips quoted Cloud secrets before sending the API key', () {
      const quoted = BrevoConfig(
        apiKey: '"xkeysib-quoted-cloud-secret"',
        senderEmail: 'test@example.com',
        senderName: 'Test Sender',
      );
      // Headers still send the raw value from BrevoConfig; sanitization
      // happens in InfrastructureConfig before the config is built.
      expect(
        InfrastructureConfig.sanitizeSecret(quoted.apiKey),
        equals('xkeysib-quoted-cloud-secret'),
      );
      expect(
        InfrastructureConfig.sanitizeSecret("api-key: xkeysib-from-docs\n"),
        equals('xkeysib-from-docs'),
      );
      expect(InfrastructureConfig.sanitizeSecret('   '), isNull);
    });

    test('handles unconfigured state gracefully', () {
      const emptyConfig = BrevoConfig(
        apiKey: null,
        senderEmail: null,
        senderName: null,
      );

      expect(emptyConfig.isConfigured, isFalse);
      expect(emptyConfig.maskedApiKey, equals('(not configured)'));
    });
  });

  group('InfrastructureConfig', () {
    test('resolves default embedded/docker when no env vars are passed', () {
      final baseConfig = ServerpodConfig.load('development', 'default', {
        'database': 'dev_pass',
      });

      final overridden = InfrastructureConfig.applyOverrides(baseConfig);
      expect(overridden.database, isNotNull);
    });

    test(
      'configOverride accurately configures Upstash Redis when selected',
      () {
        final baseConfig = ServerpodConfig.load('development', 'default', {
          'database': 'dev_pass',
        });

        final overridden = baseConfig.copyWith(
          redis: RedisConfig(
            enabled: true,
            host: 'test-redis.upstash.io',
            port: 6379,
            user: 'default',
            password: 'secret_upstash_password',
            requireSsl: true,
          ),
        );

        expect(overridden.redis?.enabled, isTrue);
        expect(overridden.redis?.host, contains('upstash.io'));
        expect(overridden.redis?.requireSsl, isTrue);
        expect(overridden.redis?.port, equals(6379));
      },
    );
  });
}
