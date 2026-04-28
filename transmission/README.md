# Home Assistant add-on: Transmission

[![Version](https://img.shields.io/badge/dynamic/yaml?label=Version&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Ftransmission%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/transmission)
[![Ingress](https://img.shields.io/badge/dynamic/yaml?color=blueviolet&label=Ingress&query=%24.ingress&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Ftransmission%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/transmission)
[![Arch](https://img.shields.io/badge/dynamic/yaml?color=success&label=Arch&query=%24.arch&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Ftransmission%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/transmission)
[![Builder](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/onpush_builder.yaml?label=Builder)](https://github.com/rezusnet/hassio-addons/actions/workflows/onpush_builder.yaml)
[![Lint](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/lint.yml?label=Lint)](https://github.com/rezusnet/hassio-addons/actions/workflows/lint.yml)

![Transmission banner](banner.svg)

## About

[Transmission](https://transmissionbt.com/) is a fast, easy, and free BitTorrent client. It focuses on a lightweight footprint while still offering the core torrent features expected on NAS boxes, media servers, and Raspberry Pi systems.

This add-on is based on the [linuxserver/docker-transmission](https://github.com/linuxserver/docker-transmission) Docker image.

**Key features:**

- Simple and lightweight web UI
- Watch directory for automatic torrent addition
- Magnet links, DHT, PEX, uTP, UPnP/NAT-PMP, and webseed support
- Encryption, tracker editing, and global/per-torrent speed limits
- Blocklist and whitelist support for tighter control
- Low resource usage, ideal for Raspberry Pi and home servers
- Privacy-focused, open-source BitTorrent client with no ads or tracking
- HA ingress sidebar support
- SMB/CIFS network share mounting
- Local USB/SATA/NVMe disk mounting

## Installation

1. Add this repository to your Home Assistant instance:
   [![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https://github.com/rezusnet/hassio-addons)
2. Install the **Transmission** add-on from the add-on store.
3. Configure options (see Documentation tab).
4. Start the add-on.
5. Access via the **HA sidebar** (Ingress) or directly at `http://<your-ha-ip>:9091`.

For full configuration details, download path planning, and troubleshooting, see the **Documentation** tab.
