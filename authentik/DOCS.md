# Authentik add-on documentation

Wraps the official [authentik](https://goauthentik.io) image pinned to an
exact upstream release. One container runs:

- **PostgreSQL 17** (Debian packages) — cluster in `/data/postgresql`,
  listening on `127.0.0.1:5432` inside the container only (local `trust`
  auth; the database is not reachable from outside the container).
- **authentik server** (`ak server`) — web UI and API on container port
  `9000` (http).
- **authentik worker** (`ak worker`) — background tasks and scheduled jobs.

authentik 2026.x has **no Redis dependency** — the task queue is dramatiq
with a PostgreSQL-backed broker (this matches the reference compose shipped
inside the upstream image). The supervisor restarts the whole add-on (via
the HAOS watchdog) if either authentik process dies.

## Options

| Option            | Default           | Description                                                                                                                                                 |
|-------------------|-------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `admin_email`     | `admin@localhost` | Email for the `akadmin` user — **first run only**.                                                                                                          |
| `admin_password`  | **(empty)**       | Password for `akadmin`. Empty → auto-generated and written to `data/authentik/admin_credentials.txt`. **First run only.**                                   |
| `email_host`      | **(empty)**       | SMTP server for authentik notifications. Set to enable email.                                                                                               |
| `email_port`      | `587`             | SMTP port.                                                                                                                                                  |
| `email_username`  | **(empty)**       | SMTP username.                                                                                                                                              |
| `email_password`  | **(empty)**       | SMTP password.                                                                                                                                              |
| `email_from`      | **(empty)**       | From address for outgoing mail.                                                                                                                             |
| `email_use_tls`   | `true`            | STARTTLS for SMTP.                                                                                                                                          |
| `email_use_ssl`   | `false`           | Implicit TLS (SMTPS) for SMTP.                                                                                                                              |
| `error_reporting` | `false`           | Enable Sentry error reporting to upstream. Off by default.                                                                                                  |
| `env_vars`        | **(empty)**       | List of `{name, value}` environment variables passed to authentik — use it for any `AUTHENTIK_*` configuration key the add-on does not expose as an option. |

Update check and startup analytics are permanently disabled by the add-on.

### First-run bootstrap

On an empty `/data` the add-on:

1. runs `initdb` and creates the `authentik` database,
2. generates the `AUTHENTIK_SECRET_KEY` (stored in `data/authentik/secret_key`, mode 600),
3. exposes `AUTHENTIK_BOOTSTRAP_EMAIL`/`AUTHENTIK_BOOTSTRAP_PASSWORD` for
   exactly one successful server boot, then removes the marker —
   authentik would otherwise reset the `akadmin` password on **every**
   restart. After the first boot, password changes made in the UI persist.

Changing `admin_password` later has no effect (a warning is logged). To
re-reset the admin password, use the authentik recovery flow
(`ak manage ...` via the add-on terminal) or reset `/data`.

## Ports

The web interface listens on container port `9000`. Map or change the host
port from the add-on's **Network** configuration — the container port is
fixed (HAOS convention).

Authentik must be served at the **root** of its hostname (no sub-path), so
the add-on does not use Home Assistant ingress. Put it behind your reverse
proxy (e.g. nginx-proxy-manager) on its own hostname, and configure that
hostname in authentik under brands before creating OIDC/SAML providers —
the issuer URL of every provider is derived from it.

## Storage layout

| Path                                    | Contents                                           |
|-----------------------------------------|----------------------------------------------------|
| `/data/postgresql/`                     | PostgreSQL cluster (all authentik state)           |
| `/data/authentik/secret_key`            | `AUTHENTIK_SECRET_KEY` (token/session signing)     |
| `/data/authentik/admin_credentials.txt` | First-run `akadmin` credentials (delete after use) |
| `/data/postgresql.log`                  | PostgreSQL server log                              |

Everything lives under `/data`, so Home Assistant backups cover the full
state. Restore = restore the backup (or copy the `/data` tree back) and
start the add-on.

## Upgrades

The add-on version tracks the upstream authentik release **exactly**
(currently `2026.5.3`). The repo auto-updater entry for this add-on is
**paused on purpose**:

- authentik migrations are forward-only — the add-on version must match the
  deployment it replicates (see below) before every upgrade,
- upgrades should be deliberate: stop the add-on, update both sites,
  start again.

To upgrade: unpause/adjust `updater.json` (or bump `build.json` + `config.yaml`
manually in a PR), then update the add-on on the box. Database migrations
run automatically on the first boot of the new version.

## Warm-standby / cluster parity (design notes)

This add-on exists primarily as the HAOS side of a warm-standby SSO site
next to a Kubernetes-hosted authentik (same upstream version, PostgreSQL
streaming replication from the cluster's database, DNS-switchable issuer
hostname). For that role:

- keep the version in **exact lockstep** with the cluster deployment —
  never let the auto-updater bump this add-on independently,
- the PostgreSQL data directory is a stock cluster — it can be replaced by
  a streaming replica (same major version or newer on the subscriber),
- the issuer hostname must be the same on both sites; OIDC clients and
  issued tokens embed it, so a second hostname is *not* a drop-in failover.

Standalone use (no cluster) is fully supported — the add-on is
self-contained.

## Security notes

- PostgreSQL is local to the container (`127.0.0.1`, `trust`) — the only
  network-exposed surface is the authentik web UI on port `9000` (http).
  Front it with your reverse proxy for TLS, ideally with `X-Forwarded-*`
  handling and a dedicated hostname.
- The generated credentials file and secret key are mode `600`, owned by
  the authentik runtime user.
- Telemetry: error reporting off, update check off, startup analytics off.
