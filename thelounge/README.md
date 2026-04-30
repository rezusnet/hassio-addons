# TheLounge Add-on

[![Release][release-badge]][release-link] ![License][license-badge]

[release-badge]: https://img.shields.io/badge/version-1.0.0-blue.svg
[release-link]: https://github.com/rezusnet/hassio-addons/releases
[license-badge]: https://img.shields.io/badge/license-MIT-green.svg

![TheLounge Banner](banner.svg)

## About

TheLounge is a self-hosted web IRC client that provides a modern web-based interface for connecting to IRC networks. It features persistent connections, message history, and theme support, making it perfect for managing IRC conversations from any browser.

## Key Features

- **Web-based IRC Client**: Access IRC from any browser without installing additional software
- **Persistent Connections**: Stay connected to IRC networks even when the browser tab is closed
- **Message History**: Full chat history available in your browser
- **Theme Support**: Multiple themes to customize your experience
- **User Management**: Create multiple user accounts with individual settings
- **Auto-completion**: Channel and user completion for faster chat
- **Mobile-Friendly**: Works seamlessly on desktop and mobile devices
- **Network Management**: Easy setup and switching between multiple IRC networks

## Installation

The installation follows the standard Home Assistant add-on installation process:

1. Add this repository to Home Assistant
2. Install the TheLounge add-on
3. Configure your IRC networks in the add-on settings or via the web interface
4. Start the add-on and access it through the Ingress link

## Configuration

TheLounge can be configured through:
- Home Assistant add-on settings (PUID, PGID, timezone, data location)
- Web interface at `http://localhost:9000` after starting the add-on
- Manual configuration files in `/share/thelounge`

## Access

Once running, access TheLounge through:
- **Home Assistant Ingress**: Via the Home Assistant UI (recommended)
- **Direct**: `http://<your-host>:9000`

## More Information

- [TheLounge Official Website](https://thelounge.chat/)
- [TheLounge Documentation](https://docs.thelounge.chat/)
- [LinuxServer.io TheLounge Container](https://docs.linuxserver.io/images/docker-thelounge/)

## Support

For issues related to this add-on, please open an issue on the [GitHub repository](https://github.com/rezusnet/hassio-addons/issues).

## License

This add-on is released under the MIT License.
