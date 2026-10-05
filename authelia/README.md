# Authelia

Single sign-on and multi-factor portal for web applications: drop-in
**forward-auth** for reverse proxies (Nginx Proxy Manager, Traefik, Caddy, …),
an **OpenID Certified™ OIDC provider**, 2FA via TOTP/WebAuthn, and
per-domain **access-control rules**.

This add-on wraps the official [Authelia](https://www.authelia.com)
multi-arch image (pinned to the upstream release, currently **4.39.28**).
Authelia is a single Go binary with zero moving parts around it: state lives
in a SQLite database, sessions are kept in memory, and a filesystem notifier
covers standalone use — no PostgreSQL, no Redis, no companion services.

## Key features

- **Forward-auth** endpoints (`/api/authz/*`) protect anything behind a
  reverse proxy — Nginx Proxy Manager, Traefik, Caddy — regardless of the
  app's own auth support
- **OpenID Certified™ OIDC provider** for apps with native SSO
- Per-domain access control: `bypass`, `one_factor`, `two_factor` policies,
  rules by user and group
- 2FA: TOTP apps and WebAuthn/security keys, plus regulation (banning after
  repeated failed attempts)
- File-based user backend (argon2id hashes) or LDAP backend
- Self-service password reset and device management portal
- Self-contained packaging: SQLite storage, in-memory sessions, filesystem
  notifier — no PostgreSQL, no Redis, nothing else to run
- First boot generates a complete working `configuration.yml` and
  `users_database.yml` from the add-on options, including argon2id hashes
  for your initial users; afterwards the files are yours and never
  overwritten
- Secrets (session, storage encryption, reset-password JWT) generated
  automatically and injected via `AUTHELIA_*_FILE` environment variables
- Configuration validated at startup; runs as non-root (uid 1000); auto-
  updates with the upstream release train

## Quick start

1. Configure the add-on: set `session_domain` to your root domain (e.g.
   `example.com`), `authelia_url` to the externally reachable URL of the
   portal (e.g. `https://auth.example.com`) and add your initial `users`.
2. Start the add-on — the portal listens on port **9091**.
3. Publish it through your reverse proxy (e.g. a proxy host in NPM
   `auth.example.com` → `<HAOS IP>:9091`).
4. Protect other proxy hosts with forward-auth — see
   [DOCS.md](DOCS.md) for the Nginx Proxy Manager snippet.

See [DOCS.md](DOCS.md) for all options, the generated file layout, user
management, forward-auth wiring and troubleshooting.

[![Open add-on](https://my.home-assistant.io/badges/supervisor_addon.svg)](https://my.home-assistant.io/redirect/supervisor_addon/?addon=authelia&repository=rezusnet_hassio-addons)
