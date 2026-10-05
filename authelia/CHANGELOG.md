<!-- markdownlint-disable -->
<!-- Changelog entries mirror upstream release notes verbatim; upstream formatting is intentionally preserved, so style rules are disabled for this file. -->

## 4.39.28 (2026-10-05)

Initial release, upstream Authelia **4.39.28**.

### Docker Container

- `docker pull authelia/authelia:4.39.28`
- `docker pull ghcr.io/authelia/authelia:4.39.28`

[Full release notes](https://github.com/authelia/authelia/releases/tag/v4.39.28)

### Add-on packaging

- Wraps the official `ghcr.io/authelia/authelia:4.39.28` image: the upstream
  build ships on a stripped minimal base (no apt/bash/user tooling), so the
  add-on rebuilds on Ubuntu 26.04 and copies the upstream `/app` tree over.
- Self-contained deployment: SQLite storage (`/data/db.sqlite3`), in-memory
  sessions and filesystem notifier — no PostgreSQL/Redis companion services.
- First boot generates `/data/configuration.yml` and `/data/users_database.yml`
  from the add-on options (including argon2id password hashes for the initial
  `users` list, generated with the upstream `authelia crypto hash generate`
  CLI); afterwards both files are user-owned and never overwritten. With no
  users configured a disabled placeholder (random password) keeps the users
  schema valid so the instance still boots.
- Secrets (session secret, storage encryption key, reset-password JWT secret)
  auto-generated (60 chars) into `/data/secrets/` (mode 600) and injected via
  `AUTHELIA_*_FILE` environment variables — no secrets in the config file.
- Runs as uid/gid 1000 via `setpriv`; `exec`-based startup gives the container
  direct signal handling. Configuration is validated at startup
  (`authelia validate-config`) before the server starts.
- Watchdog and container healthcheck against the upstream `/api/health`
  endpoint.
