![NGircd](banner.svg)

# NGircd Add-on

NGircd is a free, portable, and lightweight Internet Relay Chat (IRC) server. This add-on wraps the official [LinuxServer.io](https://linuxserver.io) Docker image for NGircd, enabling you to run a full-featured IRC server within Home Assistant.

## Key Features

- 🔗 **Full IRC Protocol Support** - Fully compliant IRC daemon (RFC 2812/2813)
- 👥 **User Management** - User authentication and channels with operators
- 🔒 **Security Features** - TLS/SSL support for encrypted connections
- 🌐 **Multiple Networks** - Support for federated IRC networks
- ⚙️ **Configurable** - Customize server name, max connections, and more
- 💾 **Persistent Storage** - Configuration and data stored in Home Assistant
- 📊 **MOTD Support** - Custom message of the day for connecting clients
- 🎯 **Lightweight** - Minimal resource usage, perfect for Home Assistant

## Installation

1. Add the repository to Home Assistant (if not already added)
2. Navigate to Settings → Add-ons → Add-on Store
3. Search for "NGircd" and select it
4. Click "Install"
5. Configure your IRC server (see Configuration)
6. Click "Start"

## Configuration

### Basic Setup

1. **Server Name** - The hostname for your IRC server (e.g., "irc.home.local")
2. **Server Info** - Description shown to connecting clients
3. **Max Connections** - Maximum number of simultaneous connections
4. **Max Clients Per Host** - Maximum clients from a single IP address
5. **MOTD** - Optional message displayed when users connect

### Default Configuration

- **Port 6667** - Standard IRC port (unencrypted)
- **Port 6668** - TLS/SSL encrypted connections
- **Storage** - All data stored in `/share/ngircd/`

## Access

### IRC Clients

Connect using any IRC client:
- **Server**: Your Home Assistant IP or hostname
- **Port**: 6667 (standard) or 6668 (TLS)
- **Example**: `irc.home.local:6667`

### Popular IRC Clients

- Hexchat (Windows, Linux, macOS)
- mIRC (Windows)
- Weechat (Linux, macOS)
- Irssi (Terminal)
- LimeChat (macOS)
- IRCCloud (Web)

## Features

### Channel Operations

- Create and manage IRC channels
- Set channel modes and topics
- Manage operators and voices
- User bans and kicks

### Server Features

- MOTD (Message of the Day)
- User modes and channel modes
- Operator functionality
- Connection limits and throttling
- TLS/SSL encryption support

## Configuration Examples

### Example: Family Home Network

```yaml
server_name: home-irc.local
server_info: "Home Network Chat Server"
max_connections: 50
max_clients_per_host: 5
motd: "Welcome to the Home Network IRC Server!"
```

### Example: Small Community Server

```yaml
server_name: community.local
server_info: "Community Chat Hub"
max_connections: 200
max_clients_per_host: 10
```

## Troubleshooting

### Can't connect to server
- Verify Home Assistant firewall allows port 6667/6668
- Check server is running in add-on settings
- Confirm correct hostname/IP address
- Review add-on logs

### Connection drops
- Check max_connections and max_clients_per_host settings
- Monitor available memory in Home Assistant
- Review system logs for errors

### TLS connection issues
- Ensure port 6668 is open
- Self-signed certificates are automatically generated
- Accept untrusted certificate warnings in your IRC client

## Advanced Configuration

### MOTD Setup

Create a custom Message of the Day:

```yaml
motd: |
  Welcome to our IRC server!
  For help, type: /help
```

### Performance Tuning

For a larger user base, adjust:
```yaml
max_connections: 500
max_clients_per_host: 20
```

For restricted deployments:
```yaml
max_connections: 20
max_clients_per_host: 2
```

## Ports

| Port | Protocol | Description |
|------|----------|-------------|
| 6667 | TCP | Standard IRC Server |
| 6668 | TCP | IRC with TLS/SSL |

## File Structure

All NGircd data is stored at `/share/ngircd/`:
- Configuration files
- MOTD file
- User databases
- Channel information

## Support

For issues and questions:
- [NGircd Official Website](https://ngircd.barton.de)
- [LinuxServer.io NGircd](https://github.com/linuxserver/docker-ngircd)
- [IRC Concepts & Documentation](https://tools.ietf.org/html/rfc2812)

## License

NGircd is licensed under the GNU General Public License (GPL).
