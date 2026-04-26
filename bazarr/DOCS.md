## Getting Started

After installing and starting the add-on:

1. Open Bazarr via the **HA sidebar** (Ingress) or at `http://<your-ha-ip>:6767`
2. Configure Sonarr and Radarr connection in Settings
3. Set up your subtitle providers
4. Configure languages and quality profiles

## Configuration

### Options

| Option          | Type | Default         | Description                                     |
| --------------- | ---- | --------------- | ----------------------------------------------- |
| `env_vars`      | list | `[]`            | Custom environment variables (name/value pairs) |
| `PGID`          | int  | `0`             | Group ID for file permissions                   |
| `PUID`          | int  | `0`             | User ID for file permissions                    |
| `data_location` | str  | `/share/bazarr` | Path where Bazarr stores config and data        |
| `TZ`            | str  | `""`            | Timezone (e.g., `Europe/Bucharest`)             |
| `localdisks`    | str  | `""`            | Local drives to mount (e.g., `sda1,sdb1`)       |
| `networkdisks`  | str  | `""`            | SMB shares to mount (e.g., `//SERVER/SHARE`)    |
| `cifsusername`  | str  | `""`            | SMB username for network shares                 |
| `cifspassword`  | str  | `""`            | SMB password for network shares                 |
| `cifsdomain`    | str  | `""`            | SMB domain for network shares                   |

### Example Configuration

```yaml
PGID: 0
PUID: 0
TZ: "Europe/Bucharest"
data_location: "/share/bazarr"
```

## File Access

The add-on maps the following HA directories:

| HA Path         | Container Path                   | Access     |
| --------------- | -------------------------------- | ---------- |
| `/share/bazarr` | Configurable via `data_location` | Read/Write |
| `/media/`       | `/media/`                        | Read/Write |
| `/share/`       | `/share/`                        | Read/Write |
| Add-on config   | `/addon_configs/*/`              | Read/Write |

## Ports

| Port   | Protocol | Default | Description   |
| ------ | -------- | ------- | ------------- |
| `6767` | TCP      | `6767`  | Web interface |

## Upstream Documentation

- [Bazarr Wiki](https://www.bazarr.media/)
- [LinuxServer Docker Image](https://github.com/linuxserver/docker-bazarr)
