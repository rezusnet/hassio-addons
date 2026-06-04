## Getting Started

After installing and starting the add-on:

1. Open RezusCloud via the **HA sidebar** (admin users only)
2. The WebUI dashboard opens inside HA
3. Create tenants, issue join tokens, and download Talos images
4. Machines boot, connect via MachineLink, and receive configuration

## Configuration

### Options

| Option               | Type     | Default  | Description                                      |
| -------------------- | -------- | -------- | ------------------------------------------------ |
| `auto_start`         | bool     | `false`  | Auto-boot management cluster on add-on start     |
| `join_token`         | password | `""`     | Join token for machine provisioning              |
| `ingress_type`       | list     | `direct` | Ingress mode: `direct`, `cloudflare`, or `ngrok` |
| `backup_enabled`     | bool     | `false`  | Enable S3 backups                                |
| `backup_s3_endpoint` | str      | `""`     | S3 endpoint URL for backups                      |
| `backup_s3_bucket`   | str      | `""`     | S3 bucket name for backups                       |

### Example Configuration

```yaml
auto_start: false
join_token: ""
ingress_type: direct
backup_enabled: true
backup_s3_endpoint: "https://s3.amazonaws.com"
backup_s3_bucket: "my-rezuscloud-backups"
```

## Ports

| Port    | Protocol | Description                            |
| ------- | -------- | -------------------------------------- |
| `3000`  | TCP      | WebUI (also accessible via HA ingress) |
| `50180` | TCP      | MachineLink gRPC (node provisioning)   |
| `50190` | TCP      | Provider gRPC (machine lifecycle)      |

## Privileges

This add-on requires elevated privileges to manage Talos containers:

- **Host network** — MachineLink needs incoming TCP connections on port 50180
- **Docker API** — creates Talos containers via Docker socket
- **NET_ADMIN** — WireGuard/MachineLink tunnel
- **SYS_ADMIN** — Docker container management
- **NET_RAW** — Raw socket access for CNI
- **Full access** — device access, cgroup manipulation, mount operations
- **AppArmor disabled** — conflicts with privileged operations

## Storage

The add-on stores all state in SQLite at `/data/rezuscloud`. This volume is persistent and survives add-on restarts.

## Limitations

- Docker-based Talos containers do not support CNI (webhooks fail)
- Cilium is not installed in Docker boot — Talos default flannel is used
- Full multi-cluster (Kamaji + cert-manager) requires QEMU or bare metal
- Minimum 4 GB RAM required

## Upstream Documentation

- [RezusCloud GitHub](https://github.com/rezuscloud/rezuscloud)
- [HA Integration Guide](https://github.com/rezuscloud/rezuscloud/blob/main/docs/home-assistant-integration.md)
