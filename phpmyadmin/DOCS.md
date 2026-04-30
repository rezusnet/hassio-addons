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
| `PGID` | int | `0` | Process Group ID |
| `PUID` | int | `0` | Process User ID |
| `TZ` | string | `""` | Timezone |
| `data_location` | string | `"/share/phpmyadmin"` | Data Location |
| `env_vars` | list | `[]` | Environment Variables |

## File Access

The add-on maps the following HA directories:

| HA Path | Container Path | Access |
| ------- | -------------- | ------ |
| `/share` | `/share` | RO |
| `/media` | `/media` | RW |

## Ports

| Port | Protocol | Default | Description |
| ---- | -------- | ------- | ----------- |
| `80` | TCP | `80` | Web interface |

## Troubleshooting

### Add-on won't start

- Check logs: **Settings > Add-ons > PhpMyAdmin > Logs**
- Verify all required options are configured
- Check that required ports are available

### Cannot connect to database

- Ensure the MariaDB/MySQL service is running and accessible
- Verify the correct host, username, and password are configured
- Check database service logs for errors

## Upstream Documentation

- [Project Homepage](https://github.com/linuxserver/docker-phpmyadmin)
- [GitHub Repository](https://github.com/linuxserver/docker-phpmyadmin)
- [PhpMyAdmin Official Site](https://www.phpmyadmin.net/)
