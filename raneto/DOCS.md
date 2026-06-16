# Raneto Add-on Documentation

## Getting Started

After installation and starting the Raneto add-on:

1. Access via Home Assistant Ingress (recommended)
2. Default login: `admin` / `password`
3. Configuration files stored at your configured `data_location`

## Configuration

### `data_location`
Where Raneto stores configuration and markdown files. Default: `/config/raneto`

### `TZ`
Timezone for the container. Examples: `UTC`, `America/New_York`, `Europe/London`

### `PUID` / `PGID`
User and group IDs for file permissions. Default: `0` (root)

## File Structure

Inside your data location:
- `config/config.js` - Main configuration file
- `content/` - Markdown files for your knowledge base
- `images/` - Images served at `/images/`

## Ports

- `3000/tcp` - HTTP web interface (optional, not required if using Ingress)

## Troubleshooting

Check the Home Assistant logs for any errors from the Raneto add-on.

## References

- [Raneto Website](http://raneto.com)
- [Raneto Docs](http://docs.raneto.com)
- [LinuxServer Raneto](https://github.com/linuxserver/docker-raneto)
