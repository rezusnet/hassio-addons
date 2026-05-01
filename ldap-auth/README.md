# Home Assistant add-on: LDAP Auth

[![Version](https://img.shields.io/badge/dynamic/yaml?label=Version&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fldap-auth%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/ldap-auth)
[![Arch](https://img.shields.io/badge/dynamic/yaml?color=success&label=Arch&query=%24.arch&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fldap-auth%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/ldap-auth)
[![Builder](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/onpush_builder.yaml?label=Builder)](https://github.com/rezusnet/hassio-addons/actions/workflows/onpush_builder.yaml)
[![Lint](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/lint.yml?label=Lint)](https://github.com/rezusnet/hassio-addons/actions/workflows/lint.yml)

## About

[LDAP Auth](https://github.com/nginxinc/nginx-ldap-auth) is an authentication daemon for nginx that provides user authentication against LDAP/Active Directory servers. It handles cookie-based session management and integrates seamlessly with nginx reverse proxy configurations.

This add-on is based on the [linuxserver/docker-ldap-auth](https://github.com/linuxserver/docker-ldap-auth) Docker image.

**Key features:**

- LDAP and Active Directory authentication
- Cookie-based session management with Fernet encryption
- Nginx reverse proxy integration
- Custom fernet keys for multi-instance deployments
- Optional SSL/TLS support for the auth daemon
- User and group-based access control
- Supports OpenLDAP, Microsoft Active Directory, and compatible servers

## Installation

1. Add this repository to your Home Assistant instance:
   [![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https://github.com/rezusnet/hassio-addons)
2. Install the **LDAP Auth** add-on from the add-on store.
3. Configure your LDAP server connection settings (see Documentation tab).
4. Set up nginx location blocks with LDAP authentication.
5. Start the add-on.
6. Access the login page at `http://<your-ha-ip>:9000`.

For full configuration details, LDAP server setup, and troubleshooting, see the **Documentation** tab.
