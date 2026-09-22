# OpenBao Add-on Documentation

## About

[OpenBao](https://openbao.org) is an open source, identity-based secrets and
encryption management system — the community fork of HashiCorp Vault
(MPL-2.0). This add-on runs OpenBao as a **single-node** server with
**integrated Raft storage**, so all secrets live in the add-on's own data
directory (included in Home Assistant backups).

## Getting Started

1. Install the add-on and start it.
2. Open the add-on logs — on **first start** the vault initializes itself and
   logs a prominent warning. The generated root token and unseal key are
   stored in `/data/openbao/init.json` inside the add-on container.
3. **Back that file up off the device now** (e.g. into Bitwarden). Without
   the unseal key, the vault data can never be decrypted again.
4. Open the UI at `http://HOME-ASSISTANT-IP:8200` (or use the *Open Web UI*
   link) and sign in with the `root_token` from `init.json`.
5. With the default `auto_unseal: true` the vault re-unseals itself after
   every restart automatically.

## Configuration

Options mirror the knobs exposed by the [official OpenBao helm chart](https://github.com/openbao/openbao-helm) (`server.*` values):

| Option | Default | Helm equivalent | Description |
| --- | --- | --- | --- |
| `log_level` | `info` | `server.logLevel` | Server log verbosity (`trace` … `fatal`). |
| `log_format` | `standard` | `server.logFormat` | Log output format (`standard` or `json`). |
| `ui` | `true` | `ui.enabled` | Serve the web UI on port 8200. |
| `auto_unseal` | `true` | *(add-on specific)* | Re-unseal after restarts using the key from `init.json`. See the security note below. |
| `dev_mode` | `false` | `server.dev.enabled` | In-memory ephemeral server — no init/unseal, data lost on restart. Experimenting only! |
| `dev_root_token` | *(empty)* | `server.dev.devRootToken` | Root token for dev mode (`root` upstream default if unset). |
| `disable_mlock` | `true` | config `disable_mlock` | Disable memory locking (leave on for containers). |
| `default_lease_ttl` | `168h` | config `default_lease_ttl` | Default TTL for generated tokens/secrets. |
| `max_lease_ttl` | `720h` | config `max_lease_ttl` | Maximum allowed lease TTL. |
| `telemetry_prometheus_retention` | *(empty)* | `telemetry` stanza | Set (e.g. `30s`, `24h`) to expose Prometheus metrics at `/sys/metrics?format=prometheus` without authentication. |
| `ssl` | `false` | TLS volume pattern | Terminate TLS natively using `/ssl/fullchain.pem` + `/ssl/privkey.pem` (enable the *SSL* map). |
| `audit_stdout` | `true` | *(declarative audit)* | Audit device writing to container stdout (visible in add-on logs). OpenBao 2.x only supports declarative audit — the device is defined in the generated server config. |
| `audit_file` | `false` | *(declarative audit)* | Additionally write an audit trail to `/data/openbao/logs/audit.log`. |
| `trusted_proxies` | *(empty)* | listener `x_forwarded_for_authorized_addrs` | CIDR list allowed to set `X-Forwarded-For` (reverse proxy in front of the UI). |
| `extra_args` | *(empty)* | `server.extraArgs` | Extra CLI arguments for `bao server`. |
| `extra_config` | *(empty)* | `server.standalone.config` | Extra server configuration as a **JSON object** (written as an additional config file). This is where `seal` stanzas for KMS auto-unseal belong — see below. |
| `env_vars` | *(empty)* | `server.extraEnvironmentVars` | Extra environment variables for the server process (`BAO_*`, KMS credentials, …). |

## Adding OpenBao to the Home Assistant sidebar

The add-on does not use HA ingress because the OpenBao UI cannot be served
under a sub-path: its assets and API calls use absolute paths (`/ui/...`,
`/v1/...`), which under ingress would be resolved against the Home Assistant
frontend instead of the vault. This is a limitation of the upstream UI, not
of the add-on.

To pin OpenBao to the left bar, use an **iframe panel** in your Home
Assistant `configuration.yaml`:

```yaml
panel_iframe:
  openbao:
    title: OpenBao
    icon: mdi:vault
    url: https://bao.YOURDOMAIN.duckdns.org
```

If your Home Assistant frontend is served over **HTTPS** (e.g. via Nginx
Proxy Manager + DuckDNS), the iframe URL must be HTTPS too — browsers block
mixed content. Two supported ways:

1. Enable the `ssl` option, put your certificate files in the HA `ssl`
   folder, and point the panel at `https://HOME-ASSISTANT-IP:8200` (the
   certificate must be valid for the name/IP you use).
2. Front the add-on with Nginx Proxy Manager (a `bao.yourdomain` proxy host
   → `http://HOME-ASSISTANT-IP:8200`), set `trusted_proxies` to the proxy
   address, and point the panel at that HTTPS URL.

Without HTTPS on the frontend, plain `http://HOME-ASSISTANT-IP:8200` works.

## Auto-unseal via KMS / transit (`extra_config` + `env_vars`)

Single-node vaults seal on every restart. Instead of the `auto_unseal`
option (key stored next to the data), you can delegate sealing to a cloud
KMS or another OpenBao/Vault via transit — the same way the helm chart's
`server.standalone.config` does. Example for AWS KMS:

```json
{
  "seal": {
    "awskms": {
      "region": "eu-south-1",
      "kms_key_id": "alias/openbao-unseal"
    }
  }
}
```

Put that JSON in `extra_config`, add the AWS credentials to `env_vars`
(`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`), and set `auto_unseal: false`.
Transit auto-unseal works the same way with a `seal "transit"` stanza plus
`BAO_ADDR`/`BAO_TOKEN` in `env_vars`. On first start after switching, the
vault must be re-initialized (or migrated) — a KMS-sealed vault cannot be
unsealed with the old Shamir key.

## CLI / API usage

The API and `bao`/`vault` CLI can be used from any machine on the LAN:

```bash
export BAO_ADDR="http://HOME-ASSISTANT-IP:8200"
export BAO_TOKEN="<root_token from init.json>"
bao kv put secret/homeassistant example="value"
bao kv get secret/homeassistant
```

A KV-v2 secrets engine is mounted at `secret/` on first start (OpenBao 2.x
no longer creates it automatically), so `bao kv put secret/…` works out of
the box.

## Storage & backups

- Secrets live in `/data/openbao/data` (Raft) — the add-on's private data
  directory, which is **included in Home Assistant backups**.
- Restoring a backup restores the vault data; on start it is unsealed
  automatically (with `auto_unseal: true` and `init.json` present in the
  backup).
- For extra safety, snapshot the Raft data periodically:
  `bao operator raft snapshot save /path/to/snapshot.snap` and store the
  snapshot off-device.

## Reverse proxy / TLS

By default the listener is plain HTTP on port 8200. Enable the `ssl` option
for native TLS via the HA `ssl` folder, or terminate TLS in front of it
(e.g. Nginx Proxy Manager). If you do, set `trusted_proxies` to your proxy's
CIDR so client IPs in the audit log are correct. Exposing a vault beyond
your LAN is not recommended.

## Troubleshooting

- **Add-on exits with "init.json is missing"** — the vault was initialized
  before but the key file was deleted. Restore `init.json` from backup, or
  delete `/data/openbao/data` in the add-on's storage to start over (all
  secrets are lost).
- **"OpenBao API did not become ready"** — check the add-on logs above the
  error for `bao server` output; a corrupt Raft directory shows up there.
- **"ssl is enabled but /ssl/fullchain.pem was not found"** — enable the
  *SSL* map in the add-on configuration and place the certificate files
  there.
