# EquipLink

EquipLink is an Android app for student-to-student equipment rentals. The
Flutter app communicates with a Serverpod backend. The deployed backend API is:

**https://nabindev.api.serverpod.space/**

## Requirements

- Flutter and Dart SDKs compatible with the workspace `pubspec.yaml`
- Android Studio or Android SDK platform tools
- An Android device with Developer options and USB debugging enabled, or an
  Android emulator
- Docker Desktop for local PostgreSQL and Redis
- The Serverpod CLI for running the local backend

From PowerShell at the repository root, check that Flutter sees the device:

```powershell
flutter devices
```

## Run the Android app against the deployed API

The Flutter app does not load `.env` by itself. The commands below read only
the two Flutter build values from the root `.env` and pass them as Dart defines.
Make sure `.env` contains `EQUIPLINK_API_URL` and
`GOOGLE_SERVER_CLIENT_ID` first. Do not commit `.env`.

```powershell
cd D:\Projects\equip_link

$apiLine = Get-Content .env | Where-Object { $_ -match '^\s*EQUIPLINK_API_URL\s*=' } | Select-Object -First 1
$googleLine = Get-Content .env | Where-Object { $_ -match '^\s*GOOGLE_SERVER_CLIENT_ID\s*=' } | Select-Object -First 1
$apiUrl = ($apiLine -replace '^\s*EQUIPLINK_API_URL\s*=\s*', '').Trim().Trim('"').Trim("'")
$googleClientId = ($googleLine -replace '^\s*GOOGLE_SERVER_CLIENT_ID\s*=\s*', '').Trim().Trim('"').Trim("'")
if (-not $apiUrl) { throw 'EQUIPLINK_API_URL is missing from the root .env file.' }
if (-not $googleClientId) { throw 'GOOGLE_SERVER_CLIENT_ID is missing from the root .env file.' }
$apiUrl = $apiUrl.TrimEnd('/') + '/'

cd .\equip_link_flutter
flutter run -d <device-id> -t lib/main.dart `
  "--dart-define=SERVER_URL=$apiUrl" `
  "--dart-define=GOOGLE_SERVER_CLIENT_ID=$googleClientId"
```

Replace `<device-id>` with the Android device ID printed by `flutter devices`.
The API URL is public configuration; OAuth client secrets must never be passed
to Flutter or included in the APK.

## Run the complete local stack

1. Copy `.env.example` to `.env` and set the local PostgreSQL and Redis
   passwords, plus the development services you need (for example Brevo and
   Google OAuth). Keep `.env` private.
2. From the repository root, start PostgreSQL and Redis:

   ```powershell
   docker compose --env-file .env -f equip_link_server/docker-compose.yaml up -d postgres redis
   ```

3. Start the Serverpod server from the repository root:

   ```powershell
   serverpod start
   ```

   Serverpod watches for changes and launches the companion Flutter app. The
   app uses `SERVER_URL` when supplied; otherwise it reads `apiUrl` from
   `equip_link_flutter/assets/config.json`, including in debug builds. To use
   the local server, pass its reachable URL as `SERVER_URL`: use
   `http://10.0.2.2:8080/` on an Android emulator, `http://localhost:8080/` on
   desktop/web, or the computer's reachable LAN address on a physical Android
   phone. For example:

   ```powershell
   $googleLine = Get-Content .env | Where-Object { $_ -match '^\s*GOOGLE_SERVER_CLIENT_ID\s*=' } | Select-Object -First 1
   $googleClientId = ($googleLine -replace '^\s*GOOGLE_SERVER_CLIENT_ID\s*=\s*', '').Trim().Trim('"').Trim("'")
   if (-not $googleClientId) { throw 'GOOGLE_SERVER_CLIENT_ID is missing from the root .env file.' }

   cd .\equip_link_flutter
   flutter run -d <device-id> -t lib/main.dart `
     "--dart-define=SERVER_URL=http://192.168.1.20:8080/" `
     "--dart-define=GOOGLE_SERVER_CLIENT_ID=$googleClientId"
   ```

   Replace the example address with the computer's Wi-Fi IPv4 address and set
   `$googleClientId` from the root `.env`. Local HTTP is permitted only in
   Android debug builds. The app reads the public Google Web client ID from
   `assets/config.json` for Serverpod's automatic local launch; explicit build
   defines take precedence.

To stop the local containers:

```powershell
docker compose --env-file .env -f equip_link_server/docker-compose.yaml down
```

## Build the Android APK

From the repository root, build the release APK with the API URL and public
Google Web client ID in `.env`:

```powershell
.\scripts\build-apk.ps1
```

The script writes `docs/equiplink.apk`. This project APK uses debug signing for
development; configure a release keystore before Play Store distribution.

To rebuild and stage the APK automatically before each commit, configure the
versioned Git hook once:

```powershell
git config core.hooksPath .githooks
```

Then `git commit` runs `.githooks/pre-commit`, builds the APK, and stages only
`docs/equiplink.apk` for that commit. The build needs `EQUIPLINK_API_URL`,
`GOOGLE_SERVER_CLIENT_ID`, Flutter, and Android build tools. To run the same
step manually without committing, use:

```powershell
.\scripts\pre-commit-build-apk.ps1
```

## Student verification and rental flow

The app supports the student account and verification flows implemented by the
backend: email/OTP signup, Google OAuth signup followed by student details,
student profile verification, student ID card upload, equipment listings, and
rental actions. Successful registration alone should not be treated as proof
of student eligibility; eligibility depends on the backend's verification
status.

### Payment status

The current rental request screen says that payment is not collected when a
request is created. I found no QR upload or payment-processing flow in the
current Flutter or Serverpod source, so QR payments should be considered
unimplemented until that flow is added and verified.

To test OTP or Google OAuth end to end, the backend must have valid server-side
Brevo and Google OAuth configuration. Do not use real student documents or
payments in development unless the environment is configured for that purpose.

### Android connection and Google sign-in troubleshooting

- If signup reports `Failed host lookup`, check the phone's internet access.
  Try opening `https://nabindev.api.serverpod.space/` in the phone browser. A
  Serverpod API root may return an HTTP error because it is not a webpage; the
  important check is that DNS resolves and TLS connects. If the browser cannot
  resolve the host, set Android **Private DNS** to **Automatic**, then retry on
  Wi-Fi or mobile data.
- Android Google sign-in needs both the Web OAuth client ID (passed as
  `GOOGLE_SERVER_CLIENT_ID`) and an Android OAuth client registered with the
  exact application ID and signing certificate SHA-1. The current Android
  application ID is `com.example.equip_link_flutter`; choose a permanent unique
  ID before publishing, then register that final ID with Google.
- To obtain the debug signing SHA-1, run this from
  `equip_link_flutter/android`:

  ```powershell
  .\gradlew signingReport
  ```

  Create an Android OAuth client in Google Auth Platform using the matching
  package name and the `debug` SHA-1. If the consent screen is in Testing mode,
  add the Gmail account you are testing with as a test user. The matching Web
  client JSON must also be configured as the server's `googleClientSecret` in
  Serverpod Cloud.

## Deployment and configuration notes

- Production uses Serverpod Cloud's managed PostgreSQL database. Local Docker
  PostgreSQL and Redis are development services; they are not deployed to Cloud.
- Serverpod Cloud does not provide Redis. Configure a separate Redis provider
  only if the production app needs it.
- Configure Brevo and Google OAuth secrets in Serverpod Cloud **Env & Passwords**.
  `EQUIPLINK_API_URL` and `GOOGLE_SERVER_CLIENT_ID` are Flutter build values,
  not backend secrets.
- For Cloud deployment and detailed environment variable setup, see
  [docs/serverpod-cloud-deployment.md](docs/serverpod-cloud-deployment.md) and
  [docs/infrastructure.md](docs/infrastructure.md).
- GitHub Actions deployment needs the repository secret
  `SERVERPOD_CLOUD_TOKEN` and repository variable
  `SERVERPOD_CLOUD_PROJECT_ID`. Brevo and Google server credentials belong in
  Serverpod Cloud **Env & Passwords**, not GitHub Actions.
- Never commit `.env`, `config/passwords.yaml`, OAuth client secrets, API keys,
  student identity images, or payment credentials.
