# Home Assistant add-on: COPS

[![Version](https://img.shields.io/badge/dynamic/yaml?label=Version&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fcops%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/cops)
[![Ingress](https://img.shields.io/badge/dynamic/yaml?color=blueviolet&label=Ingress&query=%24.ingress&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fcops%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/cops)
[![Arch](https://img.shields.io/badge/dynamic/yaml?color=success&label=Arch&query=%24.arch&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fcops%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/cops)
[![Builder](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/onpush_builder.yaml?label=Builder)](https://github.com/rezusnet/hassio-addons/actions/workflows/onpush_builder.yaml)
[![Lint](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/lint.yml?label=Lint)](https://github.com/rezusnet/hassio-addons/actions/workflows/lint.yml)

![COPS banner](banner.svg)

## About

[COPS](https://github.com/mikespub-org/seblucas-cops) stands for Calibre OPDS (and HTML) Php Server. It links to your Calibre library database and allows downloading and emailing of books directly from a web browser and provides an OPDS feed to connect to your devices.

This add-on is based on the [linuxserver/docker-cops](https://github.com/linuxserver/docker-cops) Docker image.

**Key features:**

- Access your Calibre library via web browser
- OPDS feed support for e-readers and mobile devices
- Download and email books directly from the web interface
- Search functionality across your entire library
- Clean, responsive HTML interface
- Minimal dependencies and low resource usage
- HA ingress sidebar support
- SMB/CIFS network share mounting
- Local USB/SATA/NVMe disk mounting

## Installation

1. Add this repository to your Home Assistant instance:
   [![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https://github.com/rezusnet/hassio-addons)
2. Install the **COPS** add-on from the add-on store.
3. Configure your Calibre library path and options (see Documentation tab).
4. Start the add-on.
5. Access via the **HA sidebar** (Ingress) or directly at `http://<your-ha-ip>:80`.

For full configuration details and troubleshooting, see the **Documentation** tab.
