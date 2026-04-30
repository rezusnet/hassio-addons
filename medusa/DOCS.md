# Medusa Add-on Documentation

## Getting Started

After starting the Medusa add-on, you can access the web interface at `http://<your-home-assistant-ip>:8081`.

### Initial Setup

1. Open the Medusa web interface
2. Configure your media libraries and search providers
3. Add shows to your watchlist
4. Configure download and post-processing options

## Configuration

### Options

#### `data_location`

Path where Medusa stores its configuration and database.

Default: `/share/medusa`

#### `PUID`

User ID for file permissions.

Default: `0` (root)

#### `PGID`

Group ID for file permissions.

Default: `0` (root)

#### `TZ`

Timezone for the application. Use standard IANA timezone format (e.g., `America/New_York`, `Europe/London`).

#### Local Disks / Network Disks

Configure access to local or network storage for your TV shows and downloads.

- `localdisks`: Mount local drives (comma-separated)
- `networkdisks`: Mount network shares (comma-separated)
- `cifsusername`: Username for SMB/CIFS access
- `cifspassword`: Password for SMB/CIFS access
- `cifsdomain`: Domain for SMB/CIFS access

#### `env_vars`

Set additional environment variables for advanced configuration.

## File Access

You can access Medusa's configuration files at:

- Configuration: `/share/medusa/`
- Cache: `/share/medusa/cache/`
- Logs: `/share/medusa/log/`

## Ports

- **8081/tcp**: Web interface (accessible via ingress in Home Assistant)

## Ports Description

- **8081/tcp**: Medusa web interface (<http://localhost:8081>)

## Troubleshooting

### Medusa won't start

1. Check the add-on logs for error messages
2. Verify that the `data_location` directory is accessible and writable
3. Ensure your timezone is correctly configured
4. Try removing the `<data_location>/db_file` to reinitialize the database

### Permission issues

1. Verify that `PUID` and `PGID` match your desired user/group
2. Ensure the volume mounts have correct permissions
3. Check that the data_location is writable

### Can't access the web interface

1. Verify the add-on is running (check logs)
2. Check that port 8081 is not blocked by your firewall
3. Try accessing via <http://localhost:8081> if in Home Assistant

## Upstream Documentation

For more information about Medusa, visit:

- [Medusa Official Documentation][medusa-docs]
- [LinuxServer.io Medusa Image][linuxserver-docs]
- [Medusa GitHub Repository][medusa-github]

[medusa-docs]: https://medusa.readthedocs.io/
[linuxserver-docs]: https://docs.linuxserver.io/images/docker-medusa/
[medusa-github]: https://github.com/pymedusa/Medusa
