# Home Assistant add-on: PhpMyAdmin

[![Version](https://img.shields.io/badge/dynamic/yaml?label=Version&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fphpmyadmin%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/phpmyadmin)
[![Arch](https://img.shields.io/badge/dynamic/yaml?color=success&label=Arch&query=%24.arch&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fphpmyadmin%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/phpmyadmin)
[![Builder](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/onpush_builder.yaml?label=Builder)](https://github.com/rezusnet/hassio-addons/actions/workflows/onpush_builder.yaml)
[![Lint](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/lint.yml?label=Lint)](https://github.com/rezusnet/hassio-addons/actions/workflows/lint.yml)
[![Ingress](https://img.shields.io/badge/dynamic/yaml?color=blueviolet&label=Ingress&query=%24.ingress&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fphpmyadmin%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/phpmyadmin)

![PhpMyAdmin banner](banner.svg)

## About

[PhpMyAdmin](https://github.com/linuxserver/docker-phpmyadmin) is a free and open source administration tool for MySQL and MariaDB. As a portable web application written primarily in PHP, it has become one of the most popular MySQL administration tools, especially for hosting providers and users of all skill levels.

This add-on is based on the [linuxserver/docker-phpmyadmin](https://github.com/linuxserver/docker-phpmyadmin) Docker image.

**Key features:**

- Web-based MySQL/MariaDB database management
- User-friendly interface for database operations
- Support for multiple MySQL/MariaDB servers
- Import and export database functionality
- Multi-language support
- User privilege management

## Installation

1. Add this repository to your Home Assistant instance:
   [![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https://github.com/rezusnet/hassio-addons)
2. Install the **PhpMyAdmin** add-on from the add-on store.
3. Configure options as needed (see **Documentation** tab).
4. Start the add-on.
5. Access via the **HA sidebar** (Ingress) or directly at `http://<your-ha-ip>:80`.

For full configuration details and troubleshooting, see the **Documentation** tab.
