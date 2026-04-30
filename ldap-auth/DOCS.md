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
| `CERTFILE` | string | `""` | Certfile |
| `FERNETKEY` | string | `""` | Fernetkey |
| `KEYFILE` | string | `""` | Keyfile |
| `PGID` | int | `0` | Pgid |
| `PUID` | int | `0` | Puid |
| `TZ` | string | `""` | Tz |
| `env_vars` | list | `[]` | Env Vars |

## File Access

The add-on maps the following HA directories:

| HA Path | Container Path | Access |
| ------- | -------------- | ------ |
| `/addon_config` | `/addon_config` | RW |
| `/ssl` | `/ssl` | RO |

## Ports

| Port | Protocol | Default | Description |
| ---- | -------- | ------- | ----------- |
| `8888` | TCP | `8888` | LDAP Auth Daemon |
| `9000` | TCP | `9000` | LDAP Login Page |

## Troubleshooting

### Add-on won't start

- Check logs: **Settings > Add-ons > LDAP Auth > Logs**
- Verify all required options are configured
- Check that required ports are available

## Upstream Documentation

- [Project Homepage](https://github.com/nginxinc/nginx-ldap-auth)
- [GitHub Repository](https://github.com/linuxserver/docker-ldap-auth)
