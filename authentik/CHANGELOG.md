<!-- markdownlint-disable -->
<!-- Changelog entries mirror upstream release notes verbatim; upstream formatting is intentionally preserved, so style rules are disabled for this file. -->

## 2026.5.3 (2026-10-05)

Initial add-on release, packaging upstream authentik **2026.5.3** (MIT,
OpenID client license).

Upstream **2026.5.3** is a security and bugfix release on the 2026.5 line —
see [Fixed in 2026.5.3](https://docs.goauthentik.io/docs/releases/2026.5#fixed-in-202653)
(includes CVE-2026-49443 and CVE-2026-49448) and the
[full changelog](https://github.com/goauthentik/authentik/compare/version/2026.5.2...version/2026.5.3).

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
