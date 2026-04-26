## Getting Started

After installing and starting the add-on:

1. Open Transmission via the **HA sidebar** (Ingress) or at `http://<your-ha-ip>:9091`
2. The web interface opens directly (no authentication by default)
3. Configure download paths and connection settings as needed

## Configuration

### Options

| Option          | Type | Default              | Description                                     |
| --------------- | ---- | -------------------- | ----------------------------------------------- |
| `env_vars`      | list | `[]`                 | Custom environment variables (name/value pairs) |
| `PGID`          | int  | `0`                  | Group ID for file permissions                   |
| `PUID`          | int  | `0`                  | User ID for file permissions                    |
| `data_location` | str  | `/share/transmission` | Path where Transmission stores config and data |
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
data_location: "/share/transmission"
networkdisks: "//192.168.1.100/downloads"
cifsusername: "mediauser"
cifspassword: "mypassword"
```

## File Access

The add-on maps the following HA directories:

| HA Path                | Container Path                   | Access     |
| ---------------------- | -------------------------------- | ---------- |
| `/share/transmission`  | Configurable via `data_location` | Read/Write |
| `/media/`              | `/media/`                        | Read/Write |
| `/share/`              | `/share/`                        | Read/Write |
| Add-on config          | `/addon_configs/*/`              | Read/Write |

## Download Paths

Set your download directory in Transmission to a path accessible by other add-ons.
Common choices: `/media/downloads`, `/share/downloads`, or a mounted network share.

The `watch` directory can be used to automatically add `.torrent` files.

## Ports

| Port    | Protocol | Default | Description   |
| ------- | -------- | ------- | ------------- |
| `9091`  | TCP      | `9091`  | Web interface |
| `51413` | TCP      | `51413` | Torrent port  |
| `51413` | UDP      | `51413` | Torrent (UDP) |

## Upstream Documentation

- [Transmission Wiki](https://github.com/transmission/transmission/wiki)
- [LinuxServer Docker Image](https://github.com/linuxserver/docker-transmission)
