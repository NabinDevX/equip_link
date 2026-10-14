# EquipLink infrastructure configuration

## Local development

Local development uses Docker Compose PostgreSQL and Redis. Copy the root
`.env.example` to `.env`, set `POSTGRES_PASSWORD` and `REDIS_PASSWORD`, then
start the services from the repository root:

```powershell
docker compose --env-file .env -f equip_link_server/docker-compose.yaml up -d postgres redis
```

The Serverpod development server reads `DATABASE_PROVIDER=docker` and connects
to `localhost:8090`. The same `POSTGRES_PASSWORD` is used by Compose and the
server. Redis is local at `localhost:8091`.

The Docker Compose file defines the database containers. The server
`Dockerfile` builds the Serverpod server image; it does not create a database.

## Serverpod Cloud production

Enable the managed PostgreSQL database for the Cloud project. Cloud supplies
`SERVERPOD_DATABASE_HOST`, `SERVERPOD_DATABASE_PORT`,
`SERVERPOD_DATABASE_NAME`, `SERVERPOD_DATABASE_USER`,
`SERVERPOD_DATABASE_REQUIRE_SSL`, and the managed
`SERVERPOD_PASSWORD_database` at runtime. Do not set `DATABASE_URL`,
`DATABASE_PROVIDER`, or a Neon connection string in Cloud. The application
detects the Cloud host and uses TLS as required.

Serverpod Cloud does not provide Redis. If production uses Upstash, configure
`SERVERPOD_REDIS_HOST`, `SERVERPOD_REDIS_PORT`, `SERVERPOD_REDIS_ENABLED=true`,
`SERVERPOD_REDIS_REQUIRE_SSL=true`, and the `redis` password in Cloud. If Redis
is not configured, it remains disabled.

Brevo and Google OAuth secrets are configured in Serverpod Cloud's password
and environment settings. Keep all credentials out of source control and
Flutter assets.

## Environment and secrets

- Root `.env.example` is the local environment template; copy it to `.env`.
- `.env` and `config/passwords.yaml` are private local files and must not be
  committed.
- `SERVERPOD_PASSWORD_<name>` environment values map to Serverpod passwords.
- Cloud-managed database connection values are platform supplied; do not copy
  them into source files or GitHub Actions secrets.
