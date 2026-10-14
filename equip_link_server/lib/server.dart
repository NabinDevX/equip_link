import 'dart:io';

import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';
import 'package:serverpod_auth_idp_server/providers/google.dart';
import 'package:serverpod_cloud_storage/serverpod_cloud_storage.dart';

import 'src/cache_busting.dart';
import 'src/config/infrastructure_config.dart';
import 'src/generated/serverpod.dart';
import 'src/generated/protocol.dart';
import 'src/services/brevo_transactional_email_service.dart';
import 'src/web/routes/app_config_route.dart';

Future<void> _sendBrevoEmailOrThrow(Future<BrevoSendResult> send) async {
  final result = await send;
  if (!result.success) {
    // A plain StateError is treated by Serverpod as an unhandled exception
    // and returned as HTTP 500. This modeled exception is serialized for the
    // client and contains only the provider's safe, credential-free message.
    throw EquipLinkException(
      message:
          result.error ??
          'Unable to send a verification email. '
              'Check the server email configuration and try again.',
      statusCode: 503,
    );
  }
}

/// The starting point of the Serverpod server.
void run(List<String> args) async {
  // Initialize Serverpod with infrastructure config overrides for external/docker providers.
  final pod = Serverpod(
    args,
    configOverride: (config) => InfrastructureConfig.applyOverrides(config),
  );

  // Validate configuration and log masked diagnostics at startup
  InfrastructureConfig.validateAndLog(pod);
  // Use the same resolved configuration as startup validation. In Serverpod
  // Cloud, BREVO_API_KEY may be stored in the Serverpod password store rather
  // than the process environment, so the email service must receive the pod
  // when resolving its credentials.
  BrevoTransactionalEmailService.instance = BrevoTransactionalEmailService(
    config: InfrastructureConfig.getBrevoConfig(pod: pod),
  );
  final googleClientSecretJson = _googleClientSecretJson(pod);
  if (googleClientSecretJson == null || googleClientSecretJson.trim().isEmpty) {
    stderr.writeln(
      '[WARN] Google sign-in is disabled. Configure GOOGLE_CLIENT_SECRET_JSON '
      'or the Serverpod password googleClientSecret in the deployed server.',
    );
  }

  // Initialize authentication services for the server.
  // Token managers will be used to validate and issue authentication keys,
  // and the identity providers will be the authentication options available for users.
  pod.initializeAuthServices(
    tokenManagerBuilders: [
      // Use JWT for authentication keys towards the server.
      JwtConfigFromPasswords(),
    ],
    identityProviderBuilders: [
      // Configure email identity provider with Brevo transactional email delivery.
      EmailIdpConfigFromPasswords(
        registrationVerificationCodeLifetime: const Duration(minutes: 15),
        registrationVerificationCodeAllowedAttempts: 5,
        passwordResetVerificationCodeLifetime: const Duration(minutes: 15),
        passwordResetVerificationCodeAllowedAttempts: 5,
        sendRegistrationVerificationCode:
            (
              session, {
              required email,
              required accountRequestId,
              required verificationCode,
              required transaction,
            }) async {
              await _sendBrevoEmailOrThrow(
                BrevoTransactionalEmailService.instance
                    .sendRegistrationVerificationCode(
                      recipientEmail: email,
                      code: verificationCode,
                    ),
              );
            },
        sendPasswordResetVerificationCode:
            (
              session, {
              required email,
              required passwordResetRequestId,
              required verificationCode,
              required transaction,
            }) async {
              await _sendBrevoEmailOrThrow(
                BrevoTransactionalEmailService.instance
                    .sendPasswordResetVerificationCode(
                      recipientEmail: email,
                      code: verificationCode,
                    ),
              );
            },
      ),
      if (googleClientSecretJson != null &&
          googleClientSecretJson.trim().isNotEmpty)
        GoogleIdpConfig(
          clientSecret: GoogleClientSecret.fromJsonString(
            googleClientSecretJson,
          ),
          onAfterGoogleAccountCreated:
              (session, authUser, googleAccount, {transaction}) async {
                final existing = await StudentIdentity.db.find(
                  session,
                  where: (t) => t.authUserId.equals(authUser.id),
                  limit: 1,
                  transaction: transaction,
                );
                if (existing.isEmpty) {
                  final now = DateTime.now();
                  await StudentIdentity.db.insertRow(
                    session,
                    StudentIdentity(
                      authUserId: authUser.id,
                      googleProviderIdentity: googleAccount.userIdentifier,
                      emailVerified: false,
                      eligibilityStatus: 'pending',
                      createdAt: now,
                      updatedAt: now,
                    ),
                    transaction: transaction,
                  );
                }
              },
        ),
    ],
  );

  // Serve all files in the web/static relative directory under /web.
  // These are used by the default web page.
  pod.webServer.addRoute(
    StaticRoute.withCacheBusting(cacheBustingConfig),
    cacheBustingConfig.mountPrefix,
  );

  // Setup the app config route.
  // We build this configuration based on the servers api url and serve it to
  // the flutter app.
  pod.webServer.addRoute(
    AppConfigRoute(apiConfig: pod.config.apiServer),
    '/assets/assets/config.json',
  );

  // Checks if the flutter web app has been built and serves it if it has.
  final appDir = Directory(Uri(path: 'web/app').toFilePath());
  if (appDir.existsSync()) {
    // Serve the flutter web app under /.
    pod.webServer.addRoute(
      FlutterRoute(
        appDir,
        // If building the Flutter app with WASM, set the below parameter to
        // true and add the --wasm flag to the flutter build command.
        enableWasmHeaders: false,
      ),
      '/',
    );
  } else {
    // If the flutter web app has not been built, serve the build app page.
    final defaultRoute = StaticRoute.file(
      File(
        Uri(path: 'web/pages/build_flutter_app.html').toFilePath(),
      ),
    );

    pod.webServer.addMiddleware(
      FallbackMiddleware(
        fallback: defaultRoute,
        on: (response) => response.statusCode == 404,
      ).call,
      '/',
    );

    pod.webServer.addRoute(
      defaultRoute,
      '/**',
    );
  }

  // Configure cloud storage.
  // This setup works with Serverpod Cloud without extra configuration.
  // If you want to use a custom provider for cloud storage, replace these
  // with your preferred provider.
  pod.addCloudStorage(
    await ServerpodCloudProvider.private(
      fallback: () => DatabaseCloudStorage('private'),
    ),
  );
  pod.addCloudStorage(
    await ServerpodCloudProvider.public(
      fallback: () => DatabaseCloudStorage('public'),
    ),
  );

  // Start the server.
  await pod.start();
}

String? _googleClientSecretJson(Serverpod pod) {
  // Read from the environment first so credentials never need to be stored
  // in application source files. Serverpod's password store remains a
  // supported fallback for deployments that manage secrets through it.
  return InfrastructureConfig.getEnv('SERVERPOD_PASSWORD_googleClientSecret') ??
      InfrastructureConfig.getEnv('GOOGLE_CLIENT_SECRET_JSON') ??
      pod.getPassword('googleClientSecret');
}
