import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:equip_link_client/equip_link_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

// When you are running the app on a physical device, you need to set the
// server URL to the IP address of your computer. You can find the IP
// address by running `ipconfig` on Windows or `ifconfig` on Mac/Linux.
//
// You can set the variable when running or building your app like this:
// E.g. `flutter run --dart-define=SERVER_URL=https://api.example.com/`.
//
// Otherwise, the server URL is fetched from the assets/config.json file or
// defaults to http://$localhost:8080/ if not found.
final serverUrl = getServerUrl();

/// Sets up a global client object that can be used to talk to the server from
/// anywhere in our app. The client is generated from your server code
/// and is set up to connect to a Serverpod running on a local server on
/// the default port. You will need to modify this to connect to staging or
/// production servers.
///
/// Priority for server URL:
/// 1. SERVER_URL environment variable (highest priority)
/// 2. config.json file in assets/
/// 3. Default to deployed cloud server: https://nabindev.api.serverpod.space
late final Client client;

final serverpodClientProvider = Provider<Client>((ref) {
  return client;
});

Future<void> initializeClient() async {
  // Priority 1: an explicit build-time URL (required for a physical phone).
  final fromEnv = String.fromEnvironment('SERVER_URL');
  final String finalServerUrl;
  if (fromEnv.isNotEmpty) {
    finalServerUrl = _normalizeServerUrl(fromEnv);
  } else if (kDebugMode) {
    // Android emulators reach the host computer through 10.0.2.2. A physical
    // Android device must use the computer's LAN address via SERVER_URL.
    finalServerUrl = defaultTargetPlatform == TargetPlatform.android
        ? 'http://10.0.2.2:8080/'
        : 'http://localhost:8080/';
  } else {
    finalServerUrl = await serverUrl;
  }

  client = Client(finalServerUrl)
    ..connectivityMonitor = FlutterConnectivityMonitor()
    ..authSessionManager = FlutterAuthSessionManager();
  await client.auth.initialize();

  // Android Google Sign-In requires the public OAuth Web client ID as the
  // serverClientId. Build defines override the checked-in app config; the
  // matching client secret stays on the Serverpod server.
  const buildGoogleServerClientId = String.fromEnvironment(
    'GOOGLE_SERVER_CLIENT_ID',
  );
  final googleServerClientId = buildGoogleServerClientId.isNotEmpty
      ? buildGoogleServerClientId
      : await _googleServerClientIdFromAsset();
  if (googleServerClientId.isNotEmpty) {
    await client.auth.initializeGoogleSignIn(
      serverClientId: googleServerClientId,
    );
  }
}

String _normalizeServerUrl(String value) {
  final trimmed = value.trim();
  return trimmed.endsWith('/') ? trimmed : '$trimmed/';
}

Future<String> _googleServerClientIdFromAsset() async {
  try {
    final config = jsonDecode(
      await rootBundle.loadString('assets/config.json'),
    );
    if (config is Map<String, dynamic>) {
      return config['googleServerClientId'] as String? ?? '';
    }
  } on Object catch (error) {
    debugPrint('Unable to read Google sign-in configuration: $error');
  }
  return '';
}
