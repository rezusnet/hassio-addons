# Home Assistant add-on: Bazarr

[![Version](https://img.shields.io/badge/dynamic/yaml?label=Version&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fbazarr%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/bazarr)
[![Arch](https://img.shields.io/badge/dynamic/yaml?color=success&label=Arch&query=%24.arch&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fbazarr%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/bazarr)
[![Builder](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/onpush_builder.yaml?label=Builder)](https://github.com/rezusnet/hassio-addons/actions/workflows/onpush_builder.yaml)
[![Lint](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/lint.yml?label=Lint)](https://github.com/rezusnet/hassio-addons/actions/workflows/lint.yml)

## About

[Bazarr](https://www.bazarr.media/) is a subtitle manager for Sonarr and Radarr. It automatically downloads and manages subtitles for your TV series and movies.

This add-on is based on the [linuxserver/docker-bazarr](https://github.com/linuxserver/docker-bazarr) Docker image.

**Key features:**

- Automatic subtitle downloading for TV series and movies
- Integration with Sonarr and Radarr
- Multiple subtitle provider support
- HA ingress sidebar support
- SMB/CIFS network share mounting

## Installation

1. Add this repository to your Home Assistant instance:
   [![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https://github.com/rezusnet/hassio-addons)
2. Install the **Bazarr** add-on from the add-on store.
3. Configure options (see Documentation tab).
4. Start the add-on.
5. Access via the **HA sidebar** (Ingress) or directly at `http://<your-ha-ip>:6767`.
