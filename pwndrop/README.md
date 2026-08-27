# Home Assistant add-on: Pwndrop

[![Version](https://img.shields.io/badge/dynamic/yaml?label=Version&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fpwndrop%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/pwndrop)
[![Ingress](https://img.shields.io/badge/dynamic/yaml?color=blueviolet&label=Ingress&query=%24.ingress&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fpwndrop%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/pwndrop)
[![Arch](https://img.shields.io/badge/dynamic/yaml?color=success&label=Arch&query=%24.arch&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fpwndrop%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/pwndrop)
[![Builder](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/onpush_builder.yaml?label=Builder)](https://github.com/rezusnet/hassio-addons/actions/workflows/onpush_builder.yaml)
[![Lint](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/lint.yml?label=Lint)](https://github.com/rezusnet/hassio-addons/actions/workflows/lint.yml)

![Pwndrop banner](banner.svg)

## About

[Pwndrop](https://github.com/kiwix/pwndrop) is a self-hosted file sharing service that allows you to easily share files with others via a simple link. It's designed with simplicity and security in mind.

This add-on is based on the [linuxserver/docker-pwndrop](https://github.com/linuxserver/docker-pwndrop) Docker image.

**Key features:**

- Self-hosted file sharing
- Simple link-based sharing
- Secure file uploads and downloads
- Lightweight and easy to deploy
- HA ingress sidebar support
- Configurable data location

## Installation

1. Add this repository to your Home Assistant instance:
   [![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https://github.com/rezusnet/hassio-addons)
2. Install the **Pwndrop** add-on from the add-on store.
3. Configure options if needed (see Documentation tab).
4. Start the add-on.
5. Access via the **HA sidebar** (Ingress) or directly at `http://<your-ha-ip>:8080`.

For full configuration details and troubleshooting, see the **Documentation** tab.
