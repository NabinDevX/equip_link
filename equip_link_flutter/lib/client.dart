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
  // Priority 1: Check SERVER_URL environment variable
  final fromEnv = String.fromEnvironment('SERVER_URL');
  final finalServerUrl = fromEnv.isNotEmpty
      ? fromEnv
      : await serverUrl;

  client = Client(finalServerUrl)
    ..connectivityMonitor = FlutterConnectivityMonitor()
    ..authSessionManager = FlutterAuthSessionManager();
  await client.auth.initialize();

  // Android Google Sign-In requires the OAuth Web client ID to be supplied as
  // the serverClientId. Keep it as a public build-time value; the matching
  // client secret stays on the Serverpod server.
  const googleServerClientId = String.fromEnvironment(
    'GOOGLE_SERVER_CLIENT_ID',
  );
  if (googleServerClientId.isNotEmpty) {
    await client.auth.initializeGoogleSignIn(
      serverClientId: googleServerClientId,
    );
  }
}
