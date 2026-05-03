## Getting Started

After installing and starting the add-on:

1. Open PairDrop via the **HA sidebar** (Ingress) or at `http://<your-ha-ip>:3000`
2. The page displays devices on your local network that also have PairDrop open
3. Tap a device to send a file, or click to receive

No configuration is required for basic local network sharing.

## Configuration

### Options

| Option          | Type | Default           | Description                                        |
| --------------- | ---- | ----------------- | -------------------------------------------------- |
| `env_vars`      | list | `[]`              | Custom environment variables (name/value pairs)    |
| `PGID`          | int  | `0`               | Group ID for file permissions                      |
| `PUID`          | int  | `0`               | User ID for file permissions                       |
| `data_location` | str  | `/share/pairdrop` | Path where PairDrop stores config                  |
| `TZ`            | str  | `""`              | Timezone (e.g., `Europe/Bucharest`)                |
| `localdisks`    | str  | `""`              | Local drives to mount (e.g., `sda1,sdb1`)          |
| `networkdisks`  | str  | `""`              | SMB shares to mount (e.g., `//SERVER/SHARE`)       |
| `cifsusername`  | str  | `""`              | SMB username for network shares                    |
| `cifspassword`  | str  | `""`              | SMB password for network shares                    |
| `cifsdomain`    | str  | `""`              | SMB domain for network shares                      |
| `rate_limit`    | bool | `false`           | Limit clients to 100 requests per 5 minutes        |
| `ws_fallback`   | bool | `false`           | Enable WebSocket fallback for VPN/proxy clients    |
| `debug_mode`    | bool | `false`           | Log client IP addresses (do not use in production) |

### Example Configuration

```yaml
TZ: "Europe/Bucharest"
rate_limit: false
ws_fallback: true
networkdisks: "//192.168.1.100/shared"
cifsusername: "user"
cifspassword: "pass"
```

## WebSocket Fallback

When `ws_fallback` is enabled, traffic is routed through the server instead of
peer-to-peer. This is useful for clients behind VPNs or restrictive firewalls
where WebRTC connections fail. Note that this mode uses server bandwidth and
the server can observe transferred data.

## Ports

| Port   | Protocol | Default | Description |
| ------ | -------- | ------- | ----------- |
| `3000` | TCP      | `3000`  | Web UI      |

## Upstream Documentation

- [PairDrop GitHub](https://github.com/schlagmichdoch/PairDrop)
- [LinuxServer Docker Image](https://github.com/linuxserver/docker-pairdrop)
