# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.5.0] - 2026-04-27

### Added

- Initial release of pyLoad-ng Home Assistant add-on
- Web-based download manager interface
- Support for amd64 and aarch64 architectures
- Configurable data location
- Click'n'Load protocol support
- Timezone configuration support
- Integration with Home Assistant ingress

### Features

- Lightweight Python download manager
- Extensible plugin system
- Queue-based download management
- Web interface accessible from Home Assistant
- Multi-user support
- Persistent configuration storage

### Configuration

- Default data location: `/share/pyload-ng`
- Primary web interface port: 8000
- Click'n'Load port: 9666
- Default credentials: pyload/pyload (must be changed on first login)

### Documentation

- Complete setup guide in DOCS.md
- Product overview in README.md
- Support and troubleshooting information
