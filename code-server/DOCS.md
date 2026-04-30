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
| `DOCKER_MODS` | list | `[]` | Docker Mods |
| `HASHED_PASSWORD` | string | `""` | Hashed Password |
| `PASSWORD` | string | `""` | Password |
| `PGID` | int | `0` | Pgid |
| `PUID` | int | `0` | Puid |
| `SUDO_PASSWORD` | string | `""` | Sudo Password |
| `SUDO_PASSWORD_HASH` | string | `""` | Sudo Password Hash |
| `TZ` | string | `""` | Tz |
| `data_location` | string | `"/share/code-server"` | Data Location |
| `env_vars` | list | `[]` | Env Vars |

## File Access

The add-on maps the following HA directories:

| HA Path | Container Path | Access |
| ------- | -------------- | ------ |
| `/addon_config` | `/addon_config` | RW |
| `/share` | `/share` | RW |
| `/ssl` | `/ssl` | RO |

## Ports

| Port | Protocol | Default | Description |
| ---- | -------- | ------- | ----------- |
| `8443` | TCP | `8443` | Web interface |

## Troubleshooting

### Add-on won't start

- Check logs: **Settings > Add-ons > Code Server > Logs**
- Verify all required options are configured
- Check that required ports are available

## Upstream Documentation

- [Project Homepage](https://coder.com)
- [GitHub Repository](https://github.com/linuxserver/docker-code-server)
