# Valkey 8 — Full Documentation

## Getting Started

### First Launch

1. Start the add-on. No initial setup is required — Valkey starts listening on port 6379 immediately.
2. If you set a password, clients must authenticate with `AUTH <password>` before running commands.

### Connecting from Other Add-ons

Other add-ons on the same Home Assistant instance can connect to Valkey using:

- **Host:** `2eafa696_valkey8` (or your add-on slug)
- **Port:** `6379` (or whatever you configured)
- **Password:** (if set in Configuration)

Example connection string: `valkey://:<password>@2eafa696_valkey8:6379/0`

### Connecting Externally

Valkey is exposed on the host port (default 6379). Connect from any machine on your network:

```bash
valkey-cli -h <your-ha-ip> -p 6379
```

---

## Configuration

All options are configured in the Home Assistant add-on **Configuration** tab.

### Core Settings

| Option      | Type     | Default   | Description                                                         |
| ----------- | -------- | --------- | ------------------------------------------------------------------- |
| `password`  | password | _(empty)_ | Authentication password. When empty, no authentication is required. |
| `port`      | port     | `6379`    | TCP port Valkey listens on. Also exposed to the host network.       |
| `databases` | int      | `16`      | Number of logical databases (0 to `databases-1`).                   |
| `TZ`        | string   | _(empty)_ | Timezone (e.g., `Europe/Amsterdam`).                                |

### Persistence

| Option         | Type | Default | Description                                                               |
| -------------- | ---- | ------- | ------------------------------------------------------------------------- |
| `save_enabled` | bool | `true`  | Enable RDB snapshot persistence. Snapshots are saved to `/data/dump.rdb`. |

When enabled, Valkey saves snapshots using the following policy:

- Every 3600 seconds if at least 1 key changed
- Every 300 seconds if at least 100 keys changed
- Every 60 seconds if at least 10000 keys changed

### Memory Management

| Option             | Type   | Default       | Description                                                                   |
| ------------------ | ------ | ------------- | ----------------------------------------------------------------------------- |
| `maxmemory`        | string | _(empty)_     | Maximum memory usage (e.g., `256mb`, `1gb`). When empty, memory is unlimited. |
| `maxmemory_policy` | list   | `allkeys-lru` | Eviction policy when memory limit is reached.                                 |

Available eviction policies:

| Policy            | Description                                  |
| ----------------- | -------------------------------------------- |
| `allkeys-lru`     | Evict least recently used keys from all keys |
| `allkeys-random`  | Evict random keys from all keys              |
| `volatile-lru`    | Evict least recently used keys with TTL set  |
| `volatile-random` | Evict random keys with TTL set               |
| `volatile-ttl`    | Evict keys with shortest TTL                 |
| `noeviction`      | Return errors when memory limit is reached   |

### Advanced

| Option     | Type | Default | Description                                                                 |
| ---------- | ---- | ------- | --------------------------------------------------------------------------- |
| `env_vars` | list | `[]`    | Custom environment variables. Each entry has a `name` and optional `value`. |

---

## Data Storage

Valkey data is stored in `/data` inside the container, which maps to the add-on's persistent storage volume. RDB snapshots (`dump.rdb`) are also saved here when persistence is enabled.

---

## Example Configurations

### Basic (no auth, cache-only)

```yaml
password: ""
save_enabled: false
maxmemory: 256mb
maxmemory_policy: allkeys-lru
```

### With authentication and persistence

```yaml
password: my-secure-password
save_enabled: true
databases: 16
```

### Memory-limited session store

```yaml
save_enabled: false
maxmemory: 128mb
maxmemory_policy: allkeys-lru
databases: 4
```

### Custom env vars

```yaml
env_vars:
  - name: TZ
    value: Europe/Amsterdam
```

---

## Using as a Mastodon Redis Backend

This add-on works as the Redis backend for the Mastodon add-on:

1. Install and start the Valkey 8 add-on (no password needed for internal communication).
2. In the Mastodon add-on configuration, set `redis_host` to the Valkey 8 add-on slug (e.g., `2eafa696_valkey8`).
3. Set `redis_port` to `6379` (or your custom port).

---

## Troubleshooting

### Add-on won't start

- Check the add-on **Log** tab for errors.
- Ensure the configured port is not already in use by another add-on or service.

### Connection refused from external clients

- Verify the port is correctly mapped in the add-on Configuration tab.
- Check that no firewall is blocking the port on your HA host.

### High memory usage

- Set `maxmemory` to a reasonable limit.
- Choose an appropriate `maxmemory_policy` (e.g., `allkeys-lru` for caching).

### Data lost after restart

- Enable `save_enabled` to persist data to RDB snapshots.
- Note: Valkey is primarily an in-memory store. For critical data, consider the trade-offs between performance and durability.

---

## Upstream Documentation

- [Valkey GitHub](https://github.com/valkey-io/valkey) — Source code, issues, releases
- [Valkey Website](https://valkey.io) — Official website
- [Valkey Commands](https://valkey.io/commands/) — Full command reference
- [Valkey Documentation](https://valkey.io/topics/) — Topics and guides
