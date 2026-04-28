## Getting Started

After installing and starting the add-on:

1. Open Filebrowser via the **HA sidebar** (Ingress) or at `http://<your-ha-ip>:8071`.
2. If `NoAuth` is `true`, the UI opens without a login prompt.
3. If `NoAuth` is `false`, sign in through the Filebrowser login page.
4. Browse Home Assistant files, media, backups, and mounted storage from the web UI.

## Configuration

### Options

| Option               | Type | Default         | Description                                  |
| -------------------- | ---- | --------------- | -------------------------------------------- |
| `NoAuth`             | bool | `true`          | Disable Filebrowser authentication           |
| `TZ`                 | str  | `""`            | Timezone                                     |
| `base_folder`        | str  | `""`            | Restrict Filebrowser to a specific root path |
| `ssl`                | bool | `false`         | Enable HTTPS for direct-port access          |
| `certfile`           | str  | `fullchain.pem` | Certificate file under `/ssl/`               |
| `keyfile`            | str  | `privkey.pem`   | Key file under `/ssl/`                       |
| `disable_thumbnails` | bool | `true`          | Disable thumbnail generation                 |
| `localdisks`         | str  | `""`            | Comma-separated local disks to mount         |
| `networkdisks`       | str  | `""`            | Comma-separated SMB shares to mount          |
| `cifsusername`       | str  | `""`            | SMB username                                 |
| `cifspassword`       | str  | `""`            | SMB password                                 |
| `cifsdomain`         | str  | `""`            | SMB domain                                   |
| `env_vars`           | list | `[]`            | Custom environment variables                 |

### Example Configuration

```yaml
NoAuth: true
TZ: Europe/Berlin
base_folder: /media
ssl: false
certfile: fullchain.pem
keyfile: privkey.pem
disable_thumbnails: true
localdisks: ""
networkdisks: "//nas.local/media"
cifsusername: myuser
cifspassword: mypassword
cifsdomain: ""
env_vars: []
```

## File Access

The add-on maps the following Home Assistant paths with read/write access:

| Path             | Purpose                      |
| ---------------- | ---------------------------- |
| `/homeassistant` | Home Assistant configuration |
| `/addon_configs` | Add-on configuration data    |
| `/addons`        | Add-on source and data       |
| `/media`         | Media files                  |
| `/share`         | Shared files                 |
| `/backup`        | Backups                      |
| `/ssl`           | SSL certificates             |

If `base_folder` is set, Filebrowser serves only that directory subtree.

## Mounting Local Disks

To mount local storage devices, set `localdisks` to a comma-separated list:

```yaml
localdisks: "sda1,sdb1"
```

Mounted disks appear under `/mnt/`.

## Mounting Network Shares

To mount an SMB/CIFS share:

```yaml
networkdisks: "//nas.local/media"
cifsusername: myuser
cifspassword: mypassword
cifsdomain: ""
```

Mounted shares also appear under `/mnt/`.

## Authentication and HTTPS

- Set `NoAuth: false` to require Filebrowser authentication
- Set `ssl: true` to enable HTTPS on the direct port
- `certfile` and `keyfile` are read from `/ssl/`

Ingress access continues to work through Home Assistant regardless of the direct-port SSL setting.

## Troubleshooting

### Add-on won't start

- Check the add-on log for SSL certificate or path errors
- Verify `base_folder` exists and is readable
- Confirm mounted shares and disks were attached successfully

### Files or folders are missing

- Check whether `base_folder` is restricting the view
- Confirm the target path is under one of the mapped directories
- Verify mounted disks or shares are present under `/mnt/`

### Direct port access fails with HTTPS enabled

- Verify the certificate files exist under `/ssl/`
- Confirm `certfile` and `keyfile` names are correct

## Upstream Documentation

- [Filebrowser website](https://filebrowser.org/)
- [Filebrowser GitHub repository](https://github.com/filebrowser/filebrowser)
