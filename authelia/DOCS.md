# Authelia add-on documentation

Wraps the official [Authelia](https://www.authelia.com) image pinned to an
exact upstream release. One container runs a single Go binary:

- **Authelia portal** — login/2FA portal, self-service settings and the
  authz API on container port `9091` (http).
- **SQLite storage** — `/data/db.sqlite3` (no external database needed).
- **Filesystem notifier** — notification emails are written to
  `/data/notifications.txt` (configure SMTP in `configuration.yml` to send
  real mail).

No Redis: sessions are kept in memory, which is exactly right for a single
HAOS instance. The supervisor restarts the add-on via the HAOS watchdog
(health endpoint `/api/health`) if the process dies.

Authelia's configuration space is far larger than any add-on option schema.
The add-on therefore generates the two YAML files **once** from its options
and then leaves them to you — everything past first boot is file editing.

## Getting started

1. Before first start, set the options:
   - `session_domain`: your root domain, e.g. `example.com` (cookies are
     issued for this domain — protect `*.example.com` hosts)
   - `authelia_url`: the externally reachable portal URL, e.g.
     `https://auth.example.com` (its host must be inside `session_domain`)
   - `users`: your initial users (name + password; hashed with argon2id on
     first boot)
2. Start the add-on. First boot generates `/data/configuration.yml`,
   `/data/users_database.yml` and `/data/secrets/`, then validates the
   configuration and starts the portal (a few seconds).
3. Create a reverse proxy host for the portal itself (e.g. in NPM:
   `auth.example.com` → `http://<HAOS IP>:9091`).
4. Protect other hosts with forward-auth (see
   [Reverse proxy integration](#reverse-proxy-integration)).

## Options

| Option                    | Default                    | Description                                                                                                                                  |
| ------------------------- | -------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| `session_domain`          | `example.com`              | Root cookie domain. Used at **generation time only**.                                                                                        |
| `authelia_url`            | `https://auth.example.com` | Public portal URL (**https**; host must be inside the session domain — Authelia rejects insecure schemes). Used at **generation time only**. |
| `default_redirection_url` | _(empty)_                  | Where unauthenticated users land when no target URL is known (e.g. the HA frontend). Optional.                                               |
| `theme`                   | `auto`                     | Portal theme: `auto`, `grey`, `dark`, `light`.                                                                                               |
| `log_level`               | `info`                     | `trace`, `debug`, `info`, `warn`, `error`.                                                                                                   |
| `default_policy`          | `one_factor`               | Access-control default: `bypass`, `one_factor`, `two_factor`, `deny`. Per-domain rules go in the config file.                                |
| `users`                   | `[]`                       | Initial users: `username`, `password`, optional `email`, optional `groups` list. First boot only.                                            |
| `env_vars`                | `[]`                       | Arbitrary environment variables (`name`/`value`) — any `AUTHELIA_*` configuration key can be set.                                            |

All options except `env_vars` apply **only when the generated files do not
exist yet**. To change them later, edit the files (below) — or delete the
file and restart to regenerate it.

## Files in /data

| File                             | Purpose                                                        |
| -------------------------------- | -------------------------------------------------------------- |
| `configuration.yml`              | Full Authelia configuration (generated once, then user-owned). |
| `users_database.yml`             | File-based user backend (argon2id hashes).                     |
| `db.sqlite3`                     | SQLite state (TOTP secrets, WebAuthn devices, OIDC, sessions). |
| `secrets/session_secret`         | Cookie signing secret (600, generated).                        |
| `secrets/storage_encryption_key` | Encrypts sensitive columns in SQLite (600, generated).         |
| `secrets/jwt_secret`             | Signs the password-reset flow (600, generated).                |
| `notifications.txt`              | Notification emails when using the filesystem notifier.        |

Access the files via the add-on's Filebrowser share, SSH (`/addon_configs/…`
or `/data` inside the container), or HA backups — everything lives under
`/data` and is included in add-on backups automatically.

### Managing users

- **Add/change users**: edit `users_database.yml`. Generate a hash with the
  upstream CLI:
  `docker run --rm ghcr.io/authelia/authelia:4.39.28 crypto hash generate --password 'secret' argon2`
  (prints `Digest: $argon2id$…`). Changes apply on the next restart.
- **Regenerate from options**: delete `users_database.yml` (and update the
  `users` option), restart.

### Regenerating the configuration

Delete `configuration.yml` and restart — it is recreated from the current
options. Your edits are otherwise never touched, including across add-on
updates (the add-on only writes the file when it does not exist).

## Reverse proxy integration

Publish the portal itself as a normal proxy host (e.g.
`auth.example.com` → `http://<HAOS IP>:9091`, HTTPS with a Let's Encrypt
cert).

### Nginx Proxy Manager (forward-auth)

For every host you want to protect, add this to its **Advanced** tab (NPM ≥
v2.9 supports `auth_request` in custom config; `location /internal/…` blocks
can go into a shared include if you maintain one):

```nginx
location /internal/authelia/authz {
    internal;

    proxy_pass http://<HAOS-IP>:9091/api/authz/auth-request;
    proxy_set_header X-Original-Method $request_method;
    proxy_set_header X-Original-URL $scheme://$http_host$request_uri;
    proxy_set_header X-Forwarded-For $remote_addr;
    proxy_set_header Content-Length "";
    proxy_set_header Connection "";
    proxy_pass_request_body off;
}

# protected location — merge into the host's existing `location /` config:
#   auth_request /internal/authelia/authz;
#   auth_request_set $redirection_url $upstream_http_x_redirect_url;
#   ... (see the Authelia nginx integration doc for the full snippet)
```

Authelia's canonical snippets for Nginx, Traefik, Caddy, Envoy and more:
[Proxy Integration](https://www.authelia.com/integration/provided/forward-auth/).
Authelia 4.39 supports several authz implementations
(`auth-request`, `forward-auth`, `ext-authz`); pick the matching endpoint
under `/api/authz/`.

### OpenID Connect (OIDC)

Enable the OIDC provider by editing `/data/configuration.yml` (see
[OpenID Connect](https://www.authelia.com/configuration/identity-providers/openid-connect/))
— clients, scopes and crypto keys are all configuration-file territory.
The `env_vars` option can supply `AUTHELIA_IDENTITY_PROVIDERS_OIDC_JWKS_FILE`
and friends if you prefer env-based secrets.

## Ports

| Port                    | Purpose                          |
| ----------------------- | -------------------------------- |
| `9091` (host, editable) | Portal UI, API, authz endpoints. |

The host port can be changed in the add-on **Network** panel; the in-config
listen address stays `tcp://0.0.0.0:9091` inside the container.

## Troubleshooting

- **`Configuration ... invalid` at startup** — the generated file was edited
  into a broken state; the log names the exact key. The validator runs before
  the server starts, so the add-on fails fast instead of crash-looping.
- **Cookie/redirect errors after login** — `authelia_url` host must be a
  subdomain of `session_domain`, and the portal must actually be reachable
  at that URL through your proxy (scheme included).
- **Always logged out** — the reverse proxy must forward `X-Original-URL`
  / `X-Forwarded-For` (see snippet above); cookies are issued for
  `session_domain` only.
- **Users not accepted** — check `users_database.yml` hashes (argon2id) and
  that no `disabled: true` slipped in; `log_level: debug` shows backend
  decisions.
- **Port already in use** — change the host port in the Network panel.

## Upstream documentation

- Configuration reference: <https://www.authelia.com/configuration/>
- Forward-auth integrations: <https://www.authelia.com/integration/provided/forward-auth/>
- Security keys & secrets: <https://www.authelia.com/reference/guides/generating-secure-values/>
- GitHub: <https://github.com/authelia/authelia>
