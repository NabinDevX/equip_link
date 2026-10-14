# EquipLink Infrastructure, External Services, and Secret Management (Chunk 1)

This document provides a comprehensive operational guide for EquipLink's backend infrastructure, environment configuration, database and cache provider selection, transactional email configuration, and migration safety.

---

## 1. Environment & Secret Management Architecture

### Precedence Hierarchy (Highest to Lowest)
1. **Dart Config Overrides (`InfrastructureConfig.applyOverrides`)**: Programmatic overrides passed via `configOverride` to the Serverpod server instance at startup.
2. **System Environment Variables (`Platform.environment`)**: Variables exported in the shell, CI/CD runners, or Docker containers (`SERVERPOD_*`, `DATABASE_URL`, `REDIS_URL`, `BREVO_*`).
3. **Local `.env` File (`EnvLoader`)**: Parsed zero-dependency `.env` file at the workspace root or server directory for local development convenience. Never committed to version control.
4. **Serverpod Passwords File (`config/passwords.yaml`)**: Built-in encrypted/untracked file for environment credentials (`development`, `staging`, `production`, `shared`).
5. **Serverpod Environment YAML (`config/<runMode>.yaml`)**: Baseline defaults for ports, logging, server roles, and hostnames.

> **CRITICAL NOTE ON YAML INTERPOLATION**: Serverpod 4.0.4 **does not** perform `${VARIABLE}` interpolation within `config/*.yaml` files. Instead, Serverpod natively supports `SERVERPOD_*` environment variable overrides, and EquipLink utilizes `InfrastructureConfig.applyOverrides` to bridge generic DevOps variable names (`DATABASE_PROVIDER`, `REDIS_PROVIDER`, etc.) safely into `ServerpodConfig`.

### Secret Protection
- **No secrets in git**: `.env`, `.env.*` (except `.env.example`), and `config/passwords.yaml` are ignored in `.gitignore`.
- **Backend-only exposure**: The Flutter client connects exclusively via the Serverpod client protocol and receives public endpoint URLs via `/assets/assets/config.json`. Database passwords, Redis auth tokens, and the Brevo API key are strictly server-side.
- **Masked startup diagnostics**: At boot, `InfrastructureConfig.validateAndLog(pod)` verifies connections and prints a diagnostic summary with hostnames and API keys masked (e.g. `xkey...yleS`).

---

## 2. Provider Selection & Configuration

EquipLink supports switching between external managed cloud services and self-hosted local Docker containers without modifying application code.

`DATABASE_URL` and `REDIS_URL` are the preferred configuration inputs. They contain the complete connection information, including credentials and TLS options, so separate host, port, username, password, and SSL variables are not required. Credentials containing reserved URL characters must be percent-encoded. Existing separate `DATABASE_*` and `REDIS_*` variables remain supported as a compatibility fallback.

### Option A: External Cloud (Neon PostgreSQL + Upstash Redis)
Best for staging, production, or cloud-backed development.

Set the following in `.env` or system environment:
```env
SERVERPOD_RUN_MODE=development

# Database: Neon PostgreSQL
DATABASE_PROVIDER=neon
DATABASE_URL=postgresql://neondb_owner:your_neon_password@ep-example.region.aws.neon.tech:5432/equip_link?sslmode=require

# Cache: Upstash Redis
REDIS_PROVIDER=upstash
REDIS_URL=rediss://default:your_upstash_password@your-endpoint.upstash.io:6379
```

#### Neon PostgreSQL Connection Guidelines:
- **Direct Connection (`port 5432`)**: Connects directly to the Neon compute instance without PgBouncer. **Mandatory** when running Serverpod database migrations (`serverpod create-migration` / `apply-migrations`) and executing DDL/session locks.
- **Pooled Connection (`port 6543`, `...-pooler...`)**: Useful for high-concurrency stateless query loads. Notice: Neon poolers operate in transaction mode; session-level locks and prepared statements require careful handling.
- **SSL/TLS Requirement**: Neon mandates encrypted connections (`requireSsl: true`). `InfrastructureConfig` automatically enforces `requireSsl: true` when `DATABASE_PROVIDER=neon`.

#### Upstash Redis Protocol:
- **TCP over TLS**: Serverpod's built-in caching engine uses standard Redis TCP connections with TLS (`requireSsl: true`), connecting to port `6379`. It connects directly to Upstash's standard Redis TLS endpoint (not Upstash's HTTP/REST API).

---

### Option B: Local Self-Hosted (Docker PostgreSQL + Docker Redis)
Best for offline local development and containerized self-hosting.

1. Start the Docker services:
   ```bash
   cd equip_link_server
   docker compose up -d
   ```
2. Configure `.env`:
   ```env
   SERVERPOD_RUN_MODE=development

   DATABASE_PROVIDER=docker
   DATABASE_URL=postgresql://postgres:P4XPVyxNWTGhYe-56gqqzbeMqwPKU3lF@localhost:8090/equip_link

   REDIS_PROVIDER=docker
   REDIS_URL=redis://:jjgPe30wriYvj438PSlHTbuM9uTWBi51@localhost:8091
   ```

---

### Option C: Hybrid (Neon PostgreSQL + Docker Redis)
Use external Neon database with a local Docker Redis instance for fast local caching.

```env
DATABASE_PROVIDER=neon
DATABASE_URL=postgresql://neondb_owner:your_neon_password@ep-example.region.aws.neon.tech:5432/equip_link?sslmode=require

REDIS_PROVIDER=docker
REDIS_URL=redis://:jjgPe30wriYvj438PSlHTbuM9uTWBi51@localhost:8091
```

---

### Option D: Ephemeral Embedded (Development Default)
When `DATABASE_PROVIDER=embedded` or omitted without external host settings, Serverpod launches its embedded PostgreSQL instance located at `.serverpod/development/pgdata` (port 8090). Redis defaults to `none`.

---

## 3. Brevo Transactional Email Configuration

EquipLink authentication flows send verification emails and password resets via Brevo's transactional HTTP API.

- **API Endpoint**: `POST https://api.brevo.com/v3/smtp/email`
- **Required Headers**:
  - `api-key`: Secret API key (from Brevo account)
  - `Content-Type`: `application/json`
  - `Accept`: `application/json`

### Environment Configuration:
```env
BREVO_API_KEY=xkeysib-...
BREVO_SENDER_EMAIL=noreply@yourdomain.com
BREVO_SENDER_NAME=EquipLink Support
# Optional: Brevo transactional template ID for OTP/verification emails
# BREVO_TEMPLATE_ID=1
```

### Serverpod Password Mechanism Support:
Alternatively, `brevoApiKey` can be stored directly in `equip_link_server/config/passwords.yaml` under `development:`, `staging:`, `production:`, or `shared:`, or exported as `SERVERPOD_PASSWORD_BREVO_API_KEY`.
`InfrastructureConfig.getBrevoConfig(pod: pod)` automatically resolves keys across all supported conventions.

## 4. Google identity provider and student eligibility

Google sign-in is handled by Serverpod's Google identity provider. The backend
must be configured with the OAuth web-client secret JSON; do not put this
secret in Flutter assets or `--dart-define` values:

```yaml
# equip_link_server/config/passwords.yaml
development:
  googleClientSecret: '{"web":{"client_id":"...apps.googleusercontent.com","client_secret":"...","redirect_uris":["http://localhost:8080/auth/google/callback"]}}'
```

The provider is enabled only when `googleClientSecret` is present. After Google
authentication, the account remains in `pending` student eligibility until the
separate `.edu.in` email verification challenge is completed. The challenge
and OTP are server-side and use the existing Brevo service.

---

## 5. Docker & Migration Safety Rules

1. **Parameterization with Fallbacks**: `docker-compose.yaml` uses `${POSTGRES_PASSWORD:-...}` and `${REDIS_PASSWORD:-...}` so credentials can be overridden via environment without modifying Compose files.
2. **Volume Preservation**: Volume definitions `equip_link_data` and `equip_link_test_data` are preserved to prevent data loss across container restarts.
3. **No Automatic Production Migrations**:
   - `SERVERPOD_APPLY_MIGRATIONS` is set to `false` by default.
   - Never boot a production server with unvetted automatic migrations.
   - For database migrations, run through the Serverpod MCP or CLI deliberately after verifying schema diffs:
     ```bash
     serverpod create-migration
     ```
   - Always run migrations through a **direct PostgreSQL connection** (port 5432), never through a pooled connection.
