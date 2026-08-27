# Home Assistant add-on: Code Server

[![Version](https://img.shields.io/badge/dynamic/yaml?label=Version&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fcode-server%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/code-server)
[![Ingress](https://img.shields.io/badge/dynamic/yaml?color=blueviolet&label=Ingress&query=%24.ingress&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fcode-server%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/code-server)
[![Arch](https://img.shields.io/badge/dynamic/yaml?color=success&label=Arch&query=%24.arch&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fcode-server%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/code-server)
[![Builder](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/onpush_builder.yaml?label=Builder)](https://github.com/rezusnet/hassio-addons/actions/workflows/onpush_builder.yaml)
[![Lint](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/lint.yml?label=Lint)](https://github.com/rezusnet/hassio-addons/actions/workflows/lint.yml)

![Code Server banner](banner.svg)

## About

[Code Server](https://coder.com) is VS Code running on a remote server, accessible through the browser.

This add-on is based on the [linuxserver/docker-code-server](https://github.com/linuxserver/docker-code-server) Docker image.

**Key features:**

- Code on your Chromebook, tablet, and laptop with a consistent dev environment
- Develop for Linux from Windows or Mac workstations
- Use cloud servers to speed up tests, compilations, and downloads
- Preserve battery life when on the go
- All intensive computation runs on your server
- Web-based IDE with the full power of VS Code
- Extensions support from the VS Code marketplace
- HA ingress sidebar support
- Optional password authentication
- SUDO support

## Installation

1. Add this repository to your Home Assistant instance:
   [![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https://github.com/rezusnet/hassio-addons)
2. Install the **Code Server** add-on from the add-on store.
3. Configure options (see Documentation tab).
4. Start the add-on.
5. Access via the **HA sidebar** (Ingress) or directly at `https://<your-ha-ip>:8443`.

For full configuration details and troubleshooting, see the **Documentation** tab.
