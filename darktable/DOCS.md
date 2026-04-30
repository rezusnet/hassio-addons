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

## File Access

The add-on maps the following HA directories:

| HA Path | Container Path | Access |
| ------- | -------------- | ------ |
| `/share` | `/share` | RW |
| `/ssl` | `/ssl` | RO |

## Ports

No ports configured.


## Troubleshooting

### Add-on won't start

- Check logs: **Settings > Add-ons > Darktable > Logs**
- Verify all required options are configured
- Check that required ports are available

## Upstream Documentation

- [Project Homepage](https://www.darktable.org)
- [GitHub Repository](https://github.com/linuxserver/docker-darktable)
