# Authentik

Open-source identity provider — single sign-on, authentication and
authorization with OIDC, SAML, LDAP, SCIM and RADIUS outposts, plus a
forward-auth proxy provider for applications that have no SSO of their own.

This add-on wraps the official [authentik](https://goauthentik.io) multi-arch
image (pinned to the upstream release, currently **2026.5.3**) and bundles
everything it needs in one self-contained service: PostgreSQL 17, the
authentik server and the background worker. authentik 2026.x requires no
Redis — its task queue runs on a PostgreSQL-backed broker.

## Quick start

1. Start the add-on — first boot initializes the database, applies all
   migrations and boots the web interface (this takes a minute or two).
2. Retrieve the auto-generated `akadmin` password from
   `data/authentik/admin_credentials.txt` (add-on Filebrowser share or a
   backup) — or preset your own via the `admin_password` option **before**
   the first start.
3. Open the web UI at `http://<host>:9000`, log in as `akadmin`, change the
   password and delete the credentials file.
4. Create brands, applications, providers and outposts from the admin
   interface.

See [DOCS.md](DOCS.md) for all options, storage layout, backup behavior and
the warm-standby/cluster-parity notes.

[![Open add-on](https://my.home-assistant.io/badges/supervisor_addon.svg)](https://my.home-assistant.io/redirect/supervisor_addon/?addon=authentik&repository=rezusnet_hassio-addons)
