# Oscam Add-on

[![Latest Release](https://img.shields.io/github/v/release/rezusnet/hassio-addons?label=Latest%20Release)](https://github.com/rezusnet/hassio-addons/releases)
[![Project Stage](https://img.shields.io/badge/project%20stage-production%20ready-brightgreen.svg)](https://github.com/rezusnet/hassio-addons#readme)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE.md)
[![Open your Home Assistant instance and show the add-on store page of the add-on.](https://my.home-assistant.io/badges/supervisor_addon.svg)](https://my.home-assistant.io/redirect/supervisor_addon/?addon=oscam)

![Oscam Banner](banner.svg)

## About

Oscam is an open source CAM (Conditional Access Module) emulator. It emulates DVB scrambling systems for satellite and cable TV. Oscam can be used with various card readers and protocols to provide conditional access services for IPTV and digital TV applications.

## Key Features

- 🛰️ **DVB Emulation**: Emulate satellite and cable TV systems
- 🔐 **Conditional Access**: Full CAM (Conditional Access Module) support
- 📺 **IPTV Support**: Works with IPTV streaming applications
- 🔌 **Multiple Protocols**: Support for various card reader protocols
- 🎯 **Card Reader Support**: Compatible with multiple smart card readers
- ⚙️ **Flexible Configuration**: Highly customizable for different use cases
- 🚀 **Lightweight**: Minimal resource usage

## Installation

1. Add the add-on repository (if not already added)
2. Install the Oscam add-on from the add-on store
3. Configure the add-on (see DOCS.md for details)
4. Start the add-on
5. Configure your IPTV or digital TV application to use Oscam

## Prerequisites

- Compatible smart card reader (for real card access) - optional
- IPTV application or compatible client
- Network connectivity

## Quick Access

- **Server Port**: `9000` (DVBAPI/CAM default)
- **Configuration**: Edit files in `/share/oscam/config/`

## Configuration Files

Oscam configuration is stored in `/share/oscam/config/`:

- **oscam.conf**: Main configuration file
- **oscam.server**: Server configuration
- **oscam.user**: User definitions
- **oscam.srvid**: Service IDs

## Support & Documentation

For detailed configuration and troubleshooting, see [DOCS.md](DOCS.md).

For upstream documentation and source code, visit:
- **GitHub**: https://github.com/E2OpenPlugins/e2openplugin-OpenCam
- **Oscam Project**: http://www.streamboard.goys.de/oscam/
- **Documentation**: https://github.com/E2OpenPlugins/e2openplugin-OpenCam/wiki
