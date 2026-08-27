# pyLoad-ng Add-on Documentation

## Getting Started

### Initial Access

After starting the add-on:

1. Access via **Ingress** (Home Assistant sidebar) - recommended
2. Or directly at `http://<your-ha-ip>:8000`
3. Default login:
   - Username: `pyload`
   - Password: `pyload`

**IMPORTANT:** Change the default password immediately after first login.

## Configuration

All configuration options are set in the add-on settings before starting.

### Configuration Options

| Option          | Type    | Default          | Description                      |
| --------------- | ------- | ---------------- | -------------------------------- |
| `PUID`          | integer | 0                | User ID for file permissions     |
| `PGID`          | integer | 0                | Group ID for file permissions    |
| `TZ`            | string  | (empty)          | Timezone (e.g., Europe/London)   |
| `data_location` | string  | /share/pyload-ng | Location to store pyload-ng data |

### Advanced Options (for custom environments)

| Option         | Type   | Default | Description                                                      |
| -------------- | ------ | ------- | ---------------------------------------------------------------- |
| `localdisks`   | string | (empty) | Comma-separated list of local disk mount paths                   |
| `networkdisks` | string | (empty) | Comma-separated list of SMB/CIFS shares (format: //server/share) |
| `cifsusername` | string | (empty) | Username for SMB/CIFS authentication                             |
| `cifspassword` | string | (empty) | Password for SMB/CIFS authentication                             |
| `cifsdomain`   | string | (empty) | Domain for SMB/CIFS authentication                               |

## File Access

### Data Structure

pyLoad-ng stores data in the configured `data_location`:

```
data_location/
├── config/          # Configuration files
├── logs/            # Application logs
└── downloads/       # Downloaded files
```

### Accessing via File Editor

1. Home Assistant file structure:
   - Add-on config: `/config/` (Home Assistant config directory)
   - pyLoad-ng data: `data_location` setting (default: `/share/pyload-ng`)
   - Share folder: `/share`

2. Access logs and configuration:
   - Logs: `<data_location>/logs/`
   - Configuration: `<data_location>/config/`

## Ports

| Port | Protocol | Description   |
| ---- | -------- | ------------- |
| 8000 | TCP      | Web interface |

**Note:** The web interface is accessible via Home Assistant Ingress and also directly at `http://<ha-ip>:8000`.

## Network Shares (SMB/CIFS)

To access network shares from pyLoad-ng:

1. Set `networkdisks` to the SMB path (e.g., `//192.168.1.100/Downloads`)
2. Provide authentication credentials if required:
   - `cifsusername`: SMB username
   - `cifspassword`: SMB password
   - `cifsdomain`: SMB domain (if applicable)

Multiple shares can be separated by commas.

## Local Disk Mounting

To access local USB/SATA/NVMe storage:

1. Ensure the disk is mounted to the Home Assistant host
2. Set `localdisks` to the mount path (e.g., `/media/usb,/mnt/nas`)

## Environment Variables

Additional environment variables can be passed via the config panel for advanced customization. Standard LinuxServer.io variables like `DOCKER_MODS` are supported.

## Troubleshooting

### Cannot connect to web interface

- Verify the add-on is running (check Logs tab)
- Check firewall settings on your Home Assistant instance
- Verify port 8000 is accessible
- Try accessing directly at `http://<ha-ip>:8000`

### Permission denied errors

- Ensure `PUID` and `PGID` match your Home Assistant user
- Check file/folder ownership: `ls -ln <data_location>`
- Restart the add-on after changing PUID/PGID

### Download failures

- Check pyLoad-ng logs: `<data_location>/logs/`
- Verify network connectivity
- Check if the download source is still valid
- Review pyLoad-ng web interface for plugin/service issues

### Network shares not accessible

- Verify SMB credentials are correct
- Test share accessibility from Home Assistant host: `smbclient -L //server/share`
- Check firewall rules between Home Assistant and SMB server
- Ensure shares are properly mounted before starting pyLoad-ng

### Storage space issues

- Check available space: `df -h <data_location>`
- Configure automatic cleanup or manual download removal in pyLoad-ng web interface
- Move downloads to larger storage location

## Timezone Configuration

To set a custom timezone, use standard timezone identifiers in the `TZ` field:

Examples:

- `Europe/London`
- `America/New_York`
- `Asia/Tokyo`
- `Australia/Sydney`

See [timezone database](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) for full list.

## Advanced: DOCKER_MODS

LinuxServer.io Docker mods can be applied for additional functionality. Add to config options as a JSON array (if your config allows custom fields):

```json
{
  "DOCKER_MODS": ["linuxserver/mods:pyload-ng-module-name"]
}
```

Consult LinuxServer.io documentation for available mods.

## Official Resources

- **pyLoad-ng GitHub:** https://github.com/pyload/pyload
- **pyLoad-ng Wiki:** https://github.com/pyload/pyload/wiki
- **LinuxServer.io Documentation:** https://docs.linuxserver.io/images/docker-pyload-ng/
- **LinuxServer.io Discord:** https://discord.gg/YWrKVTn

## Support

For issues specific to this add-on, visit:
https://github.com/rezusnet/hassio-addons/issues
