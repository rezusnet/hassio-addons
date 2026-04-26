# Home Assistant add-on: Jellyfin

[![Version](https://img.shields.io/badge/dynamic/yaml?label=Version&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fjellyfin%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/jellyfin)
[![Arch](https://img.shields.io/badge/dynamic/yaml?color=success&label=Arch&query=%24.arch&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fjellyfin%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/jellyfin)
[![Builder](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/onpush_builder.yaml?label=Builder)](https://github.com/rezusnet/hassio-addons/actions/workflows/onpush_builder.yaml)
[![Lint](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/lint.yml?label=Lint)](https://github.com/rezusnet/hassio-addons/actions/workflows/lint.yml)

## About

[Jellyfin](https://jellyfin.org/) is the Free Software Media System. It lets you organize video, music, live TV, and photos from personal media libraries and stream them to smart TVs, streaming boxes, and mobile devices.

This add-on is based on the [linuxserver/docker-jellyfin](https://github.com/linuxserver/docker-jellyfin) Docker image with hardware acceleration support for **Intel (VAAPI)**, **AMD**, and **Raspberry Pi (V4L2, MMAL/OpenMAX)** GPUs.

**Key features:**

- Stream movies, TV shows, music, and photos to any device
- Hardware-accelerated transcoding (Intel Quick Sync, AMD, Raspberry Pi)
- Live TV and DVR support
- DLNA server
- Apps for Android, iOS, Roku, Fire TV, Android TV, and more
- HA ingress sidebar support
- SMB/CIFS network share mounting
- Local USB/SATA/NVMe disk mounting

## Installation

1. Add this repository to your Home Assistant instance:
   [![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https://github.com/rezusnet/hassio-addons)
2. Install the **Jellyfin** add-on from the add-on store.
3. Configure media paths and options (see Documentation tab).
4. Start the add-on.
5. Access via the **HA sidebar** (Ingress) or directly at `http://<your-ha-ip>:8096`.

For full configuration details, hardware acceleration setup, and troubleshooting, see the **Documentation** tab.
