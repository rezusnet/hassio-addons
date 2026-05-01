# pyLoad-ng Configuration Guide

## Getting Started

After installing the add-on:

1. **Start the add-on** - Click "Start" in the add-on interface
2. **Access the web UI** - Click the "Open Web UI" button or navigate to `http://homeassistant.local:8000`
3. **Login** - Use the default credentials:
   - Username: `pyload`
   - Password: `pyload`
4. **Change your password** - Go to Settings → Users and change the default password immediately

## Configuration

### Data Location

The `data_location` option specifies where pyLoad-ng stores its configuration and metadata. This should typically be a persistent location accessible by Home Assistant.

Default: `/share/pyload-ng`

### Environment Variables

You can pass custom environment variables to the container. Common ones include:

- `TZ` - Timezone (e.g., `America/New_York`, `Europe/London`)
- `PGID` - Group ID for the process (default: 0)
- `PUID` - User ID for the process (default: 0)

### File Paths

Once configured, pyLoad-ng will create the following directory structure:

```
<data_location>/
├── config/          # Configuration files
└── downloads/       # Downloaded files (default location)
```

## Ports

| Port | Protocol | Purpose |
|------|----------|---------|
| 8000 | TCP | Web interface (HTTP) |
| 9666 | TCP | Click'n'Load protocol port (optional) |

## File Access

To manage pyLoad-ng configuration and downloads from Home Assistant:

1. **Via SSH** - Connect to your Home Assistant instance and navigate to the data location
2. **Via Samba** - If you have the Samba add-on installed, access shares from your computer
3. **Via Web UI** - Use pyLoad-ng's built-in download manager

## Timezone Configuration

To set a specific timezone:

1. Go to the add-on Settings
2. Set the `TZ` option to your desired timezone
3. Restart the add-on

Common timezone examples:
- `America/New_York` - Eastern Time
- `America/Chicago` - Central Time
- `America/Denver` - Mountain Time
- `America/Los_Angeles` - Pacific Time
- `Europe/London` - UK
- `Europe/Paris` - Central European Time
- `Australia/Sydney` - Australian Eastern Time

## User Configuration

### Default Account

- **Username:** `pyload`
- **Password:** `pyload` (must be changed!)

To add additional users or modify permissions:

1. Login with the default account
2. Go to **Settings → Users**
3. Create new users or modify existing ones

## Troubleshooting

### Web UI Not Responding

1. Check that the add-on is running by looking at the logs
2. Verify port 8000 is not blocked by firewall rules
3. Restart the add-on
4. Check Home Assistant system resources

### Downloads Not Starting

1. Verify the configured download location exists and is writable
2. Check plugin requirements (some plugins may need additional dependencies)
3. Review logs for specific error messages

### Checking Logs

1. Go to the add-on panel in Home Assistant
2. Click on the pyLoad-ng add-on
3. Scroll to the "Logs" section to view real-time output
4. Look for any error messages or warnings

### Port Already in Use

If you get an error about port 8000 being in use:

1. Ensure no other add-on is using port 8000
2. Stop the conflicting add-on first
3. Restart pyLoad-ng

## Advanced Configuration

### Custom Download Location

By default, pyLoad-ng downloads to `/downloads` inside the container, which maps to a location based on your `data_location` setting. To change this:

1. Edit the container environment variables
2. Set the appropriate path for the application
3. Ensure the directory is writable by the application user

### Backup and Restore

To backup your pyLoad-ng configuration:

1. Navigate to your Home Assistant storage location
2. Copy the entire `share/pyload-ng/` directory
3. Store it safely

To restore:

1. Stop the pyLoad-ng add-on
2. Replace the `share/pyload-ng/` directory with your backup
3. Start the add-on

## Links

- [pyLoad Official Website](https://pyload.net/)
- [pyLoad GitHub Repository](https://github.com/pyload/pyload)
- [pyLoad Documentation Wiki](https://github.com/pyload/pyload/wiki)
- [LinuxServer.io Docker Image](https://github.com/linuxserver/docker-pyload-ng)

## Support

For help with this add-on:

- Check the troubleshooting section above
- Review add-on logs for error messages
- Visit the [GitHub Issues page](https://github.com/rezusnet/hassio-addons/issues)
- Consult the official pyLoad documentation
