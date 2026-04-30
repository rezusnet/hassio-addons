# Syslog-ng Add-on

[![Latest Release](https://img.shields.io/github/v/release/rezusnet/hassio-addons?label=Latest%20Release)](https://github.com/rezusnet/hassio-addons/releases)
[![Project Stage](https://img.shields.io/badge/project%20stage-production%20ready-brightgreen.svg)](https://github.com/rezusnet/hassio-addons#readme)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE.md)
[![Open your Home Assistant instance and show the add-on store page of the add-on.](https://my.home-assistant.io/badges/supervisor_addon.svg)](https://my.home-assistant.io/redirect/supervisor_addon/?addon=syslog-ng)

![Syslog-ng Banner](banner.svg)

## About

syslog-ng is an advanced logging daemon. It can collect and normalize logs from multiple sources into a single, centralized log file. With syslog-ng, you can filter, format, and forward logs from all your devices and applications efficiently.

## Key Features

- 📊 **Log Collection**: Collect logs from multiple sources
- 🔄 **Log Routing**: Route logs to different destinations
- 🎯 **Advanced Filtering**: Filter logs based on complex rules
- 🔗 **Log Forwarding**: Forward logs to remote servers
- 🔒 **Encrypted Transport**: Support for TLS/SSL connections
- 🎨 **Log Normalization**: Parse and normalize various log formats
- 📈 **High Performance**: Handle millions of messages per second

## Installation

1. Add the add-on repository (if not already added)
2. Install the Syslog-ng add-on from the add-on store
3. Configure the add-on (see DOCS.md for details)
4. Start the add-on
5. Configure devices to send logs to the add-on

## Quick Access

- **UDP**: `syslog://<your-host>:514`
- **TCP**: `syslog-tcp://<your-host>:514`
- **TLS**: `syslog-tls://<your-host>:601`
- **Configuration**: Edit `/share/syslog-ng/config/syslog-ng.conf`

## Support & Documentation

For detailed configuration options and troubleshooting, see [DOCS.md](DOCS.md).

For upstream documentation and source code, visit:
- **Website**: https://www.syslog-ng.com/
- **Documentation**: https://www.syslog-ng.com/technical-documents/list/syslog-ng-open-source-edition
- **GitHub**: https://github.com/syslog-ng/syslog-ng
- **Configuration Guide**: https://www.syslog-ng.com/technical-documents/doc/syslog-ng-open-source-edition/3.35/administration-guide/
