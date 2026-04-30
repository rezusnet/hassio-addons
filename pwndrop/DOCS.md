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
| `data_location` | string | `"/share/pwndrop"` | Data Location |

## File Access

The add-on maps the following HA directories:

| HA Path | Container Path | Access |
| ------- | -------------- | ------ |
| `/addon_config` | `/addon_config` | RW |
| `/share` | `/share` | RW |

## Ports

| Port | Protocol | Default | Description |
| ---- | -------- | ------- | ----------- |
| `8080` | TCP | `8080` | Web interface |

## Troubleshooting

### Add-on won't start

- Check logs: **Settings > Add-ons > Pwndrop > Logs**
- Verify all required options are configured
- Check that required ports are available

## Upstream Documentation

- [Project Homepage](https://github.com/linuxserver/docker-pwndrop)
- [GitHub Repository](https://github.com/linuxserver/docker-pwndrop)
