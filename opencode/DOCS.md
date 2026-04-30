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
| `TZ` | string | `""` | Tz |
| `custom_packages` | string | `""` | Custom Packages |
| `dev_profile` | list | `[]` | Dev Profile |
| `env_vars` | list | `[]` | Env Vars |
| `git_ssh_key` | string | `""` | Git Ssh Key |
| `git_token` | string | `""` | Git Token |
| `repositories` | list | `[]` | Repositories |
| `server_password` | string | `""` | Server Password |
| `workspace` | string | `"/homeassistant"` | Workspace |

## File Access

The add-on maps the following HA directories:

| HA Path | Container Path | Access |
| ------- | -------------- | ------ |
| `/addon_config` | `/addon_config` | RW |
| `/media` | `/media` | RW |
| `/all_addon_configs` | `/all_addon_configs` | RW |
| `/homeassistant_config` | `/homeassistant_config` | RW |
| `/addons` | `/addons` | RW |
| `/backup` | `/backup` | RW |
| `/share` | `/share` | RW |
| `/ssl` | `/ssl` | RW |

## Ports

| Port | Protocol | Default | Description |
| ---- | -------- | ------- | ----------- |
| `8081` | TCP | `8230` | OpenCode Web UI |

## Troubleshooting

### Add-on won't start

- Check logs: **Settings > Add-ons > OpenCode > Logs**
- Verify all required options are configured
- Check that required ports are available

## Upstream Documentation

- [Project Homepage](https://github.com/anomalyco/opencode)
- [GitHub Repository](https://github.com/linuxserver/docker-opencode)
