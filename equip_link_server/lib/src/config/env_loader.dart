import 'dart:io';

/// Simple, zero-dependency environment loader for `.env` files.
///
/// Loads environment variables from `.env` in the current working directory,
/// parent directory (workspace root), or the server directory.
/// Precedence: System environment (`Platform.environment`) ALWAYS takes precedence
/// over values defined in `.env` files.
class EnvLoader {
  static Map<String, String>? _cachedEnv;

  /// Loads and returns the environment map (merging system environment and .env files).
  static Map<String, String> load({Directory? baseDir}) {
    if (_cachedEnv != null) return _cachedEnv!;

    final map = <String, String>{};

    // Candidates for .env file location
    final candidates = [
      File('${baseDir?.path ?? Directory.current.path}/.env'),
      File('${baseDir?.path ?? Directory.current.path}/../.env'),
      File('${Directory.current.path}/equip_link_server/.env'),
    ];

    for (final file in candidates) {
      if (file.existsSync()) {
        try {
          final lines = file.readAsLinesSync();
          for (var line in lines) {
            line = line.trim();
            if (line.isEmpty || line.startsWith('#')) continue;

            final equalsIndex = line.indexOf('=');
            if (equalsIndex > 0) {
              final key = line.substring(0, equalsIndex).trim();
              var value = line.substring(equalsIndex + 1).trim();

              // Remove surrounding quotes if present
              if ((value.startsWith('"') && value.endsWith('"')) ||
                  (value.startsWith("'") && value.endsWith("'"))) {
                if (value.length >= 2) {
                  value = value.substring(1, value.length - 1);
                }
              }

              if (key.isNotEmpty) {
                map.putIfAbsent(key, () => value);
              }
            }
          }
          break; // Stop at the first found .env file
        } catch (_) {
          // Gracefully continue if file read encounters issues
        }
      }
    }

    // Merge system environment variables on top (system env vars have higher precedence)
    for (final entry in Platform.environment.entries) {
      map[entry.key] = entry.value;
    }

    _cachedEnv = map;
    return map;
  }

  /// Gets an environment variable by name. Checks loaded environment first.
  static String? get(String key, {Directory? baseDir}) {
    final env = load(baseDir: baseDir);
    return env[key];
  }

  /// Clears cache (useful for testing).
  static void resetCache() {
    _cachedEnv = null;
  }
}
