# Kimai Add-on Documentation

## Getting Started

Kimai is now running and accessible through Home Assistant. You can access it via the Ingress link in the add-on sidebar or directly at the configured port.

### Initial Setup

1. After starting the add-on for the first time, wait 30-60 seconds for the database to initialize
2. Access Kimai through the Home Assistant Ingress interface
3. The default credentials are displayed in the add-on logs
4. Log in and change the admin password immediately

## Configuration

### Options

| Option | Type | Required | Default | Description |
|--------|------|----------|---------|-------------|
| `PUID` | int | No | 0 | User ID for file permissions |
| `PGID` | int | No | 0 | Group ID for file permissions |
| `TZ` | string | No | UTC | Timezone (e.g., `Europe/Berlin`) |
| `data_location` | string | No | `/share/kimai` | Directory to store Kimai data |
| `env_vars` | list | No | [] | Additional environment variables |

### Environment Variables

Advanced configuration can be done through environment variables. Common options:

- `DATABASE_URL`: Database connection string (defaults to SQLite)
- `SYMFONY_ENV`: Set to `prod` for production
- `ADMIN_EMAIL`: Administrator email address
- `ADMIN_NAME`: Administrator name

## File Access

Kimai data is stored in the configured data location (`/share/kimai` by default). You can:

- Access data files through Home Assistant's file editor
- Backup your data by copying the data directory
- Migrate data by copying the directory to a new installation

## Ports

- **80/tcp**: HTTP web interface (also available through Home Assistant Ingress)

## Troubleshooting

### Database Issues

If you see database errors:
1. Check that the data location directory exists and is writable
2. Verify sufficient disk space is available
3. Restart the add-on to reinitialize the database

### Timezone Issues

If times are displayed incorrectly:
1. Set the `TZ` option to your desired timezone (e.g., `America/New_York`)
2. Restart the add-on
3. Clear your browser cache

### Performance Issues

For better performance on slow systems:
1. Increase `PUID` and `PGID` to match Home Assistant user
2. Store data on fast storage (SSD, not SD card if using Raspberry Pi)
3. Limit the number of concurrent users

## Upstream Documentation

For detailed Kimai features and configuration:
- **User Manual**: https://docs.kimai.org/
- **Administrator Guide**: https://docs.kimai.org/administration/
- **GitHub Issues**: https://github.com/kevinpapst/kimai2/issues
