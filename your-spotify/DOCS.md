# Your-Spotify Add-on Documentation

## Getting Started

Your-Spotify is a self-hosted Spotify analytics platform. This add-on provides easy integration with Home Assistant.

### Initial Setup

1. **Obtain Spotify API Credentials**:
   - Go to [Spotify Developer Dashboard](https://developer.spotify.com/dashboard)
   - Log in or create a Spotify account
   - Create a new application
   - Accept terms and continue
   - Provide application name and accept the legal terms
   - You'll receive Client ID and Client Secret

2. **Configure the Add-on**:
   - Set `spotify_client_id` to your Client ID
   - Set `spotify_client_secret` to your Client Secret
   - Generate a secure `jwt_secret` (e.g., a random 32-character string)

3. **Start the Add-on**:
   - Click the Start button
   - Wait for the service to initialize (30-60 seconds)
   - Open the Web UI from the sidebar or visit `http://homeassistant-ip:3000`

## Configuration

### Configuration Table

| Option | Type | Required | Description |
|--------|------|----------|-------------|
| `data_location` | String | No | Where to store Your-Spotify data (default: `/share/your-spotify`) |
| `spotify_client_id` | String | No | Your Spotify API Client ID |
| `spotify_client_secret` | String | No | Your Spotify API Client Secret |
| `jwt_secret` | String | No | Secret key for JWT token generation |
| `mongo_db_uri` | String | No | MongoDB connection URI (optional for database backend) |
| `log_level` | Choice | No | Log verbosity: debug, info, warn, error (default: info) |

### Example Configuration

```yaml
data_location: /share/your-spotify
spotify_client_id: your_client_id_here
spotify_client_secret: your_client_secret_here
jwt_secret: your_random_jwt_secret_here
log_level: info
```

## Ports and Network

- **Port 3000/TCP**: Web interface for Your-Spotify
- Ingress enabled: Access via Home Assistant UI without port forwarding

## File Access

All Your-Spotify data is stored at `/share/your-spotify/`:
- User data
- Cache files
- Configuration

You can access these files via:
- File editor in Home Assistant
- SSH add-on
- SMB protocol (if configured)

## Troubleshooting

### Application won't start
- Check Spotify credentials are correct
- Verify JWT secret is set
- Review logs in Home Assistant

### Can't authenticate with Spotify
- Confirm Client ID and Client Secret are correct
- Verify the redirect URI matches your setup
- Check internet connectivity

### Slow performance
- Monitor logs for errors: `docker logs addon_your_spotify`
- Check available disk space at `/share/your-spotify/`
- Restart the add-on if needed

### Data not persisting
- Verify `data_location` is set correctly
- Ensure `/share/your-spotify/` has write permissions
- Check Docker volume mounts in advanced settings

## Ports

| Port | Protocol | Description |
|------|----------|-------------|
| 3000 | HTTP | Web UI for Your-Spotify |

## Advanced Configuration

### Using External MongoDB

If you want to use an external MongoDB database instead of the default storage:

1. Set `mongo_db_uri` to your MongoDB connection string
2. Example: `mongodb://user:password@mongodb-host:27017/your_spotify`
3. Restart the add-on

### Custom Data Location

To store data in a custom location:

1. Set `data_location` to your desired path (must be under `/share/`)
2. Example: `/share/my-custom-data/your-spotify`
3. Restart the add-on

## Upstream Documentation

For complete Your-Spotify documentation, visit:
- [Your-Spotify GitHub Project](https://github.com/Yooooomi/your_spotify)
- [LinuxServer.io Docker Image](https://github.com/linuxserver/docker-your_spotify)

## Support

If you encounter issues:
1. Check the troubleshooting section above
2. Review add-on logs in Home Assistant
3. Visit the [Your-Spotify GitHub Issues](https://github.com/Yooooomi/your_spotify/issues)
4. Check [LinuxServer.io Documentation](https://docs.linuxserver.io/images/docker-your_spotify/)
