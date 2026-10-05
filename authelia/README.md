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

**Upstream (Authelia)**

- Forward-auth endpoints (`/api/authz/*`) for protecting anything behind a
  reverse proxy, regardless of the app's own auth support
- OpenID Certified™ OIDC identity provider for apps with native SSO
- Per-domain access control: `bypass`, `one_factor`, `two_factor` policies,
  rules by user/group
- 2FA: TOTP apps, WebAuthn/security keys; regulation (ban after failed
  attempts)
- File-based user backend (argon2id hashes) or LDAP backend
- Self-service password reset, device management portal

**Home Assistant packaging**

- Self-contained: SQLite + generated secrets, nothing else to run
- First boot generates a complete working `configuration.yml` and
  `users_database.yml` from the add-on options — including argon2id hashes
  for your initial users
- After first boot the files are **yours**: edit `/data/configuration.yml`
  freely, the add-on never overwrites them
- Secrets (session, storage encryption, reset-password JWT) generated
  automatically and injected via `AUTHELIA_*_FILE` environment variables
- Configuration validated at startup; runs as non-root (uid 1000)
- Auto-updates with the upstream release train (daily updater)

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
