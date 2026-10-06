<!-- markdownlint-disable -->
<!-- Changelog entries mirror upstream release notes verbatim; upstream formatting is intentionally preserved, so style rules are disabled for this file. -->

## 2026.8.3-r2 (2026-10-06)

- Update to upstream 2026.8.3
- Upstream release notes: https://github.com/goauthentik/authentik/releases


## 2026.5.3-r2 (2026-10-05)

Add-on-side revision (upstream stays **2026.5.3**):

- **External database support**: new `postgres_host`/`postgres_port`/`postgres_user`/
  `postgres_password`/`postgres_db` options. When `postgres_host` is set the add-on
  skips the embedded PostgreSQL cluster entirely and uses the external server —
  e.g. the [postgres_17 add-on](https://github.com/alexbelgium/hassio-addons/tree/master/postgres_17)
  running on the same box (host = your HAOS IP, port 5432). The database is
  auto-created if missing; TLS/extra connection options can be set via `env_vars`
  (e.g. `AUTHENTIK_POSTGRESQL__SSLMODE`).
- Bootstrap hardening: `akadmin` bootstrap is now applied **only when the target
  schema is empty** (detected via the `authentik_user` table), in both embedded
  and external mode — pointing the add-on at an already-initialized database can
  no longer reset the admin password.

## 2026.5.3-r1 (2026-10-05)

Add-on-side revision (upstream stays **2026.5.3**):

- Fixed `watchdog` in `config.yaml`: this supervisor version (2026.09.x) expects a
  health-endpoint URL string (`http://[HOST]:[PORT]/…`), not a boolean — a boolean
  makes the whole add-on invisible in the store (config.yaml rejected at parse
  time). The add-on now declares `http://[HOST]:9000/-/health/ready/`, so the
  supervisor restarts it automatically when the web tier stops answering.

## 2026.5.3 (2026-10-05)

Initial add-on release, packaging upstream authentik **2026.5.3** (MIT, OpenID client license).

Updated to upstream authentik **2026.5.3** — from the upstream [2026.5 release notes](https://docs.goauthentik.io/docs/releases/2026.5):

### Highlights

- **Account Lockout** (Enterprise): A new panic button for compromised accounts that can immediately cut off access, revoke tokens, end sessions, and leave an audit trail.
- **Conditional Access** (Enterprise): New connectors verify device compliance and feed it into conditional access flows: Fleet (via Fleet certificates and an mTLS stage, without the authentik agent) and Google Chrome (via Chrome Enterprise Device Trust).
- **AKQL is now open source**: The AKQL search query language, previously enterprise-only, is now free for everyone to use.
- **Command Palette and wizard upgrades**: A new `Cmd + K` command palette to search the authentik UI, alongside reworked wizards including a new user creation wizard, improved binding wizard, and new invitation wizard.
- **Performance improvements**: The new Rust worker entrypoint drops memory usage by approximately 200 MB per worker container, and opens one fewer PostgreSQL connection per worker. The Admin interface is less resource-intensive through lazy-loaded modals.

### Breaking changes

- **Listening on multiple IPs**: authentik now supports comma-separated lists of IPs for listening settings; the default changed from `0.0.0.0` to `[::]` to better match ecosystem standards. (Not a change for this add-on — it serves on its fixed container port.)
- **PostgreSQL custom connection options are deprecated**: `AUTHENTIK_POSTGRESQL__CONN_OPTIONS` and its replica equivalent are deprecated and will be removed in a future release.

### Fixed in 2026.5.3

Includes security fixes for CVE-2026-49443 and CVE-2026-49448 ([advisories](https://docs.goauthentik.io/docs/releases/2026.5#fixed-in-202653)).

- blueprints: handle integrity exception when applying blueprints ([#22927](https://github.com/goauthentik/authentik/pull/22927))
- core: bump django from 5.2.14 to v5.2.15 ([#22962](https://github.com/goauthentik/authentik/pull/22962))
- endpoints/connectors/agent: fix exception with invalid auth type ([#22951](https://github.com/goauthentik/authentik/pull/22951))
- enterprise/providers/scim: fix interactive OAuth overriding refresh_token ([#22861](https://github.com/goauthentik/authentik/pull/22861))
- providers/oauth: skip post logout redirect matching if none are saved on the provider ([#22955](https://github.com/goauthentik/authentik/pull/22955))
- providers/radius: fix panic in log due to type ([#22967](https://github.com/goauthentik/authentik/pull/22967))
- tests/e2e: fix proxy tests failing due to in-use port ([#22992](https://github.com/goauthentik/authentik/pull/22992))
- web/admin: fix Docker outpost integration form CA Cert filter ([#22895](https://github.com/goauthentik/authentik/pull/22895))
- web/polyfill: polyfill customElements.getName for Safari < 17.4 ([#22963](https://github.com/goauthentik/authentik/pull/22963))

[Full changelog](https://github.com/goauthentik/authentik/compare/version/2026.5.2...version/2026.5.3)

### Add-on packaging

- Self-contained single container: PostgreSQL 17 + `ak server` + `ak worker`
  — authentik 2026.x needs no Redis (dramatiq with a PostgreSQL-backed
  broker, per the image's own reference compose)
- First-run bootstrap: `initdb`, generated ≥50-char secret key, `akadmin`
  bootstrap with auto-generated credentials in `data/authentik/admin_credentials.txt`;
  `admin_password` applies on first boot only (bootstrap env is removed
  after the first ready server boot so UI password changes persist)
- Options: SMTP email, error reporting (default off), `env_vars`
  passthrough for arbitrary `AUTHENTIK_*` keys; update check and startup
  analytics permanently off
- Web UI on container port 9000 (no ingress — authentik requires a hostname
  root); add-on watchdog restarts the container if either process dies
- Version pinned to the exact upstream release; auto-updater entry **paused
  by design** (warm-standby/cluster parity requires version lockstep — see DOCS)
