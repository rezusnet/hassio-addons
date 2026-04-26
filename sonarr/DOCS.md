## Getting Started

After installing and starting the add-on:

1. Open Sonarr via the **HA sidebar** (Ingress) or at `http://<your-ha-ip>:8989`
2. Complete the setup wizard
3. Add your TV series libraries pointing to media directories (e.g., `/media/tv`, `/share/sonarr/tv`)
4. Connect your download client (qBittorrent, Transmission, SABnzbd, etc.)

## Configuration

### Options

| Option          | Type | Default          | Description                                     |
| --------------- | ---- | ---------------- | ----------------------------------------------- |
| `env_vars`      | list | `[]`             | Custom environment variables (name/value pairs) |
| `PGID`          | int  | `0`            | Group ID for file permissions                   |
| `PUID`          | int  | `0`            | User ID for file permissions                    |
| `data_location` | str  | `/share/sonarr` | Path where Sonarr stores config and data        |
| `TZ`            | str  | `""`           | Timezone (e.g., `Europe/Bucharest`)             |
| `localdisks`    | str  | `""`           | Local drives to mount (e.g., `sda1,sdb1`)       |
| `networkdisks`  | str  | `""`           | SMB shares to mount (e.g., `//SERVER/SHARE`)    |
| `cifsusername`  | str  | `""`           | SMB username for network shares                 |
| `cifspassword`  | str  | `""`           | SMB password for network shares                 |
| `cifsdomain`    | str  | `""`           | SMB domain for network shares                   |

### Example Configuration

```yaml
PGID: 0
PUID: 0
TZ: "Europe/Bucharest"
data_location: "/share/sonarr"
networkdisks: "//192.168.1.100/media"
cifsusername: "mediauser"
cifspassword: "mypassword"
```

## File Access

The add-on maps the following HA directories:

| HA Path            | Container Path                   | Access     |
| ------------------ | -------------------------------- | ---------- |
| `/share/sonarr`    | Configurable via `data_location` | Read/Write |
| `/media/`          | `/media/`                        | Read/Write |
| `/share/`          | `/share/`                        | Read/Write |
| Add-on config      | `/addon_configs/*/`              | Read/Write |

## Media Paths

For best results with hardlinks and atomic moves, use consistent paths inside Sonarr.
Point your TV series root folder to `/media/tv` or `/share/sonarr/tv`.
Point your download client's output to `/media/downloads` or `/share/downloads`.

See the [Servarr Docker Guide](https://wiki.servarr.com/docker-guide) for path planning best practices.

## Ports

| Port   | Protocol | Default | Description   |
| ------ | -------- | ------- | ------------- |
| `8989` | TCP      | `8989`  | Web interface |

## Upstream Documentation

- [Sonarr Wiki](https://wiki.servarr.com/sonarr)
- [Servarr Docker Guide](https://wiki.servarr.com/docker-guide)
- [LinuxServer Docker Image](https://github.com/linuxserver/docker-sonarr)
