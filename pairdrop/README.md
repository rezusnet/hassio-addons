# Home Assistant add-on: PairDrop

[![Version](https://img.shields.io/badge/dynamic/yaml?label=Version&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fpairdrop%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/pairdrop)
[![Ingress](https://img.shields.io/badge/dynamic/yaml?color=blueviolet&label=Ingress&query=%24.ingress&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fpairdrop%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/pairdrop)
[![Arch](https://img.shields.io/badge/dynamic/yaml?color=success&label=Arch&query=%24.arch&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fpairdrop%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/pairdrop)
[![Builder](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/onpush_builder.yaml?label=Builder)](https://github.com/rezusnet/hassio-addons/actions/workflows/onpush_builder.yaml)
[![Lint](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/lint.yml?label=Lint)](https://github.com/rezusnet/hassio-addons/actions/workflows/lint.yml)

![PairDrop banner](banner.svg)

## About

[PairDrop](https://github.com/schlagmichdoch/PairDrop) is a cross-platform local file sharing solution that works entirely in your browser. Inspired by Apple's AirDrop, it enables instant peer-to-peer file transfers between devices on the same network.

This add-on is based on the [linuxserver/docker-pairdrop](https://github.com/linuxserver/docker-pairdrop) Docker image.

**Key features:**

- Send files, images, and text between devices via WebRTC peer-to-peer
- No cloud upload required — transfers happen directly between devices
- Works on any platform with a modern browser (mobile and desktop)
- Internet transfers via temporary public rooms or persistent device pairing
- WebSocket fallback for clients behind VPNs or restrictive firewalls
- No signup or configuration needed for basic usage
- HA ingress sidebar support
- SMB/CIFS network share mounting
- Local USB/SATA/NVMe disk mounting

## Installation

1. Add this repository to your Home Assistant instance:

   [![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https://github.com/rezusnet/hassio-addons)

2. Install the **PairDrop** add-on from the add-on store.
3. Start the add-on.
4. Access via the **HA sidebar** (Ingress) or directly at `http://<your-ha-ip>:3000`.

For full configuration details and troubleshooting, see the **Documentation** tab.
