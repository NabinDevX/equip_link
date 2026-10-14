import 'package:equip_link_server/src/generated/serverpod.dart';
import 'package:test/test.dart';

void main() {
  test('verify configOverride propagates to pod.config', () {
    final pod = Serverpod(
      ['--mode', 'development'],
      configOverride: (config) {
        final db = DatabaseConfig(
          host: 'neon.custom.host',
          port: 5432,
          name: 'custom_db',
          user: 'custom_user',
          password: 'custom_password',
          requireSsl: true,
        );
        return config.copyWith(database: db);
      },
    );

    expect(pod.config.database?.host, equals('neon.custom.host'));
    expect(pod.config.database?.port, equals(5432));
    expect(pod.config.database?.name, equals('custom_db'));
    expect(pod.config.database?.user, equals('custom_user'));
    expect(pod.config.database?.requireSsl, isTrue);
  });
}
