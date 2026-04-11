# Home Assistant add-on: Filebrowser

[![Version](https://img.shields.io/badge/dynamic/yaml?label=Version&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Ffilebrowser%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/filebrowser)
[![Ingress](https://img.shields.io/badge/dynamic/yaml?color=blueviolet&label=Ingress&query=%24.ingress&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Ffilebrowser%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/filebrowser)
[![Arch](https://img.shields.io/badge/dynamic/yaml?color=success&label=Arch&query=%24.arch&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Ffilebrowser%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/filebrowser)
[![Builder](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/onpush_builder.yaml?label=Builder)](https://github.com/rezusnet/hassio-addons/actions/workflows/onpush_builder.yaml)
[![Lint](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/lint.yml?label=Lint)](https://github.com/rezusnet/hassio-addons/actions/workflows/lint.yml)

## About

[Filebrowser](https://github.com/filebrowser/filebrowser) is a web-based file manager that provides a clean interface for managing files within a specified directory. Upload, download, delete, preview, rename, and edit your files directly from your browser.

This add-on runs Filebrowser as a Home Assistant ingress add-on, giving you full file management access to your Home Assistant filesystem from the sidebar.

**Key features:**

- Web-based file management via Home Assistant ingress
- Upload, download, delete, rename, and edit files
- File preview for images, videos, audio, and documents
- Optional HTTPS with your own SSL certificates
- Support for mounting local disks and network shares (SMB/CIFS)
- User management with optional authentication

## Installation

1. Add this repository to your Home Assistant instance:
   [![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https://github.com/rezusnet/hassio-addons)
2. Install the "Filebrowser" add-on from the add-on store.
3. Configure the add-on options (see below).
4. Start the add-on.
5. Click "Open Web UI" to access Filebrowser from your sidebar.

## Configuration

### Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `NoAuth` | bool | `true` | Disable authentication. Set to `false` to require login. |
| `ssl` | bool | `false` | Enable HTTPS using your Home Assistant SSL certificates. |
| `certfile` | string | `fullchain.pem` | Path to the SSL certificate file (relative to `/ssl/`). |
| `keyfile` | string | `privkey.pem` | Path to the SSL private key file (relative to `/ssl/`). |
| `disable_thumbnails` | bool | `true` | Disable thumbnail generation for faster loading. |
| `localdisks` | string | _(empty)_ | Comma-separated list of local disk devices to mount (e.g., `sda1,sdb1`). |
| `networkdisks` | string | _(empty)_ | SMB/CIFS network share URL (e.g., `//server/share`). |
| `cifsusername` | string | _(empty)_ | Username for SMB/CIFS authentication. |
| `cifspassword` | string | _(empty)_ | Password for SMB/CIFS authentication. |
| `cifsdomain` | string | _(empty)_ | Domain for SMB/CIFS authentication. |
| `base_folder` | string | _(empty)_ | Custom base folder path for Filebrowser to serve. |
| `env_vars` | list | `[]` | Custom environment variables. |

### Example configuration

```yaml
NoAuth: true
ssl: false
certfile: fullchain.pem
keyfile: privkey.pem
disable_thumbnails: true
localdisks: ""
networkdisks: "//nas.local/media"
cifsusername: myuser
cifspassword: mypassword
cifsdomain: ""
base_folder: ""
env_vars: []
```

### Accessing files

The add-on maps the following Home Assistant directories with read/write access:

- `/homeassistant` — Home Assistant configuration
- `/addon_configs` — All add-on configurations
- `/addons` — Add-on data
- `/media` — Media files
- `/share` — Shared files
- `/backup` — Backups
- `/ssl` — SSL certificates

### Mounting local disks

To mount local disks (e.g., a USB drive), set `localdisks` to a comma-separated list of device names:

```yaml
localdisks: "sda1,sdb1"
```

These will be mounted under `/mnt/` in the add-on container.

### Mounting network shares

To mount an SMB/CIFS network share:

```yaml
networkdisks: "//nas.local/media"
cifsusername: myuser
cifspassword: mypassword
cifsdomain: ""  # optional, for Active Directory
```

Network shares are mounted under `/mnt/networkshare/`.

### Enabling HTTPS

To serve Filebrowser over HTTPS using your existing Home Assistant SSL certificates:

```yaml
ssl: true
certfile: fullchain.pem
keyfile: privkey.pem
```

The certificate files are read from the `/ssl/` directory.
