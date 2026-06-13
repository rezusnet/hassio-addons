# Home Assistant add-on: pyLoad-ng

[![Version](https://img.shields.io/badge/dynamic/yaml?label=Version&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fpyload-ng%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/pyload-ng)
[![Ingress](https://img.shields.io/badge/dynamic/yaml?color=blueviolet&label=Ingress&query=%24.ingress&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fpyload-ng%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/pyload-ng)
[![Arch](https://img.shields.io/badge/dynamic/yaml?color=success&label=Arch&query=%24.arch&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fpyload-ng%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/pyload-ng)
[![Builder](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/onpush_builder.yaml?label=Builder)](https://github.com/rezusnet/hassio-addons/actions/workflows/onpush_builder.yaml)
[![Lint](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/lint.yml?label=Lint)](https://github.com/rezusnet/hassio-addons/actions/workflows/lint.yml)

![pyLoad-ng banner](banner.svg)

## About

[pyLoad-ng](https://pyload.net/) is a Free and Open Source download manager written in Python and designed to be extremely lightweight, easily extensible and fully manageable via web.

This add-on is based on the [linuxserver/docker-pyload-ng](https://github.com/linuxserver/docker-pyload-ng) Docker image.

**Key features:**

- Lightweight download manager with minimal resource footprint
- Web-based control interface
- Multi-threaded downloads
- Support for multiple download services and file types
- Plugin system for extensibility
- Cross-platform compatibility (x86-64 and ARM64)
- HA ingress sidebar support
- SMB/CIFS network share mounting
- Local USB/SATA/NVMe disk mounting

## Installation

1. Add this repository to your Home Assistant instance:
   [![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https://github.com/rezusnet/hassio-addons)
2. Install the **pyLoad-ng** add-on from the add-on store.
3. Configure storage paths and options (see Documentation tab).
4. Start the add-on.
5. Access via the **HA sidebar** (Ingress) or directly at `http://<your-ha-ip>:8000`.
6. Default credentials: username **pyload**, password **pyload**.

For full configuration details and troubleshooting, see the **Documentation** tab.
