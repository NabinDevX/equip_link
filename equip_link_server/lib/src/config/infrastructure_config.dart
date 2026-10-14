import 'dart:io';

import 'package:serverpod/serverpod.dart';

import 'brevo_config.dart';
import 'env_loader.dart';

/// Database provider options for EquipLink.
enum DatabaseProvider {
  neon,
  docker,
  embedded,
  custom,
}

/// Redis provider options for EquipLink.
enum RedisProvider {
  upstash,
  docker,
  none,
  custom,
}

/// Central infrastructure and environment configuration manager for Serverpod 4.0.4.
///
/// Handles environment variables, secret loading, provider switching (Neon, Upstash, Docker),
/// and startup validation without exposing credentials.
class InfrastructureConfig {
  static Uri? _connectionUri(String key) {
    final value = getEnv(key)?.trim();
    if (value == null || value.isEmpty) return null;

    final uri = Uri.tryParse(value);
    if (uri == null || uri.scheme.isEmpty || uri.host.isEmpty) {
      throw FormatException(
        '$key must be a valid connection string with a scheme and host.',
      );
    }
    return uri;
  }

  static String _requiredUserInfo(Uri uri, String key) {
    if (uri.userInfo.isEmpty) {
      throw FormatException('$key must include a username and password.');
    }
    final separator = uri.userInfo.indexOf(':');
    if (separator <= 0 || separator == uri.userInfo.length - 1) {
      throw FormatException('$key must include a username and password.');
    }
    return Uri.decodeComponent(uri.userInfo.substring(0, separator));
  }

  static String _passwordFromUserInfo(Uri uri, String key) {
    final separator = uri.userInfo.indexOf(':');
    if (separator < 0 || separator == uri.userInfo.length - 1) {
      throw FormatException('$key must include a username and password.');
    }
    return Uri.decodeComponent(uri.userInfo.substring(separator + 1));
  }

  static String? _redisUser(Uri uri, String key) {
    if (uri.userInfo.isEmpty) return null;
    final separator = uri.userInfo.indexOf(':');
    if (separator < 0) {
      throw FormatException('$key must include a password after the username.');
    }
    final user = uri.userInfo.substring(0, separator);
    return user.isEmpty ? null : Uri.decodeComponent(user);
  }

  static String _databaseName(Uri uri) {
    final path = uri.pathSegments;
    return path.isEmpty || path.first.isEmpty
        ? 'equip_link'
        : Uri.decodeComponent(path.first);
  }

  static bool _usesSsl(Uri uri, {required bool defaultValue}) {
    final sslMode = uri.queryParameters['sslmode']?.toLowerCase();
    if (sslMode == 'disable') return false;
    if (sslMode == 'require' ||
        sslMode == 'verify-ca' ||
        sslMode == 'verify-full') {
      return true;
    }
    return uri.scheme.toLowerCase() == 'rediss' || defaultValue;
  }

  /// Reads an environment variable checking system environment, loaded .env file,
  /// and case variations.
  static String? getEnv(String key, {Map<String, String>? passwords}) {
    // 1. Direct from EnvLoader (which merges Platform.environment and .env)
    final val = EnvLoader.get(key);
    if (val != null && val.isNotEmpty) return val;

    // 2. Check uppercase variation
    final upperVal = EnvLoader.get(key.toUpperCase());
    if (upperVal != null && upperVal.isNotEmpty) return upperVal;

    // 3. Check lowercase variation
    final lowerVal = EnvLoader.get(key.toLowerCase());
    if (lowerVal != null && lowerVal.isNotEmpty) return lowerVal;

    // 4. Check passwords map if provided
    if (passwords != null) {
      if (passwords[key] != null) return passwords[key];
      if (passwords[key.toUpperCase()] != null) {
        return passwords[key.toUpperCase()];
      }
    }

    return null;
  }

  /// Determines the active database provider.
  static DatabaseProvider resolveDatabaseProvider() {
    final raw = (getEnv('DATABASE_PROVIDER') ?? '').trim().toLowerCase();
    switch (raw) {
      case 'neon':
        return DatabaseProvider.neon;
      case 'docker':
        return DatabaseProvider.docker;
      case 'embedded':
        return DatabaseProvider.embedded;
      case 'custom':
        return DatabaseProvider.custom;
      default:
        final connection = _connectionUri('DATABASE_URL');
        if (connection != null) {
          if (connection.host.contains('neon.tech')) {
            return DatabaseProvider.neon;
          }
          return DatabaseProvider.custom;
        }
        // If a custom DATABASE_HOST is specified, treat as custom/neon if host ends with neon.tech
        final host =
            getEnv('DATABASE_HOST') ?? getEnv('SERVERPOD_DATABASE_HOST');
        if (host != null && host.isNotEmpty) {
          if (host.contains('neon.tech')) return DatabaseProvider.neon;
          return DatabaseProvider.custom;
        }
        return DatabaseProvider.embedded;
    }
  }

  /// Determines the active Redis provider.
  static RedisProvider resolveRedisProvider() {
    final raw = (getEnv('REDIS_PROVIDER') ?? '').trim().toLowerCase();
    switch (raw) {
      case 'upstash':
        return RedisProvider.upstash;
      case 'docker':
        return RedisProvider.docker;
      case 'none':
        return RedisProvider.none;
      case 'custom':
        return RedisProvider.custom;
      default:
        final connection = _connectionUri('REDIS_URL');
        if (connection != null) {
          if (connection.host.contains('upstash.io')) {
            return RedisProvider.upstash;
          }
          return RedisProvider.custom;
        }
        final host = getEnv('REDIS_HOST') ?? getEnv('SERVERPOD_REDIS_HOST');
        if (host != null && host.isNotEmpty) {
          if (host.contains('upstash.io')) return RedisProvider.upstash;
          return RedisProvider.custom;
        }
        return RedisProvider.none;
    }
  }

  /// Resolves Brevo transactional email configuration.
  static BrevoConfig getBrevoConfig({
    Serverpod? pod,
    Map<String, String>? passwords,
  }) {
    final apiKey =
        getEnv('BREVO_API_KEY', passwords: passwords) ??
        getEnv('BREVO_API', passwords: passwords) ??
        getEnv('SERVERPOD_PASSWORD_BREVO_API_KEY', passwords: passwords) ??
        pod?.getPassword('brevoApiKey') ??
        pod?.getPassword('BREVO_API_KEY') ??
        pod?.getPassword('BREVO_API');

    final senderEmail = getEnv('BREVO_SENDER_EMAIL') ?? 'noreply@equiplink.com';
    final senderName = getEnv('BREVO_SENDER_NAME') ?? 'EquipLink';
    final templateIdStr = getEnv('BREVO_TEMPLATE_ID');
    final templateId = templateIdStr != null
        ? int.tryParse(templateIdStr)
        : null;

    return BrevoConfig(
      apiKey: apiKey,
      senderEmail: senderEmail,
      senderName: senderName,
      templateId: templateId,
    );
  }

  /// Applies environment and provider overrides to the loaded [ServerpodConfig].
  ///
  /// This function is intended to be passed into `Serverpod(args, configOverride: ...)`
  /// to dynamically configure database and Redis connections.
  static ServerpodConfig applyOverrides(
    ServerpodConfig baseConfig, {
    Map<String, String>? passwords,
  }) {
    var db = baseConfig.database;
    var redis = baseConfig.redis;

    final dbProvider = resolveDatabaseProvider();
    final redisProvider = resolveRedisProvider();

    // 1. Configure Database
    final databaseUrl = _connectionUri('DATABASE_URL');
    switch (dbProvider) {
      case DatabaseProvider.neon:
        if (databaseUrl != null) {
          db = DatabaseConfig(
            host: databaseUrl.host,
            port: databaseUrl.hasPort ? databaseUrl.port : 5432,
            name: _databaseName(databaseUrl),
            user: _requiredUserInfo(databaseUrl, 'DATABASE_URL'),
            password: _passwordFromUserInfo(databaseUrl, 'DATABASE_URL'),
            requireSsl: true,
          );
          break;
        }
        final host =
            getEnv('DATABASE_HOST') ?? getEnv('SERVERPOD_DATABASE_HOST') ?? '';
        final port =
            int.tryParse(
              getEnv('DATABASE_PORT') ??
                  getEnv('SERVERPOD_DATABASE_PORT') ??
                  '',
            ) ??
            5432;
        final name =
            getEnv('DATABASE_NAME') ??
            getEnv('SERVERPOD_DATABASE_NAME') ??
            'equip_link';
        final user =
            getEnv('DATABASE_USER') ??
            getEnv('SERVERPOD_DATABASE_USER') ??
            'neondb_owner';
        final password =
            getEnv('DATABASE_PASSWORD') ??
            getEnv('SERVERPOD_DATABASE_PASSWORD') ??
            getEnv('SERVERPOD_PASSWORD_database') ??
            db?.password ??
            '';

        if (host.isNotEmpty) {
          db = DatabaseConfig(
            host: host,
            port: port,
            name: name,
            user: user,
            password: password,
            requireSsl: true, // Neon requires SSL/TLS
          );
        }
        break;

      case DatabaseProvider.docker:
        if (databaseUrl != null) {
          db = DatabaseConfig(
            host: databaseUrl.host,
            port: databaseUrl.hasPort ? databaseUrl.port : 5432,
            name: _databaseName(databaseUrl),
            user: _requiredUserInfo(databaseUrl, 'DATABASE_URL'),
            password: _passwordFromUserInfo(databaseUrl, 'DATABASE_URL'),
            requireSsl: _usesSsl(databaseUrl, defaultValue: false),
          );
          break;
        }
        final host = getEnv('DATABASE_HOST') ?? 'localhost';
        final port = int.tryParse(getEnv('DATABASE_PORT') ?? '') ?? 8090;
        final name = getEnv('DATABASE_NAME') ?? 'equip_link';
        final user = getEnv('DATABASE_USER') ?? 'postgres';
        final password =
            getEnv('DATABASE_PASSWORD') ??
            getEnv('SERVERPOD_DATABASE_PASSWORD') ??
            db?.password ??
            '';

        db = DatabaseConfig(
          host: host,
          port: port,
          name: name,
          user: user,
          password: password,
          requireSsl: false,
        );
        break;

      case DatabaseProvider.custom:
        if (databaseUrl != null) {
          db = DatabaseConfig(
            host: databaseUrl.host,
            port: databaseUrl.hasPort ? databaseUrl.port : 5432,
            name: _databaseName(databaseUrl),
            user: _requiredUserInfo(databaseUrl, 'DATABASE_URL'),
            password: _passwordFromUserInfo(databaseUrl, 'DATABASE_URL'),
            requireSsl: _usesSsl(databaseUrl, defaultValue: false),
          );
          break;
        }
        final host =
            getEnv('DATABASE_HOST') ?? getEnv('SERVERPOD_DATABASE_HOST');
        if (host != null && host.isNotEmpty) {
          final port =
              int.tryParse(
                getEnv('DATABASE_PORT') ??
                    getEnv('SERVERPOD_DATABASE_PORT') ??
                    '',
              ) ??
              5432;
          final name =
              getEnv('DATABASE_NAME') ??
              getEnv('SERVERPOD_DATABASE_NAME') ??
              db?.name ??
              'equip_link';
          final user =
              getEnv('DATABASE_USER') ??
              getEnv('SERVERPOD_DATABASE_USER') ??
              db?.user ??
              'postgres';
          final password =
              getEnv('DATABASE_PASSWORD') ??
              getEnv('SERVERPOD_DATABASE_PASSWORD') ??
              db?.password ??
              '';
          final requireSsl =
              (getEnv('DATABASE_REQUIRE_SSL') ??
                      getEnv('SERVERPOD_DATABASE_REQUIRE_SSL'))
                  ?.toLowerCase() ==
              'true';

          db = DatabaseConfig(
            host: host,
            port: port,
            name: name,
            user: user,
            password: password,
            requireSsl: requireSsl,
          );
        }
        break;

      case DatabaseProvider.embedded:
        // Keep base configuration as loaded from YAML
        break;
    }

    // 2. Configure Redis
    final redisUrl = _connectionUri('REDIS_URL');
    switch (redisProvider) {
      case RedisProvider.upstash:
        if (redisUrl != null) {
          redis = RedisConfig(
            enabled: true,
            host: redisUrl.host,
            port: redisUrl.hasPort ? redisUrl.port : 6379,
            user: _requiredUserInfo(redisUrl, 'REDIS_URL'),
            password: _passwordFromUserInfo(redisUrl, 'REDIS_URL'),
            requireSsl: true,
          );
          break;
        }
        final host =
            getEnv('REDIS_HOST') ?? getEnv('SERVERPOD_REDIS_HOST') ?? '';
        final port =
            int.tryParse(
              getEnv('REDIS_PORT') ?? getEnv('SERVERPOD_REDIS_PORT') ?? '',
            ) ??
            6379;
        final user =
            getEnv('REDIS_USERNAME') ??
            getEnv('REDIS_USER') ??
            getEnv('SERVERPOD_REDIS_USER') ??
            'default';
        final password =
            getEnv('REDIS_PASSWORD') ??
            getEnv('SERVERPOD_REDIS_PASSWORD') ??
            getEnv('SERVERPOD_PASSWORD_redis') ??
            redis?.password ??
            '';

        if (host.isNotEmpty) {
          redis = RedisConfig(
            enabled: true,
            host: host,
            port: port,
            user: user,
            password: password,
            requireSsl: true, // Upstash requires TLS
          );
        }
        break;

      case RedisProvider.docker:
        if (redisUrl != null) {
          redis = RedisConfig(
            enabled: true,
            host: redisUrl.host,
            port: redisUrl.hasPort ? redisUrl.port : 6379,
            user: _redisUser(redisUrl, 'REDIS_URL'),
            password: redisUrl.userInfo.isEmpty
                ? null
                : _passwordFromUserInfo(redisUrl, 'REDIS_URL'),
            requireSsl: _usesSsl(redisUrl, defaultValue: false),
          );
          break;
        }
        final host = getEnv('REDIS_HOST') ?? 'localhost';
        final port = int.tryParse(getEnv('REDIS_PORT') ?? '') ?? 8091;
        final password =
            getEnv('REDIS_PASSWORD') ??
            getEnv('SERVERPOD_REDIS_PASSWORD') ??
            redis?.password ??
            '';

        redis = RedisConfig(
          enabled: true,
          host: host,
          port: port,
          password: password,
          requireSsl: false,
        );
        break;

      case RedisProvider.none:
        redis = RedisConfig(
          enabled: false,
          host: 'localhost',
          port: 6379,
        );
        break;

      case RedisProvider.custom:
        if (redisUrl != null) {
          redis = RedisConfig(
            enabled: true,
            host: redisUrl.host,
            port: redisUrl.hasPort ? redisUrl.port : 6379,
            user: _redisUser(redisUrl, 'REDIS_URL'),
            password: redisUrl.userInfo.isEmpty
                ? null
                : _passwordFromUserInfo(redisUrl, 'REDIS_URL'),
            requireSsl: _usesSsl(redisUrl, defaultValue: false),
          );
          break;
        }
        final host = getEnv('REDIS_HOST') ?? getEnv('SERVERPOD_REDIS_HOST');
        if (host != null && host.isNotEmpty) {
          final port =
              int.tryParse(
                getEnv('REDIS_PORT') ?? getEnv('SERVERPOD_REDIS_PORT') ?? '',
              ) ??
              6379;
          final user =
              getEnv('REDIS_USERNAME') ??
              getEnv('REDIS_USER') ??
              getEnv('SERVERPOD_REDIS_USER');
          final password =
              getEnv('REDIS_PASSWORD') ??
              getEnv('SERVERPOD_REDIS_PASSWORD') ??
              redis?.password ??
              '';
          final requireSsl =
              (getEnv('REDIS_REQUIRE_SSL') ??
                      getEnv('SERVERPOD_REDIS_REQUIRE_SSL'))
                  ?.toLowerCase() ==
              'true';

          redis = RedisConfig(
            enabled: true,
            host: host,
            port: port,
            user: user,
            password: password,
            requireSsl: requireSsl,
          );
        }
        break;
    }

    return baseConfig.copyWith(
      database: db,
      redis: redis,
    );
  }

  /// Helper to safely mask a hostname or connection string
  static String _maskHost(String? host) {
    if (host == null || host.isEmpty) return '(none)';
    if (host == 'localhost' || host == '127.0.0.1') return host;
    final parts = host.split('.');
    if (parts.length > 2) {
      return '${parts.first.substring(0, 3)}***.${parts.sublist(1).join('.')}';
    }
    return '${host.substring(0, 2)}***';
  }

  /// Validates configuration and logs a safe, masked startup summary.
  ///
  /// Never displays passwords or API keys.
  static void validateAndLog(Serverpod pod) {
    final dbProvider = resolveDatabaseProvider();
    final redisProvider = resolveRedisProvider();
    final db = pod.config.database;
    final redis = pod.config.redis;
    final brevo = getBrevoConfig(pod: pod);

    stdout.writeln('======================================================');
    stdout.writeln(' EquipLink Infrastructure Configuration');
    stdout.writeln('======================================================');
    stdout.writeln(' Mode:             ${pod.runMode}');
    stdout.writeln(' Database:');
    stdout.writeln('   Provider:       $dbProvider');
    if (db != null) {
      stdout.writeln('   Host:           ${_maskHost(db.host)}:${db.port}');
      stdout.writeln('   Database:       ${db.name}');
      stdout.writeln('   User:           ${db.user}');
      stdout.writeln('   SSL/TLS:        ${db.requireSsl}');
      stdout.writeln('   Password set:   ${db.password.isNotEmpty}');
    } else {
      stdout.writeln('   Status:         Disabled / Not configured');
    }

    stdout.writeln(' Redis:');
    stdout.writeln('   Provider:       $redisProvider');
    if (redis != null && redis.enabled) {
      stdout.writeln(
        '   Host:           ${_maskHost(redis.host)}:${redis.port}',
      );
      stdout.writeln('   SSL/TLS:        ${redis.requireSsl}');
      stdout.writeln('   Password set:   ${(redis.password ?? '').isNotEmpty}');
    } else {
      stdout.writeln('   Status:         Disabled');
    }

    stdout.writeln(' Email (Brevo):');
    stdout.writeln('   Configured:     ${brevo.isConfigured}');
    stdout.writeln(
      '   Sender:         ${brevo.senderName} <${brevo.senderEmail}>',
    );
    stdout.writeln('   API Key:        ${brevo.maskedApiKey}');
    stdout.writeln('======================================================');

    // Startup validations & warnings
    if (dbProvider == DatabaseProvider.neon) {
      if (db == null || db.host.isEmpty) {
        stderr.writeln(
          '[WARN] Neon database selected but DATABASE_URL is not set!',
        );
      } else if (db.password.isEmpty) {
        stderr.writeln(
          '[WARN] Neon database connection string has no password!',
        );
      }
      if (db != null && db.host.contains('-pooler')) {
        stdout.writeln(
          '[NOTE] Neon pooled endpoint detected. For database migrations, use the direct endpoint.',
        );
      }
    }

    if (redisProvider == RedisProvider.upstash) {
      if (redis == null || redis.host.isEmpty) {
        stderr.writeln(
          '[WARN] Upstash Redis selected but REDIS_URL is not set!',
        );
      } else if ((redis.password ?? '').isEmpty) {
        stderr.writeln(
          '[WARN] Upstash Redis connection string has no password!',
        );
      }
    }

    if (!brevo.isConfigured) {
      stdout.writeln(
        '[INFO] Brevo transactional email is not fully configured yet. Email authentication will use fallback.',
      );
    }
  }
}
