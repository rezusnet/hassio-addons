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
| `access_token_expiry` | int | `3600` | Access Token Expiry |
| `allow_cors` | bool | `False` | Allow Cors |
| `allow_iframe` | bool | `True` | Allow Iframe |
| `audiobooks_path` | string | `"/media/audiobooks"` | Audiobooks Path |
| `backup_path` | string | `""` | Backup Path |
| `disable_ssrf_filter` | bool | `False` | Disable Ssrf Filter |
| `env_vars` | list | `[]` | Env Vars |
| `exp_proxy_support` | bool | `False` | Exp Proxy Support |
| `max_failed_episode_checks` | int | `24` | Max Failed Episode Checks |
| `podcast_download_timeout` | int | `30` | Podcast Download Timeout |
| `podcasts_path` | string | `"/media/podcasts"` | Podcasts Path |
| `query_logging` | string | `""` | Query Logging |
| `rate_limit_auth_max` | int | `40` | Rate Limit Auth Max |
| `rate_limit_auth_window` | int | `600000` | Rate Limit Auth Window |
| `refresh_token_expiry` | int | `2592000` | Refresh Token Expiry |
| `router_base_path` | string | `"/audiobookshelf"` | Router Base Path |
| `skip_binaries_check` | bool | `False` | Skip Binaries Check |
| `ssrf_whitelist` | string | `""` | Ssrf Whitelist |
| `use_x_accel` | bool | `False` | Use X Accel |

## File Access

The add-on maps the following HA directories:

| HA Path | Container Path | Access |
| ------- | -------------- | ------ |
| `/addon_config` | `/addon_config` | RW |
| `/media` | `/media` | RW |
| `/share` | `/share` | RW |

## Ports

| Port | Protocol | Default | Description |
| ---- | -------- | ------- | ----------- |
| `8133` | TCP | `8133` | Audiobookshelf Web UI |

## Troubleshooting

### Add-on won't start

- Check logs: **Settings > Add-ons > Audiobookshelf > Logs**
- Verify all required options are configured
- Check that required ports are available

## Upstream Documentation

- [Project Homepage](https://github.com/advplyr/audiobookshelf)
- [GitHub Repository](https://github.com/advplyr/audiobookshelf)
