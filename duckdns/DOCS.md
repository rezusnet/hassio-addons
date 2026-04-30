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
| `data_location` | string | `"/share/duckdns"` | Data Location |
| `env_vars` | list | `[]` | Env Vars |

## File Access

The add-on maps the following HA directories:

| HA Path | Container Path | Access |
| ------- | -------------- | ------ |
| `/share` | `/share` | RO |
| `/media` | `/media` | RW |

## Ports

No ports configured.


## Troubleshooting

### Add-on won't start

- Check logs: **Settings > Add-ons > DuckDNS > Logs**
- Verify all required options are configured
- Check that required ports are available

## Upstream Documentation

- [Project Homepage](https://github.com/linuxserver/docker-duckdns)
- [GitHub Repository](https://github.com/linuxserver/docker-duckdns)
