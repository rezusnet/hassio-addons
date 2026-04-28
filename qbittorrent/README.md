# Home Assistant add-on: qBittorrent

[![Version](https://img.shields.io/badge/dynamic/yaml?label=Version&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fqbittorrent%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/qbittorrent)
[![Ingress](https://img.shields.io/badge/dynamic/yaml?color=blueviolet&label=Ingress&query=%24.ingress&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fqbittorrent%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/qbittorrent)
[![Arch](https://img.shields.io/badge/dynamic/yaml?color=success&label=Arch&query=%24.arch&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fqbittorrent%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/qbittorrent)
[![Builder](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/onpush_builder.yaml?label=Builder)](https://github.com/rezusnet/hassio-addons/actions/workflows/onpush_builder.yaml)
[![Lint](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/lint.yml?label=Lint)](https://github.com/rezusnet/hassio-addons/actions/workflows/lint.yml)

![qBittorrent banner](banner.svg)

## About

[qBittorrent](https://www.qbittorrent.org/) is a cross-platform BitTorrent client built with Qt and libtorrent. It provides a polished web UI, powerful search and RSS automation, and advanced torrent control without ads.

This add-on is based on the [linuxserver/docker-qbittorrent](https://github.com/linuxserver/docker-qbittorrent) Docker image.

**Key features:**

- Feature-rich web UI for torrent management
- Integrated search engine with category-specific searching
- RSS feed support with advanced download filters
- Magnet links, DHT, PEX, LSD, encrypted connections, and private torrent support
- Sequential downloading plus queueing and per-file prioritization
- Advanced control over torrents, trackers, and peers
- Bandwidth scheduler, IP filtering, IPv6, and UPnP/NAT-PMP support
- Torrent creation tools and remote control through the web UI
- HA ingress sidebar support
- SMB/CIFS network share mounting
- Local USB/SATA/NVMe disk mounting

## Installation

1. Add this repository to your Home Assistant instance:
   [![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https://github.com/rezusnet/hassio-addons)
2. Install the **qBittorrent** add-on from the add-on store.
3. Configure options (see Documentation tab).
4. Start the add-on.
5. Access via the **HA sidebar** (Ingress) or directly at `http://<your-ha-ip>:8080`.

For full configuration details, download path planning, and troubleshooting, see the **Documentation** tab.
