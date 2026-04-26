## Getting Started

After installing and starting the add-on:

1. Open Prowlarr via the **HA sidebar** (Ingress) or at `http://<your-ha-ip>:9696`
2. Complete the setup wizard
3. Add your indexers (Torznab, Newznab)
4. Connect your PVR apps (Sonarr, Radarr, Lidarr, Readarr)

## Configuration

### Options

| Option          | Type | Default           | Description                                     |
| --------------- | ---- | ----------------- | ----------------------------------------------- |
| `env_vars`      | list | `[]`              | Custom environment variables (name/value pairs) |
| `PGID`          | int  | `0`               | Group ID for file permissions                   |
| `PUID`          | int  | `0`               | User ID for file permissions                    |
| `data_location` | str  | `/share/prowlarr` | Path where Prowlarr stores config and data      |
| `TZ`            | str  | `""`              | Timezone (e.g., `Europe/Bucharest`)             |
| `localdisks`    | str  | `""`              | Local drives to mount (e.g., `sda1,sdb1`)       |
| `networkdisks`  | str  | `""`              | SMB shares to mount (e.g., `//SERVER/SHARE`)    |
| `cifsusername`  | str  | `""`              | SMB username for network shares                 |
| `cifspassword`  | str  | `""`              | SMB password for network shares                 |
| `cifsdomain`    | str  | `""`              | SMB domain for network shares                   |

### Example Configuration

```yaml
PGID: 0
PUID: 0
TZ: "Europe/Bucharest"
data_location: "/share/prowlarr"
```

## File Access

The add-on maps the following HA directories:

| HA Path            | Container Path                   | Access     |
| ------------------ | -------------------------------- | ---------- |
| `/share/prowlarr`  | Configurable via `data_location` | Read/Write |
| `/share/`          | `/share/`                        | Read/Write |
| Add-on config      | `/addon_configs/*/`              | Read/Write |

## Ports

| Port   | Protocol | Default | Description   |
| ------ | -------- | ------- | ------------- |
| `9696` | TCP      | `9696`  | Web interface |

## Upstream Documentation

- [Prowlarr Wiki](https://wiki.servarr.com/prowlarr)
- [Servarr Docker Guide](https://wiki.servarr.com/docker-guide)
- [LinuxServer Docker Image](https://github.com/linuxserver/docker-prowlarr)
