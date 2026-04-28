# Home Assistant add-on: Fail2ban

[![Version](https://img.shields.io/badge/dynamic/yaml?label=Version&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Ffail2ban%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/fail2ban)
[![Arch](https://img.shields.io/badge/dynamic/yaml?color=success&label=Arch&query=%24.arch&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Ffail2ban%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/fail2ban)
[![Builder](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/onpush_builder.yaml?label=Builder)](https://github.com/rezusnet/hassio-addons/actions/workflows/onpush_builder.yaml)
[![Lint](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/lint.yml?label=Lint)](https://github.com/rezusnet/hassio-addons/actions/workflows/lint.yml)

![Fail2ban banner](banner.svg)

## About

[Fail2ban](https://www.fail2ban.org/) is a log-monitoring intrusion prevention daemon. It watches log files for repeated authentication failures and automatically bans offending IP addresses using firewall rules.

This add-on is based on the [linuxserver/docker-fail2ban](https://github.com/linuxserver/docker-fail2ban) Docker image.

**Key features:**

- Automatically bans IPs that trigger repeated authentication failures
- Host-level protection using `NET_ADMIN` and `NET_RAW` capabilities
- Preconfigured jail set for many common self-hosted services
- Read-only remote log mounts for Home Assistant and other applications
- Host network mode so bans apply to real inbound traffic
- Add-on-managed custom log path mappings through Home Assistant config

## Installation

1. Add this repository to your Home Assistant instance:
   [![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https://github.com/rezusnet/hassio-addons)
2. Install the **Fail2ban** add-on from the add-on store.
3. Configure `log_paths` and any desired verbosity settings.
4. Start the add-on.

> **Note:** This add-on has no web UI and no ingress panel. You manage it through configuration files and add-on logs.

For full configuration details, jail setup, and troubleshooting, see the **Documentation** tab.
