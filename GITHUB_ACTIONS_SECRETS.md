# GitHub Actions Secrets - Frontend Only

## ⚠️ NOTE
These are **frontend-only secrets** for the Flutter app deployment. Backend secrets are managed separately.

## Required Frontend Secrets

### Build-Time Environment Variables

| Secret Name | Description | Required | Default Value |
|-------------|-------------|----------|---------------|
| `SERVER_URL` | API base URL (Serverpod backend) | **Yes** | `https://nabindev.api.serverpod.space` |
| `GOOGLE_SERVER_CLIENT_ID` | Google OAuth Web Client ID for Sign-In | **Yes** | Your Google OAuth Client ID |

## How to Set These Secrets

1. Go to your GitHub repository on the web
2. Click **Settings** > **Secrets and variables** > **Actions**
3. Click **New repository secret**
4. Add each secret:

   **For SERVER_URL:**
   - Name: `SERVER_URL`
   - Value: `https://nabindev.api.serverpod.space`

   **For GOOGLE_SERVER_CLIENT_ID:**
   - Name: `GOOGLE_SERVER_CLIENT_ID`
   - Value: `515370521108-067ki0sgmef8u0hi0g033v1f4josjisi.apps.googleusercontent.com`

5. Click **Add secret** for each
6. Verify they appear in the list

## How to Use in GitHub Actions

The workflow file `github/workflows/serverpod-cloud-deploy.yml` already uses these secrets:

```yaml
- name: Install workspace dependencies
  run: flutter pub get

- name: Run Flutter app (example)
  run: |
    flutter run \
      --dart-define=SERVER_URL=${{ secrets.SERVER_URL }} \
      --dart-define=GOOGLE_SERVER_CLIENT_ID=${{ secrets.GOOGLE_SERVER_CLIENT_ID }}
```

## Note on Backend Secrets

Backend secrets (for Serverpod Cloud deployment) are **NOT listed here** and are configured separately:

- `SERVERPOD_CLOUD_TOKEN` - Serverpod Cloud API token
- `SERVERPOD_CLOUD_PROJECT_ID` - Serverpod Cloud project ID

These are used by the backend deployment workflow in another file.

## Verification

To verify your secrets are configured:
1. Go to **Settings** > **Secrets and variables** > **Actions**
2. Look for `SERVER_URL` and `GOOGLE_SERVER_CLIENT_ID` in the list
3. Ensure no secret has a red ❌ icon (indicating it's not accessible)

## Export Option for Local Testing

On your machine, you can export these for local Flutter commands:

```bash
# Windows PowerShell
$env:SERVER_URL="https://nabindev.api.serverpod.space"
$env:GOOGLE_SERVER_CLIENT_ID="515370521108-067ki0sgmef8u0hi0g033v1f4josjisi.apps.googleusercontent.com"

# Git Bash / Linux / macOS
export SERVER_URL="https://nabindev.api.serverpod.space"
export GOOGLE_SERVER_CLIENT_ID="515370521108-067ki0sgmef8u0hi0g033v1f4josjisi.apps.googleusercontent.com"

# Then run Flutter
cd equip_link_flutter
flutter run
```

The app will use these environment variables even if `config.json` has a different value.
