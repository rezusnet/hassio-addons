![Your-Spotify](banner.svg)

# Your-Spotify Add-on

Your-Spotify is a web application that allows you to download your entire Spotify library and visualize your music statistics with ease. This add-on wraps the official [LinuxServer.io](https://linuxserver.io) Docker image for Your-Spotify.

## Key Features

- 🎵 **Spotify Integration** - Authenticate with Spotify and analyze your music library
- 📊 **Playlist Analysis** - View detailed statistics about your playlists
- 🎧 **Streaming Stats** - Track your listening habits and favorite tracks
- 🔐 **Secure Authentication** - JWT-based authentication with Spotify OAuth
- 💾 **Data Persistence** - All data stored in Home Assistant config directory
- 🌐 **Web Interface** - Beautiful responsive UI for music exploration

## Installation

1. Add the repository to Home Assistant (if not already added)
2. Navigate to Settings → Add-ons → Add-on Store
3. Search for "Your-Spotify" and select it
4. Click "Install"
5. Configure your Spotify API credentials (see Configuration)
6. Click "Start"
7. Open the Web UI from the sidebar

## Configuration

Before starting the add-on, you'll need:

1. **Spotify API Credentials** - Obtain from [Spotify Developer Dashboard](https://developer.spotify.com/dashboard)
   - Create an application
   - Get your Client ID and Client Secret
   - Add the redirect URI: `http://homeassistant-ip:3000/callback`

2. Enter your credentials in the add-on configuration panel

3. Set a secure JWT Secret (random string for session management)

4. (Optional) Configure MongoDB URI if using external database

## Access

- **Web UI Port**: 3000
- Access via the "Your-Spotify" button in the Home Assistant sidebar (Ingress enabled)
- Or directly at: `http://homeassistant-ip:3000`

## Support

For issues, feature requests, or contributions, visit:
- [Your-Spotify GitHub](https://github.com/Yooooomi/your_spotify)
- [LinuxServer.io Your-Spotify](https://github.com/linuxserver/docker-your_spotify)

## License

This add-on is provided under the MIT License. Your-Spotify is licensed under its own terms.
