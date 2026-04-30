# Home Assistant add-on: Ubooquity

[![Version](https://img.shields.io/badge/dynamic/yaml?label=Version&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fubooquity%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/ubooquity)
[![Ingress](https://img.shields.io/badge/dynamic/yaml?color=blueviolet&label=Ingress&query=%24.ingress&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fubooquity%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/ubooquity)
[![Arch](https://img.shields.io/badge/dynamic/yaml?color=success&label=Arch&query=%24.arch&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fubooquity%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/ubooquity)
[![Builder](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/onpush_builder.yaml?label=Builder)](https://github.com/rezusnet/hassio-addons/actions/workflows/onpush_builder.yaml)
[![Lint](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/lint.yml?label=Lint)](https://github.com/rezusnet/hassio-addons/actions/workflows/lint.yml)

![Ubooquity banner](banner.svg)

## About

[Ubooquity](https://vaemendis.net/ubooquity/) is a free, lightweight and easy-to-use home server for your comics and ebooks. Use it to access your files from anywhere, with a tablet, an e-reader, a phone or a computer.

This add-on is based on the [linuxserver/docker-ubooquity](https://github.com/linuxserver/docker-ubooquity) Docker image.

**Key features:**

- Lightweight library server for comics and ebooks
- Web-based interface accessible from any device
- Admin interface for managing collections and settings
- Automatic library scanning on startup
- Configurable Java memory limits (MAXMEM)
- HA ingress sidebar support
- SMB/CIFS network share mounting
- Local USB/SATA/NVMe disk mounting

## Installation

1. Add this repository to your Home Assistant instance:
   [![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https://github.com/rezusnet/hassio-addons)
2. Install the **Ubooquity** add-on from the add-on store.
3. Configure library paths and options (see Documentation tab).
4. Start the add-on.
5. Access via the **HA sidebar** (Ingress) or directly at `http://<your-ha-ip>:2202`.

For full configuration details, library setup, and troubleshooting, see the **Documentation** tab.
