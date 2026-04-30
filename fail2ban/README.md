# Home Assistant add-on: Fail2ban

[![Version](https://img.shields.io/badge/dynamic/yaml?label=Version&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Ffail2ban%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/fail2ban)
[![Arch](https://img.shields.io/badge/dynamic/yaml?color=success&label=Arch&query=%24.arch&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Ffail2ban%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/fail2ban)
[![Builder](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/onpush_builder.yaml?label=Builder)](https://github.com/rezusnet/hassio-addons/actions/workflows/onpush_builder.yaml)
[![Lint](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/lint.yml?label=Lint)](https://github.com/rezusnet/hassio-addons/actions/workflows/lint.yml)

![Fail2ban banner](banner.svg)

## About

[Fail2ban](https://www.fail2ban.org/) is intrusion prevention software that protects your server from brute-force attacks.

This add-on is based on the [linuxserver/docker-fail2ban](https://github.com/linuxserver/docker-fail2ban) Docker image.

**Key features:**

- Automated IP blocking
- Log file monitoring
- Configurable ban duration
- Multiple backend support
- Rate limiting
## Installation

1. Add this repository to your Home Assistant instance:
   [![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https://github.com/rezusnet/hassio-addons)
2. Install the **Fail2ban** add-on from the add-on store.
3. Configure options as needed (see **Documentation** tab).
4. Start the add-on.


For full configuration details and troubleshooting, see the **Documentation** tab.
