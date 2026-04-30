# Beets Configuration and Usage

## Getting Started

### First Run

When Beets starts for the first time, it will create the necessary configuration directory structure in your configured data location (default: `/share/beets`).

1. Start the addon
2. Wait 30-60 seconds for initialization
3. Access the web UI at `http://[YOUR_HA_IP]:8337`

### Initial Setup

The first time you access Beets, you'll need to:

1. Configure your music library location
2. Perform initial library import/scan
3. Configure tag sources (MusicBrainz, Spotify, etc.)
4. Customize your library organization

## Configuration

### Addon Options

| Option | Default | Description |
|--------|---------|-------------|
| PUID | 1000 | User ID for running the addon |
| PGID | 1000 | Group ID for running the addon |
| TZ | UTC | Timezone for the addon (e.g., America/New_York) |
| data_location | /share/beets | Path where Beets stores configuration and library metadata |
| env_vars | {} | Additional environment variables |

### Beets Configuration

Beets configuration is managed through:

1. **Web UI**: Use the configuration interface in the web UI for basic settings
2. **config.yaml**: Located at `{data_location}/config.yaml` in the addon container
3. **Environment Variables**: Set via addon options

### Common Configurations

#### Music Library Path

Configure your music library location in Beets web UI or `config.yaml`:

```yaml
library: /media/Music/library.db
directory: /media/Music
import:
  autotag: yes
  write: yes
```

#### Plugin Configuration

Enable and configure Beets plugins in `config.yaml`:

```yaml
plugins:
  - lyrics
  - spotify
  - acousticbrainz
  - web

web:
  host: 0.0.0.0
  port: 8337
```

#### Tag Sources

Configure preferred metadata sources:

```yaml
musicbrainz:
  host: musicbrainz.org

plugins:
  - spotify
```

## File Access

### Storage Locations

- **Data/Config**: `{data_location}` (configurable, default: `/share/beets`)
  - `config.yaml`: Main configuration file
  - `library.db`: SQLite music library database
  - `.beets/`: Additional data and cache

- **Music Files**: Configure in Beets configuration
  - Typically `/media/Music` or similar location with proper permissions

### Accessing Configuration

To edit Beets configuration:

1. Use the web UI configuration interface, or
2. SSH into Home Assistant and edit the config file directly
3. Restart the addon for changes to take effect

## Ports

| Port | Protocol | Purpose |
|------|----------|---------|
| 8337 | TCP | Beets Web UI and API |

Access via: `http://[YOUR_HA_IP]:8337`

## Common Tasks

### Import Music Library

1. Ensure your music files are accessible to the addon
2. Configure the import path in Beets
3. Use the web UI or CLI to trigger import:
   - Web UI: Settings → Import
   - CLI: `beet import /path/to/music`

### Enable Plugins

1. Edit `{data_location}/config.yaml`
2. Add desired plugins to the `plugins` section
3. Configure plugin-specific settings
4. Restart the addon

### Update Music Metadata

1. Use the web UI to search for tracks
2. Select desired matches from MusicBrainz or other sources
3. Apply tags and save

### Backup Your Library

Backup these directories:
- `{data_location}` (configuration and database)
- Your music files directory

## Troubleshooting

### Web UI Not Accessible

- Verify the addon is running (check addon logs)
- Check if port 8337 is not in use by another service
- Restart the addon

### Music Not Found During Import

- Verify music files are readable by the addon (check file permissions)
- Ensure paths in configuration match actual music locations
- Check addon logs for import errors

### Tagging Issues

- Verify you have proper tag source credentials configured (Spotify, MusicBrainz, etc.)
- Check internet connectivity for external tag sources
- Review Beets documentation for tagging strategies

### Permission Errors

- Verify PUID and PGID match your desired user
- Ensure music directory has proper permissions (755 for folders, 644 for files)
- Recreate files with proper ownership if needed

### Checking Logs

View addon logs in Home Assistant:
1. Settings → Add-ons → Beets → Logs
2. Look for error messages and configuration issues

## Advanced Configuration

### Custom Formats

Configure custom file naming and tagging formats in `config.yaml`:

```yaml
paths:
  default: $albumartist/$album%aunique{}/$track - $title
  compilations: Compilations/$album%aunique{}/$track - $title
```

### Database Optimization

Beets uses SQLite for its library database. Occasionally optimize:

```bash
beet optimize
```

### Command Line Usage

SSH into Home Assistant and use the Beets CLI:

```bash
beet list                  # List library contents
beet import /path/to/music # Import music
beet modify query changes  # Modify library entries
beet export               # Export library data
```

## Documentation and Support

- **Beets Manual**: [beets.io/doc/](https://beets.io/doc/)
- **Plugin Documentation**: [beets.io/plugins/](https://beets.io/plugins/)
- **GitHub Issues**: [beetbox/beets](https://github.com/beetbox/beets/issues)
- **LinuxServer.io**: [linuxserver/docker-beets](https://github.com/linuxserver/docker-beets)

## Reporting Issues

If you encounter problems with this addon:

1. Check the addon logs for error messages
2. Verify your configuration is correct
3. Report issues at: [rezusnet/hassio-addons](https://github.com/rezusnet/hassio-addons/issues)

Include:
- Addon version
- Error messages from logs
- Your configuration (without sensitive data)
- Steps to reproduce the issue
