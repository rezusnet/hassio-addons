# Ubooquity Documentation

## Getting Started

After installing and starting the add-on, you can access Ubooquity via:

- **Library Interface**: `http://<your-ha-ip>:2202/ubooquity/`
- **Admin Interface**: `http://<your-ha-ip>:2203/ubooquity/admin`
- **Home Assistant Sidebar**: Click "Ubooquity" in the sidebar (if using Ingress)

## Initial Setup

1. **Admin Access**: First, access the admin interface at port 2203
2. **Set Password**: Create a password to secure your library
3. **Configure Paths**: Set up paths to your comics and ebooks libraries
4. **Library Scan**: Ubooquity will automatically scan your files on startup

## Configuration Options

### PUID / PGID

Controls which user/group the container runs as. Set to match your Home Assistant setup:

- `PUID=1000` and `PGID=1000` for standard installations
- `PUID=0` and `PGID=0` to run as root (default)

### Data Location

Directory where Ubooquity stores its configuration, database, and metadata:

- **Default**: `/share/ubooquity`
- Create as much space as needed for your metadata database

### Timezone (TZ)

Set the timezone for the container:

- Examples: `Etc/UTC`, `America/New_York`, `Europe/London`
- Affects timestamps in logs and interface

### Max Memory (MAXMEM)

Controls Java heap memory allocation:

- **Value**: Number of megabytes (e.g., `512`, `1024`, `2048`)
- **Default**: 512 MB if not set
- Increase if you experience `OutOfMemoryError` exceptions
- Must be less than your system's total available RAM

### Docker Mods (DOCKER_MODS)

Optional LinuxServer.io community modifications:

- Specify as array of valid mods (e.g., `linuxserver/mods:ubooquity-*`)
- Leave empty to skip

## File Access

Ubooquity uses the following mounted volumes:

- `/config` → `/share/ubooquity` - Configuration and metadata
- `/books` → `/books` - Ebook library location
- `/comics` → `/comics` - Comics library location
- `/files` → `/files` - Raw media files directory

Ensure all paths are readable by the container user (PUID/PGID).

## Ports

- **Port 2202/TCP**: Library web interface (default ingress port)
- **Port 2203/TCP**: Admin interface for configuration

## Library Management

### Adding Content

1. Mount your libraries to the addon via Home Assistant
2. Ubooquity automatically scans `/comics`, `/books`, and `/files` directories
3. Place your content in appropriate directories:
   - Comics/Manga in `/comics`
   - Ebooks in `/books`
   - Other media in `/files`

### Supported Formats

- **Comics**: CBZ, CBR, ZIP, RAR
- **Ebooks**: EPUB, PDF, CBZ, CBR, and more
- **Scans**: Supports large image collections

### Scanner Settings

In the admin interface, you can:

- Force a library rescan
- Configure automatic rescanning intervals
- Set file type associations
- Customize folder display names

## Troubleshooting

### Application Won't Start

Check logs in Home Assistant:

1. Go to **Settings** → **Add-ons & automations** → **Add-ons**
2. Select Ubooquity → **Logs** tab
3. Look for error messages

### Memory Issues

If you see `java.lang.OutOfMemoryError`:

1. Increase MAXMEM setting in add-on options
2. Reduce library size or disable automatic scanning
3. Check available system RAM

### Library Not Scanning

Ensure:

1. Paths are mounted correctly (visible in admin interface)
2. File permissions allow reading
3. Format is supported by Ubooquity
4. Files aren't corrupted

### Can't Access Library

1. Verify ports 2202 and 2203 are open
2. Check if admin password was set
3. Ensure data_location has sufficient permissions
4. Restart the add-on from Home Assistant

## Performance Tips

1. **Use SSD storage** for the data_location (faster database operations)
2. **Disable automatic scanning** if you have very large libraries (manually scan periodically)
3. **Limit memory carefully** - too low causes crashes, too high wastes resources
4. **Regular backups** of `/share/ubooquity` configuration directory
5. **Monitor logs** for any scanning errors or warnings

## Security

- Always set a strong admin password in the admin interface
- Use Home Assistant's network security for remote access
- Don't expose ports directly to the internet without authentication
- Consider using Home Assistant's reverse proxy with authentication

## Support & Documentation

- [Ubooquity Official Site](https://vaemendis.net/ubooquity/)
- [LinuxServer.io Docker Image](https://github.com/linuxserver/docker-ubooquity)
- [Home Assistant Add-ons Repository](https://github.com/rezusnet/hassio-addons)

## Advanced: Environment Variables

Additional environment variables can be set via Docker mods or by editing the add-on options. Common LinuxServer variables:

- `UMASK`: Default file/folder creation mask (default: 022)
- `PGID` / `PUID`: Already covered above
- `TZ`: Already covered above
