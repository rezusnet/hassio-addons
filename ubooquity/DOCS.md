# Ubooquity Add-on Documentation

## Getting Started

Ubooquity is a free, lightweight, and easy-to-use home server for your comics and ebooks. This add-on brings Ubooquity to Home Assistant.

### Initial Setup

1. **Start the add-on:** Click the "Start" button in Home Assistant
2. **Access admin interface:** Navigate to `http://<your-home-assistant>:2203/ubooquity/admin`
3. **Set admin password:** Create a password to protect your instance
4. **Configure library paths:** Add paths to your comics and ebooks folders
5. **Access library:** Navigate to `http://<your-home-assistant>:2202/ubooquity/`

## Configuration

### Options

| Option          | Type    | Default            | Description                                          |
| --------------- | ------- | ------------------ | ---------------------------------------------------- |
| `PUID`          | Integer | 0                  | User ID for file permissions                         |
| `PGID`          | Integer | 0                  | Group ID for file permissions                        |
| `data_location` | String  | `/share/ubooquity` | Location for Ubooquity data and database             |
| `TZ`            | String  | Empty              | Timezone (e.g., `America/New_York`, `Europe/London`) |
| `MAXMEM`        | String  | Empty              | Maximum memory in MB (e.g., `1024` for 1GB)          |
| `localdisks`    | String  | Empty              | Comma-separated list of local disks to mount         |
| `networkdisks`  | String  | Empty              | Comma-separated list of network shares (SMB)         |
| `cifsusername`  | String  | Empty              | Username for SMB authentication                      |
| `cifspassword`  | String  | Empty              | Password for SMB authentication                      |
| `cifsdomain`    | String  | Empty              | Domain for SMB authentication                        |

### Configuration Examples

**Basic Setup:**

```yaml
data_location: /share/ubooquity
TZ: America/New_York
```

**With Memory Limit:**

```yaml
data_location: /share/ubooquity
TZ: America/New_York
MAXMEM: "1024"
```

**With SMB Network Share:**

```yaml
data_location: /share/ubooquity
networkdisks: "//192.168.1.100/media"
cifsusername: "myuser"
cifspassword: "mypass"
cifsdom:
"WORKGROUP"
```

## File Access

### Data Location

By default, Ubooquity stores all configuration and database files in `/share/ubooquity`. This location is persistent across add-on restarts.

### Adding Content

Place your comics and ebooks in:

- `/share/ubooquity/comics` (for comics)
- `/share/ubooquity/ebooks` (for ebooks)
- `/share/ubooquity/files` (for other files)

Or mount external storage via the `localdisks` or `networkdisks` options.

### Supported Formats

**Comics:**

- CBR (RAR compressed)
- CBZ (ZIP compressed)
- CB7 (7Z compressed)
- CBA (ACE compressed)
- CBT (TAR compressed)

**Ebooks:**

- EPUB
- PDF
- MOBI
- AZW (Kindle format)
- ZIP containing supported formats

## Ports

| Port | Protocol | Description                       |
| ---- | -------- | --------------------------------- |
| 2202 | TCP      | Ubooquity library interface (web) |
| 2203 | TCP      | Ubooquity admin interface         |

## File Paths

- **Config/Database:** `/config` (inside container, mounted to `/share/ubooquity` by default)
- **Comics:** `/comics` (inside container)
- **Ebooks:** `/ebooks` (inside container)
- **Raw Files:** `/files` (inside container)

## Troubleshooting

### Files Not Scanning

1. Ensure the directory path is correct
2. Check file permissions (PUID/PGID settings)
3. Restart the add-on
4. Check Ubooquity logs in Home Assistant

### Connection Issues

1. Verify port 2202 (library) and 2203 (admin) are not blocked
2. Ensure the add-on is running
3. Check Home Assistant logs for errors

### Memory Issues

If experiencing high memory usage:

1. Set `MAXMEM` option to limit Java heap size (e.g., `1024` for 1GB)
2. Reduce the number of concurrent connections
3. Consider splitting your collection

### SMB/Network Share Issues

1. Verify network credentials in `cifsusername` and `cifspassword`
2. Ensure network path is accessible: `//server/share`
3. Check domain setting in `cifsdomain` if using Windows domains
4. Verify firewall allows SMB traffic (port 445)

### Lost Admin Password

Unfortunately, the admin password cannot be reset. You must:

1. Stop the add-on
2. Delete `/share/ubooquity/` directory
3. Restart the add-on (reinitializes with no password)
4. Set a new password

## Performance Tips

1. **Use local storage** for better performance than network shares
2. **Set reasonable MAXMEM** based on your system (512MB-2048MB typical)
3. **Organize library** with proper folder structure for faster scanning
4. **Regular backups** of `/share/ubooquity` configuration
5. **Disable unused features** in admin settings to reduce resource usage

## Timezone

To set your timezone, specify it in the `TZ` option using [IANA timezone format](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones):

Examples:

- `America/New_York`
- `Europe/London`
- `Asia/Tokyo`
- `Australia/Sydney`
- `Etc/UTC` (default)

## Upstream Documentation

For more information about Ubooquity, visit:

- [Ubooquity Official Website](https://vaemendis.net/ubooquity/)
- [LinuxServer.io Docker Documentation](https://docs.linuxserver.io/images/docker-ubooquity/)
- [GitHub Repository](https://github.com/linuxserver/docker-ubooquity)

## Support

For issues with this Home Assistant add-on, visit:

- [rezusnet/hassio-addons Issues](https://github.com/rezusnet/hassio-addons/issues)
