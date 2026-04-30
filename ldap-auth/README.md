# Home Assistant add-on: LDAP Auth

[![Version](https://img.shields.io/badge/dynamic/yaml?label=Version&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fldap-auth%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/ldap-auth)
[![Arch](https://img.shields.io/badge/dynamic/yaml?color=success&label=Arch&query=%24.arch&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fldap-auth%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/ldap-auth)
[![Builder](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/onpush_builder.yaml?label=Builder)](https://github.com/rezusnet/hassio-addons/actions/workflows/onpush_builder.yaml)
[![Lint](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/lint.yml?label=Lint)](https://github.com/rezusnet/hassio-addons/actions/workflows/lint.yml)

![LDAP Auth banner](banner.svg)

## About

[LDAP Auth](https://github.com/nginxinc/nginx-ldap-auth) is ldap authentication server for nginx reverse proxy. provides user authentication and cookie-based session management for ldap/active directory users..

This add-on is based on the [linuxserver/docker-ldap-auth](https://github.com/linuxserver/docker-ldap-auth) Docker image.

**Key features:**

- Containerized application
- Easy configuration
- Home Assistant integration
- Multi-architecture support

## Installation

1. Add this repository to your Home Assistant instance:
   [![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https://github.com/rezusnet/hassio-addons)
2. Install the **LDAP Auth** add-on from the add-on store.
3. Configure options as needed (see **Documentation** tab).
4. Start the add-on.
5. Access at `http://<your-ha-ip>:8888`.

For full configuration details and troubleshooting, see the **Documentation** tab.
