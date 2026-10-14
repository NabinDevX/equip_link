# GitHub Actions Secrets Reference

This document lists the secrets that need to be configured in GitHub Actions for the EquipLink project.

## Backend Secrets (Serverpod)

These secrets are required for the Serverpod server deployment on Serverpod Cloud.

### Required Secrets

| Secret Name | Value | Description |
|------------|-------|-------------|
| `SERVERPOD_CLOUD_TOKEN` | Your Serverpod Cloud API token | Get this from Serverpod Cloud dashboard at https://cloud.serverpod.io |
| `SERVERPOD_CLOUD_PROJECT_ID` | Your Serverpod Cloud project ID | Your project ID from Serverpod Cloud |

### Database Secrets (if using PostgreSQL)

If your production database is separate from Serverpod Cloud's managed database:

| Secret Name | Value | Description |
|------------|-------|-------------|
| `POSTGRES_HOST` | Database hostname | e.g., `your-db-host.com` |
| `POSTGRES_PORT` | Database port | e.g., `5432` |
| `POSTGRES_USER` | Database username | e.g., `postgres` |
| `POSTGRES_PASSWORD` | Database password | Your PostgreSQL password |

### Redis Secrets (if using Redis)

If your production Redis is separate from Serverpod Cloud's managed Redis:

| Secret Name | Value | Description |
|------------|-------|-------------|
| `REDIS_HOST` | Redis hostname | e.g., `your-redis-host.com` |
| `REDIS_PORT` | Redis port | e.g., `6379` |

## Frontend Secrets (Flutter App)

These are environment variables that can be set at build time.

### Required Build-Time Environment Variables | Value | Description |
|------------|-------|-------------|
| `SERVER_URL` | API base URL | The Serverpod API URL (default: `https://nabindev.api.serverpod.space`) |
| `GOOGLE_SERVER_CLIENT_ID` | Google OAuth Web Client ID | OAuth Web Client ID for Google Sign-In (found in Google Cloud Console) |

### Optional Build-Time Environment Variables | Value | Description |
|------------|-------|-------------|
| `BREVO_API_KEY` | Brevo API key | If using Brevo for email (should be server-side, not client-side) |

## How to Set These Secrets

1. Go to your GitHub repository
2. Click on **Settings** > **Secrets and variables** > **Actions**
3. Click **New repository secret**
4. Add each secret with its name and value
5. For production, use the **Environment secrets** option

## Important Notes

- **NEVER commit secrets to Git**: All secrets listed here should be in GitHub Secrets, not `.env` files
- **Environment-specific secrets**: Create separate secrets for production, staging, and development environments
- **Refresh tokens**: `SERVERPOD_CLOUD_TOKEN` may need to be rotated periodically
- **Client-side secrets**: Avoid putting `BREVO_API_KEY`, `GOOGLE_CLIENT_SECRET_JSON`, or other secrets in the Flutter app build

## Default Frontend Configuration

When deploying with GitHub Actions, the frontend will:

1. Use `https://nabindev.api.serverpod.space` as the default Server URL
2. Read `GOOGLE_SERVER_CLIENT_ID` from the `GOOGLE_SERVER_CLIENT_ID` environment variable
3. Use the production configuration from `equip_link_flutter/assets/config.json` if SERVER_URL is not set

## Testing Your Configuration

To verify your GitHub Actions workflow is configured correctly:

1. Push changes to the `main` branch
2. Go to the **Actions** tab in your GitHub repository
3. Check if the workflow runs successfully
4. Monitor the server deployment logs for errors
