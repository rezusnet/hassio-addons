# pyLoad-ng Home Assistant Add-on

![pyload-ng Badge](https://img.shields.io/badge/version-0.5.0-blue)
![Status](https://img.shields.io/badge/status-active-success)

## About

[pyLoad](https://pyload.net/) is a free and open-source download manager written in Python. Designed to be extremely lightweight, easily extensible, and fully manageable via a web interface.

This add-on provides a containerized version of [LinuxServer.io's pyLoad-ng Docker image](https://github.com/linuxserver/docker-pyload-ng), integrating it seamlessly into Home Assistant.

## Features

- **Web-based Interface** - Manage downloads from anywhere via the built-in web UI
- **Lightweight** - Minimal resource footprint, perfect for resource-constrained systems
- **Plugin System** - Extensible with various download site plugins
- **Queue Management** - Organize and prioritize your downloads
- **Multi-Architecture Support** - Runs on both amd64 and aarch64 systems
- **Configurable** - Customize data location and timezone settings

## Installation

1. Add this repository to Home Assistant
2. Install the pyLoad-ng add-on
3. Configure data location and other options
4. Start the add-on
5. Open the web interface (default: `http://homeassistant.local:8000`)

## Default Credentials

- **Username:** `pyload`
- **Password:** `pyload`

> **Important:** Change the default password immediately after first login!

## Documentation

See [DOCS.md](DOCS.md) for detailed configuration options, port information, and troubleshooting guides.

## Support

For issues or questions:
- Check the [DOCS.md](DOCS.md) troubleshooting section
- Visit [pyLoad Official Documentation](https://github.com/pyload/pyload/wiki)
- Report issues on [GitHub Issues](https://github.com/rezusnet/hassio-addons/issues)

## License

MIT
