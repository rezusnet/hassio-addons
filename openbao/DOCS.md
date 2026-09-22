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
5. *Settings → Seal* shows the seal state; with the default `auto_unseal:
   true` the vault re-unseals itself after every restart automatically.

## Configuration

| Option | Default | Description |
| --- | --- | --- |
| `log_level` | `info` | Server log verbosity (`trace` … `fatal`). |
| `auto_unseal` | `true` | Re-unseal automatically after restarts using the key from `init.json`. See the security note below. |
| `audit_stdout` | `true` | Audit device writing to container stdout (visible in add-on logs). Declared declaratively in the server config (OpenBao 2.x no longer allows runtime audit enablement). |
| `audit_file` | `false` | Additionally write an audit trail to `/data/openbao/logs/audit.log`. |
| `trusted_proxies` | *(empty)* | CIDR list allowed to set `X-Forwarded-For` (relevant when fronting the UI with Nginx Proxy Manager / HAProxy). |
| `env_vars` | *(empty)* | Extra environment variables for the server process (`BAO_*`, proxies, …). |

## The auto-unseal trade-off

A single-node vault cannot reach a quorum, so it must be unsealed with its
key after every restart. With `auto_unseal: true` the add-on stores the
unseal key in `/data/openbao/init.json` (permissions `0600`) on the same
device and unseals on startup. This protects the secret data against
application-level attacks and casual storage access, **but not against an
attacker with full disk access**.

For a stricter posture set `auto_unseal: false` and unseal manually after
each HAOS reboot or add-on restart:

```bash
# from any machine with the bao/vault CLI
export BAO_ADDR="http://HOME-ASSISTANT-IP:8200"
bao operator unseal "<unseal key from init.json>"
```

Either way: keep `init.json` backed up off-device. If it is lost and the
vault is sealed, the data is unrecoverable (by design).

## CLI / API usage

The API and `bao`/`vault` CLI can be used from any machine on the LAN:

```bash
export BAO_ADDR="http://HOME-ASSISTANT-IP:8200"
export BAO_TOKEN="<root_token from init.json>"
bao kv put secret/homeassistant example="value"
bao kv get secret/homeassistant
```

## Storage & backups

- Secrets live in `/data/openbao/data` (Raft) — the add-on's private data
  directory, which is **included in Home Assistant backups**.
- A KV-v2 secrets engine is mounted at `secret/` on first start (OpenBao 2.x
  no longer creates it automatically), so `bao kv put secret/…` works out of
  the box.
- Restoring a backup restores the vault data; on start it is unsealed
  automatically (with `auto_unseal: true` and `init.json` present in the
  backup).
- For extra safety, snapshot the Raft data periodically:
  `bao operator raft snapshot save /path/to/snapshot.snap` and store the
  snapshot off-device.

## Reverse proxy / TLS

The listener is plain HTTP on port 8200 by design — terminate TLS in front
of it (e.g. Nginx Proxy Manager). If you do, set `trusted_proxies` to your
proxy's CIDR so client IPs in the audit log are correct. Exposing a vault
beyond your LAN is not recommended.

## Troubleshooting

- **Add-on exits with "init.json is missing"** — the vault was initialized
  before but the key file was deleted. Restore `init.json` from backup, or
  delete `/data/openbao/data` in the add-on's storage to start over (all
  secrets are lost).
- **"OpenBao API did not become ready"** — check the add-on logs above the
  error for `bao server` output; a corrupt Raft directory shows up there.
