# TheLounge Documentation

## Getting Started

TheLounge is a web-based IRC client that allows you to connect to and manage multiple IRC networks from your browser. This add-on runs TheLounge as a service in Home Assistant.

### First Run

1. Start the add-on
2. Wait for the service to initialize (check logs for "TheLounge initialization complete")
3. Access the web interface through the Ingress link or direct URL
4. Create a user account on first access
5. Add IRC networks and join channels

## Configuration

### Add-on Settings

The following configuration options are available in the Home Assistant UI:

| Option | Default | Description |
|--------|---------|-------------|
| PUID | 1000 | User ID for TheLounge service |
| PGID | 1000 | Group ID for TheLounge service |
| TZ | UTC | Timezone setting (e.g., America/New_York) |
| data_location | /share/thelounge | Path where TheLounge data is stored |
| env_vars | — | Additional environment variables |

### IRC Network Configuration

TheLounge networks are configured through the web interface:

1. Open TheLounge in your browser
2. Click "Settings" → "Add a new network"
3. Enter network details:
   - **Network Name**: Display name for the network
   - **Server**: IRC server address (e.g., irc.libera.chat)
   - **Port**: IRC port (typically 6667 for plaintext, 6697 for SSL/TLS)
   - **Nick**: Your IRC nickname
   - **Username**: IRC username
   - **Real Name**: Your display name
4. Enable TLS if connecting to a secure server
5. Click "Connect"

### User Settings

Configure your TheLounge experience through:
- **Appearance**: Theme, font size, timestamps
- **Highlights**: Custom word highlighting rules
- **Advanced**: Logging settings, notification preferences

## Ports

- **9000/tcp**: TheLounge web interface (HTTP)

## File Access

TheLounge stores all data in `/share/thelounge`:

- `config.js`: Main TheLounge configuration file
- `users/`: User account data
- `logs/`: Chat history and logs (if enabled)
- `db/`: Database files

To access or modify these files directly:
1. Use the Samba add-on for network access
2. Or use SSH access if configured

## IRC Network Examples

### Libera Chat
- **Server**: irc.libera.chat
- **Port**: 6667 (plain) or 6697 (SSL/TLS)
- **Channels**: #general, #python, #linux

### EFnet
- **Server**: irc.efnet.org
- **Port**: 6667 (plain) or 6697 (SSL/TLS)

### Undernet
- **Server**: us.undernet.org
- **Port**: 6667 (plain) or 6697 (SSL/TLS)

## Troubleshooting

### Service Won't Start

Check the add-on logs for error messages:
1. Go to Settings → Add-ons → TheLounge → Logs
2. Look for initialization errors
3. Verify data_location path is accessible

### Can't Connect to IRC Network

- Verify server address and port are correct
- Check if TLS/SSL is required for the port
- Ensure firewall allows outbound connections on that port
- Try with a different nickname if the current one is in use

### Lost Connection

TheLounge maintains persistent connections. If connection drops:
1. Check network connectivity
2. Verify IRC server is online
3. Restart the add-on if needed

### Web Interface Not Loading

- Wait 30-60 seconds after starting for full initialization
- Check add-on logs for startup errors
- Verify port 9000 isn't blocked by firewall
- Try accessing via direct URL if Ingress is having issues

## Advanced Configuration

For advanced configuration, edit `/share/thelounge/config.js`:

- Server bind address
- Logging preferences
- Max connections per user
- Message history limits

Changes require restart of the add-on to take effect.

## Performance

TheLounge is lightweight and suitable for Home Assistant systems. Typical resource usage:
- CPU: Minimal (< 5% during idle)
- Memory: 50-150 MB depending on activity
- Disk: Depends on log retention settings

## Security

- Always use strong passwords for user accounts
- Consider disabling public mode if not needed
- Use TLS/SSL when connecting to IRC networks
- Regularly update the add-on for security patches

## Upstream Links

- [TheLounge Official Site](https://thelounge.chat/)
- [TheLounge Configuration Guide](https://docs.thelounge.chat/guides/client.html)
- [TheLounge Themes](https://docs.thelounge.chat/guides/themes.html)
- [LinuxServer.io TheLounge](https://docs.linuxserver.io/images/docker-thelounge/)
