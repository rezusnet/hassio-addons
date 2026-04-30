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
| `data_location` | string | `"/share/transmission"` | Data Location |
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
| `51413` | TCP | `51413` | Torrent port (TCP) |
| `51413` | UDP | `51413` | Torrent port (UDP) |
| `9091` | TCP | `9091` | Web interface |

## Troubleshooting

### Add-on won't start

- Check logs: **Settings > Add-ons > Transmission > Logs**
- Verify all required options are configured
- Check that required ports are available

## Upstream Documentation

- [Project Homepage](https://transmissionbt.com)
- [GitHub Repository](https://github.com/linuxserver/docker-transmission)
