# NGircd Add-on Documentation

## Getting Started

NGircd (Next Generation IRC Daemon) is a lightweight, fully-featured IRC server. This add-on allows you to host your own IRC server within Home Assistant.

### Initial Setup

1. **Configure Your IRC Server**:
   - Set `server_name` (e.g., "irc.home.local")
   - Set `server_info` (description for your server)
   - Configure max connections and clients per host

2. **Start the Add-on**:
   - Click the Start button
   - Wait for initialization (10-20 seconds)
   - Check logs for any startup errors

3. **Connect with IRC Client**:
   - Open your favorite IRC client
   - Server: Your Home Assistant IP or hostname
   - Port: 6667 (standard) or 6668 (TLS/SSL)

## Configuration

### Configuration Table

| Option | Type | Required | Default | Description |
|--------|------|----------|---------|-------------|
| `data_location` | String | No | `/share/ngircd` | Where to store NGircd configuration and data |
| `server_name` | String | No | `ngircd.localdomain` | Hostname of the IRC server |
| `server_info` | String | No | `NGircd IRC Server` | Server description shown to clients |
| `max_connections` | Integer | No | 100 | Maximum simultaneous connections |
| `max_clients_per_host` | Integer | No | 10 | Maximum clients allowed from same IP |
| `motd` | String | No | (empty) | Message of the Day displayed on connect |
| `log_level` | Integer | No | 2 | Log verbosity (0-5, higher = more verbose) |

### Example Configuration YAML

```yaml
data_location: /share/ngircd
server_name: irc.home.local
server_info: "Home Network IRC Server"
max_connections: 100
max_clients_per_host: 10
motd: "Welcome to our IRC server!"
log_level: 2
```

## IRC Client Setup

### Connecting to Your Server

**Basic Connection Information:**
- **Server Address**: Your Home Assistant hostname or IP
- **Port**: 6667 (default) or 6668 (TLS/SSL)
- **Nickname**: Your desired IRC username
- **Username**: Optional, same as nickname by default
- **Real Name**: Optional, your display name

### Hexchat (Recommended)

1. Open Hexchat
2. Click "Network List"
3. Enter server details:
   - Hostname: Your HA IP
   - Port: 6667 or 6668
4. Click "Connect"

### Weechat (Terminal)

```bash
/server add home-irc your-ha-ip/6667
/connect home-irc
```

### mIRC (Windows)

1. Tools → Options → Connect
2. Add new server:
   - Description: Home IRC
   - IRC Server: Your HA IP
   - Port: 6667
3. Connect

### Irssi (Terminal)

```bash
/connect -ssl_verify off your-ha-ip 6668
```

## Ports and Network Configuration

### Port Forwarding (for external access)

If you want to access your IRC server from outside your local network:

1. In your router, forward:
   - `6667/TCP` → Home Assistant IP:6667
   - `6668/TCP` → Home Assistant IP:6668

2. Update client connections to use your external IP or dynamic DNS

### Firewall Configuration

Home Assistant firewall must allow:
- Port 6667/TCP (standard IRC)
- Port 6668/TCP (TLS/SSL IRC)

## IRC Commands Reference

### User Commands

| Command | Description | Example |
|---------|-------------|---------|
| `/JOIN` | Join a channel | `/join #general` |
| `/PART` | Leave a channel | `/part #general` |
| `/NICK` | Change nickname | `/nick mynewname` |
| `/MSG` | Send private message | `/msg user message` |
| `/LIST` | List all channels | `/list` |
| `/NAMES` | List channel members | `/names` |
| `/QUIT` | Disconnect | `/quit` |

### Channel Operator Commands

| Command | Description | Example |
|---------|-------------|---------|
| `/KICK` | Remove user | `/kick #channel user reason` |
| `/BAN` | Ban user | `/ban #channel user!*@*` |
| `/MODE` | Set channel modes | `/mode #channel +o user` |
| `/TOPIC` | Set channel topic | `/topic #channel New topic` |

## Troubleshooting

### Connection Issues

**"Connection refused"**
- Verify NGircd add-on is running
- Check Home Assistant firewall allows port 6667/6668
- Verify correct hostname/IP address
- Check no other service uses port 6667/6668

**"Connection timeout"**
- Verify network connectivity between client and Home Assistant
- Check router firewall settings
- Confirm correct port number

### Performance Issues

**Server responding slowly**
- Check `max_connections` limit not reached
- Monitor Home Assistant CPU/memory usage
- Reduce `log_level` to decrease disk I/O
- Restart the add-on

**Users disconnecting frequently**
- Increase `max_connections` limit
- Check network stability
- Review Home Assistant logs for errors

### Channel/User Issues

**Can't create channels**
- Ensure you're connected and authenticated
- Try different channel name (avoid special characters)

**Can't modify channel settings**
- Verify you have operator (voice/op) status
- Use `/MODE` command to set operator modes

## File Access

NGircd data stored at `/share/ngircd/`:

- **ircd.conf**: Main configuration file
- **ircd.motd**: Message of the Day
- **Users/channels**: Server state files

Access via:
- File editor in Home Assistant
- SSH add-on
- SMB share (if configured)

## Security Considerations

### TLS/SSL Encryption

- Port 6668 provides encrypted connections
- Self-signed certificates are used
- IRC clients may show security warnings (normal and safe)

### User Authentication

- NGircd supports PASS command for channel passwords
- Operator passwords can be configured in config files
- No built-in user database; use PASS for channel protection

### Network Access

- Only expose IRC ports if you want external access
- Use firewall to restrict connections if needed
- Consider VPN for secure remote access

## Advanced Configuration

### Custom Data Location

To use a custom data directory:

```yaml
data_location: /share/my-irc-server
```

### MOTD Formatting

Multi-line MOTD:

```yaml
motd: |
  ========================================
  Welcome to Home Network IRC
  ========================================
  
  Rules:
  - Be respectful
  - No spamming
  
  Have fun!
```

### Maximum Connections Tuning

**For small home network:**
```yaml
max_connections: 20
max_clients_per_host: 3
```

**For medium community:**
```yaml
max_connections: 150
max_clients_per_host: 8
```

**For large deployment:**
```yaml
max_connections: 500
max_clients_per_host: 20
```

## Upstream Documentation

For complete NGircd documentation:
- [NGircd Project](https://ngircd.barton.de)
- [IRC Protocol (RFC 2812)](https://tools.ietf.org/html/rfc2812)
- [LinuxServer.io NGircd](https://github.com/linuxserver/docker-ngircd)
- [ngircd.conf Manual](https://ngircd.barton.de/doc/ngircd.conf.5.html)

## Support & Community

- NGircd GitHub: https://github.com/ngircd/ngircd
- IRC Help Channel: Join #ngircd on freenode (if available)
- Home Assistant Community: https://community.home-assistant.io
