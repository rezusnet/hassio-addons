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
| `default_http_backend` | string | `"127.0.0.1:8080"` | Default Http Backend |
| `default_https_backend` | string | `"127.0.0.1:8443"` | Default Https Backend |
| `routes` | list | `[]` | Routes |

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

- Check logs: **Settings > Add-ons > HAProxy SNI Router > Logs**
- Verify all required options are configured
- Check that required ports are available

## Upstream Documentation

- [Project Homepage](https://www.haproxy.org/)
- [GitHub Repository](https://github.com/linuxserver/docker-haproxy)
