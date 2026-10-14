# EquipLink Serverpod Cloud deployment

The Serverpod package is `equip_link_server`. The project is linked to Cloud by
`equip_link_server/scloud.yaml`. Cloud manages the production PostgreSQL
database; local development uses PostgreSQL and Redis from Docker Compose.

## Configure the Cloud project

1. In the Serverpod Cloud console, make sure the project's managed PostgreSQL
   database is enabled. Cloud injects its host, port, database name, username,
   TLS requirement, and `SERVERPOD_PASSWORD_database` at runtime.
2. Do not add Neon credentials, `DATABASE_URL`, or `DATABASE_PROVIDER` to
   Cloud. The app detects Serverpod Cloud's injected database host and uses the
   managed database.
3. Configure the app's non-database services in **Env & Passwords**:

   | Setting | Cloud type | Value |
   | --- | --- | --- |
   | `BREVO_API_KEY` | Secret/password | Brevo transactional API key |
   | `BREVO_SENDER_EMAIL` | Variable | Verified sender email |
   | `BREVO_SENDER_NAME` | Variable | Sender display name |
   | `GOOGLE_CLIENT_SECRET_JSON` | Secret/password | Google Web OAuth client JSON |
   | `REDIS_PROVIDER` | Variable | `upstash` if using Upstash |
   | `REDIS_URL` | Secret | Upstash `rediss://` URL, if using Upstash |

   Redis is optional; Serverpod Cloud provides PostgreSQL but not Redis. Do
   not add `EQUIPLINK_API_URL` or `GOOGLE_SERVER_CLIENT_ID` as backend secrets;
   those are Flutter build inputs.
4. From `equip_link_server`, run `scloud launch` for the first deployment, or
   `scloud deploy` for later deployments. The pre-deploy scripts generate
   Serverpod code and build the Flutter web app. Cloud applies pending database
   migrations when the server starts.

## Windows deployment and Android build

The Cloud pre-deploy hook only runs `serverpod generate`; it does not build a
Flutter web app. If Windows blocks the Serverpod CLI, use the repository's
GitHub Actions workflow. Configure these repository settings:

| GitHub setting | Kind | Value |
| --- | --- | --- |
| `SERVERPOD_CLOUD_TOKEN` | Actions secret | Serverpod Cloud deployment token |
| `SERVERPOD_CLOUD_PROJECT_ID` | Actions variable | Cloud project ID, currently `nabindev` |

Then run **Deploy Serverpod to Cloud** from the Actions tab, or push to `main`.
Brevo credentials, Google OAuth server JSON, and production database credentials
are configured in Serverpod Cloud and are not GitHub Actions secrets for this
workflow. `EQUIPLINK_API_URL` and `GOOGLE_SERVER_CLIENT_ID` are Flutter build
inputs, not backend deployment secrets.

Build and run the Android app separately. If Flutter reports that Windows
needs symlink support for plugins, enable Developer Mode in Windows Settings
and retry the Android build. Flutter web support is not required.

## Android APK

After deployment, set the API URL printed by Cloud as `EQUIPLINK_API_URL` in
the root `.env`, then build from the repository root:

```powershell
.\scripts\build-apk.ps1 -ApiUrl "https://<project-id>.api.serverpod.space/"
```

The script writes `docs/equiplink.apk`. The current APK uses the Android debug
signing key, so register its SHA-1 with the matching Android OAuth client for
testing. Use a private release keystore before publishing to the Play Store.
To rebuild and stage the APK automatically before each commit, run
`git config core.hooksPath .githooks` once. The hook runs
`scripts/pre-commit-build-apk.ps1`, then stages `docs/equiplink.apk`.

Never commit root `.env` or `config/passwords.yaml`; commit `.env.example` only.
