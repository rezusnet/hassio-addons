# Hishtory Server Add-on

[![Latest Release](https://img.shields.io/github/v/release/rezusnet/hassio-addons?label=Latest%20Release)](https://github.com/rezusnet/hassio-addons/releases)
[![Project Stage](https://img.shields.io/badge/project%20stage-production%20ready-brightgreen.svg)](https://github.com/rezusnet/hassio-addons#readme)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE.md)
[![Open your Home Assistant instance and show the add-on store page of the add-on.](https://my.home-assistant.io/badges/supervisor_addon.svg)](https://my.home-assistant.io/redirect/supervisor_addon/?addon=hisshtory-server)

![Hishtory Banner](banner.svg)

## About

Hishtory is a private AI-powered shell history manager. It allows you to sync your shell history across machines, search through your command history efficiently, and receive AI suggestions. Unlike cloud-based alternatives, Hishtory runs completely locally on your own server, keeping your command history private.

## Key Features

- 🔐 **Private History**: Keep your shell history completely private
- 🔄 **Cross-Device Sync**: Sync history across multiple machines
- 🔍 **Advanced Search**: Powerful search through command history
- 🤖 **AI Suggestions**: Get intelligent command suggestions
- 📱 **Client Support**: Works with bash, zsh, and fish shells
- 💾 **Self-Hosted**: Run on your own server
- ⚡ **Lightweight**: Minimal resource usage

## Installation

1. Add the add-on repository (if not already added)
2. Install the Hishtory Server add-on from the add-on store
3. Configure database settings (see DOCS.md for details)
4. Start the add-on
5. Configure your shell clients to sync history

## Prerequisites

- PostgreSQL database (can be internal or external)
- Network connectivity between client and server

## Quick Access

- **Server API**: `http://<your-host>:8000`
- **Client Setup**: Install hishtory client on your machines

## Client Configuration

After starting the server, configure your shell clients:

```bash
# Install hishtory client
curl https://hishtory.dev/install.py | python3 -

# Configure to use your private server
hishtory config-server http://<your-host>:8000
```

## Support & Documentation

For detailed configuration and client setup, see [DOCS.md](DOCS.md).

For upstream documentation and source code, visit:
- **GitHub**: https://github.com/ddpom/hishtory
- **Website**: https://hishtory.dev/
- **Documentation**: https://github.com/ddpom/hishtory/blob/master/README.md
