## Getting Started

After installing and starting the add-on:

1. Configure the options below as needed
2. Start the add-on
3. Access the application

For detailed setup instructions, see the upstream documentation links below.

## Configuration

### Options

| Option | Type | Default | Description |
| ------ | ---- | ------- | ----------- |
| `PGID` | int | `0` | Pgid |
| `PUID` | int | `0` | Puid |
| `TZ` | string | `""` | Tz |
| `cifsdomain` | string | `""` | Cifsdomain |
| `cifspassword` | string | `""` | Cifspassword |
| `cifsusername` | string | `""` | Cifsusername |
| `data_location` | string | `"/share/qbittorrent"` | Data Location |
| `env_vars` | list | `[]` | Env Vars |
| `localdisks` | string | `""` | Localdisks |
| `networkdisks` | string | `""` | Networkdisks |

## File Access

The add-on maps the following HA directories:

| HA Path | Container Path | Access |
| ------- | -------------- | ------ |
| `/addon_config` | `/addon_config` | RW |
| `/media` | `/media` | RW |
| `/share` | `/share` | RW |
| `/ssl` | `/ssl` | RO |

## Ports

| Port | Protocol | Default | Description |
| ---- | -------- | ------- | ----------- |
| `6881` | TCP | `6881` | Torrent port (TCP) |
| `6881` | UDP | `6881` | Torrent port (UDP) |
| `8080` | TCP | `8080` | Web interface |

## Troubleshooting

### Add-on won't start

- Check logs: **Settings > Add-ons > qBittorrent > Logs**
- Verify all required options are configured
- Check that required ports are available

## Upstream Documentation

- [Project Homepage](https://www.qbittorrent.org)
- [GitHub Repository](https://github.com/linuxserver/docker-qbittorrent)
