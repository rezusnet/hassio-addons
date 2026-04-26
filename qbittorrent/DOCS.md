## Getting Started

After installing and starting the add-on:

1. Open qBittorrent via the **HA sidebar** (Ingress) or at `http://<your-ha-ip>:8080`
2. Default credentials: username `admin`, password `adminadmin` (change on first login)
3. Configure download paths, connection settings, and speed limits

## Configuration

### Options

| Option          | Type | Default              | Description                                     |
| --------------- | ---- | -------------------- | ----------------------------------------------- |
| `env_vars`      | list | `[]`                 | Custom environment variables (name/value pairs) |
| `PGID`          | int  | `0`                  | Group ID for file permissions                   |
| `PUID`          | int  | `0`                  | User ID for file permissions                    |
| `data_location` | str  | `/share/qbittorrent` | Path where qBittorrent stores config and data   |
| `TZ`            | str  | `""`                 | Timezone (e.g., `Europe/Bucharest`)             |
| `localdisks`    | str  | `""`                 | Local drives to mount (e.g., `sda1,sdb1`)       |
| `networkdisks`  | str  | `""`                 | SMB shares to mount (e.g., `//SERVER/SHARE`)    |
| `cifsusername`  | str  | `""`                 | SMB username for network shares                 |
| `cifspassword`  | str  | `""`                 | SMB password for network shares                 |
| `cifsdomain`    | str  | `""`                 | SMB domain for network shares                   |

### Example Configuration

```yaml
PGID: 0
PUID: 0
TZ: "Europe/Bucharest"
data_location: "/share/qbittorrent"
networkdisks: "//192.168.1.100/downloads"
cifsusername: "mediauser"
cifspassword: "mypassword"
```

## File Access

The add-on maps the following HA directories:

| HA Path              | Container Path                   | Access     |
| -------------------- | -------------------------------- | ---------- |
| `/share/qbittorrent` | Configurable via `data_location` | Read/Write |
| `/media/`            | `/media/`                        | Read/Write |
| `/share/`            | `/share/`                        | Read/Write |
| Add-on config        | `/addon_configs/*/`              | Read/Write |

## Download Paths

Set your download directory in qBittorrent to a path accessible by other add-ons.
Common choices: `/media/downloads`, `/share/downloads`, or a mounted network share.

## Ports

| Port   | Protocol | Default | Description   |
| ------ | -------- | ------- | ------------- |
| `8080` | TCP      | `8080`  | Web interface |
| `6881` | TCP      | `6881`  | Torrent port  |
| `6881` | UDP      | `6881`  | Torrent (UDP) |

## Upstream Documentation

- [qBittorrent Wiki](https://wiki.qbittorrent.org/)
- [LinuxServer Docker Image](https://github.com/linuxserver/docker-qbittorrent)
