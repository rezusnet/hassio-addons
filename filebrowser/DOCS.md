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
| `NoAuth` | bool | `True` | Noauth |
| `TZ` | string | `""` | Tz |
| `base_folder` | string | `""` | Base Folder |
| `certfile` | string | `"fullchain.pem"` | Certfile |
| `cifsdomain` | string | `""` | Cifsdomain |
| `cifspassword` | string | `""` | Cifspassword |
| `cifsusername` | string | `""` | Cifsusername |
| `disable_thumbnails` | bool | `True` | Disable Thumbnails |
| `env_vars` | list | `[]` | Env Vars |
| `keyfile` | string | `"privkey.pem"` | Keyfile |
| `localdisks` | string | `""` | Localdisks |
| `networkdisks` | string | `""` | Networkdisks |
| `ssl` | bool | `False` | Ssl |

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
| `8080` | TCP | `8071` | Web UI port |

## Troubleshooting

### Add-on won't start

- Check logs: **Settings > Add-ons > Filebrowser > Logs**
- Verify all required options are configured
- Check that required ports are available

## Upstream Documentation

- [Project Homepage](https://filebrowser.org)
- [GitHub Repository](https://github.com/linuxserver/docker-filebrowser)
