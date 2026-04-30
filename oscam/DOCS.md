# Oscam Add-on Documentation

## Getting Started

Oscam is now running as a CAM emulator. You can configure it to work with your IPTV clients and digital TV applications.

### Initial Setup

1. After starting the add-on, wait for initialization (10-20 seconds)
2. Configuration files are created in `/share/oscam/config/`
3. Edit configuration as needed for your setup
4. Restart the add-on if configuration changes don't take effect

## Configuration

### Options

| Option | Type | Required | Default | Description |
|--------|------|----------|---------|-------------|
| `PUID` | int | No | 0 | User ID for file permissions |
| `PGID` | int | No | 0 | Group ID for file permissions |
| `TZ` | string | No | UTC | Timezone |
| `data_location` | string | No | `/share/oscam` | Directory for config and data |
| `env_vars` | list | No | [] | Additional environment variables |

## Configuration Files

Oscam configuration is stored in `/share/oscam/config/`:

### oscam.conf

Main configuration file:

```
[main]
port = 9000
addr = 0.0.0.0

[dvbapi]
enabled = 1
port = 9000
```

### oscam.server

Server configuration for different CA systems.

### oscam.user

Define users and their permissions:

```
[user]
user = guest
pwd = guest
au = 1
```

### oscam.srvid

Service ID definitions for specific channels.

## Port Configuration

- **Default Port**: 9000 (DVBAPI/CAM)
- **Protocol**: TCP/UDP

## Connecting IPTV Clients

Most IPTV clients support DVBAPI via Oscam:

1. **Kodi/Plex**: Install DVBAPI plugin
2. **VLC**: Add DVBAPI support
3. **Enigma2**: Connect to Oscam server
4. **Custom Apps**: Configure to connect to port 9000

## Smart Card Reader Setup

For real card access:

1. Connect compatible smart card reader (optional)
2. Configure reader in oscam.conf
3. Define card provider in oscam configuration
4. Restart Oscam

Supported readers depend on the build and drivers.

## Troubleshooting

### Oscam Won't Start

1. Check add-on logs for errors
2. Verify configuration files are valid
3. Check port 9000 is available
4. Restart the add-on

### Connection Failed

1. Verify port 9000 is exposed
2. Check firewall allows port 9000
3. Verify Oscam is running: `netstat -tlnp | grep 9000`
4. Test connection: `telnet <hostname> 9000`

### Configuration Changes Not Applied

1. Edit configuration files
2. Restart the add-on from Home Assistant
3. Check logs to confirm restart

### Performance Issues

1. Check system resources (CPU, memory)
2. Optimize Oscam configuration
3. Reduce number of concurrent connections
4. Check network latency to clients

## Advanced Configuration

### Enable Detailed Logging

Edit `/share/oscam/config/oscam.conf`:

```
[general]
logfile = /share/oscam/logs/oscam.log
debug = 1
```

### Configure for Specific CA System

Create provider-specific configuration in oscam.server.

### Set Up Multiple Users

Configure different users with varying permissions in oscam.user.

## Data Storage

- **Configuration**: `/share/oscam/config/`
- **Logs**: `/share/oscam/logs/`
- **Cache**: `/share/oscam/cache/`

## Important Notes

- Oscam is designed for legitimate access to licensed content
- Usage must comply with local laws and regulations
- This add-on is provided for educational and legal purposes only
- Ensure proper licensing for any content you access

## Upstream Documentation

For Oscam technical documentation:
- **GitHub**: https://github.com/E2OpenPlugins/e2openplugin-OpenCam
- **Official Site**: http://www.streamboard.goys.de/oscam/
- **Config Guide**: https://github.com/E2OpenPlugins/e2openplugin-OpenCam/wiki
- **Protocols**: https://github.com/E2OpenPlugins/e2openplugin-OpenCam/wiki/Protocols
