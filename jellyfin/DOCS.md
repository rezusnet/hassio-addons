## Getting Started

After installing and starting the add-on:

1. Open Jellyfin via the **HA sidebar** (Ingress) or at `http://<your-ha-ip>:8096`
2. Complete the setup wizard to create an admin account
3. Add media libraries pointing to your media directories (e.g., `/media/movies`, `/media/tvshows`)

Your media must be accessible to the add-on. Use the `media:rw` mapping (pre-configured) to access files under `/media/`, or mount additional drives using the **localdisks** or **networkdisks** options.

## Configuration

### Options

| Option          | Type | Default           | Description                                              |
| --------------- | ---- | ----------------- | -------------------------------------------------------- |
| `env_vars`      | list | `[]`              | Custom environment variables (name/value pairs)          |
| `PGID`          | int  | `0`               | Group ID for file permissions                            |
| `PUID`          | int  | `0`               | User ID for file permissions                             |
| `data_location` | str  | `/share/jellyfin` | Path where Jellyfin stores config, cache, and transcodes |
| `TZ`            | str  | `""`              | Timezone (e.g., `Europe/Bucharest`)                      |
| `localdisks`    | str  | `""`              | Local drives to mount (e.g., `sda1,sdb1,MYUSB`)          |
| `networkdisks`  | str  | `""`              | SMB shares to mount (e.g., `//SERVER/SHARE`)             |
| `cifsusername`  | str  | `""`              | SMB username for network shares                          |
| `cifspassword`  | str  | `""`              | SMB password for network shares                          |
| `cifsdomain`    | str  | `""`              | SMB domain for network shares                            |
| `DOCKER_MODS`   | list | `[]`              | LinuxServer Docker mods for additional features          |

### Example Configuration

```yaml
PGID: 0
PUID: 0
TZ: "Europe/Bucharest"
data_location: "/share/jellyfin"
networkdisks: "//192.168.1.100/media"
cifsusername: "mediauser"
cifspassword: "mypassword"
DOCKER_MODS:
  - "linuxserver/mods:jellyfin-opencl-intel"
env_vars:
  - name: JELLYFIN_PublishedServerUrl
    value: "https://jellyfin.example.com"
```

### Custom Environment Variables

Use the `env_vars` option to pass any environment variable to Jellyfin. Each entry has a `name` and optional `value`:

```yaml
env_vars:
  - name: JELLYFIN_PublishedServerUrl
    value: "http://192.168.1.10:8096"
  - name: MALLOC_TRIM_THRESHOLD_
    value: "131072"
```

## File Access

The add-on maps the following HA directories:

| HA Path           | Container Path                   | Access     |
| ----------------- | -------------------------------- | ---------- |
| `/share/jellyfin` | Configurable via `data_location` | Read/Write |
| `/media/`         | `/media/`                        | Read/Write |
| `/share/`         | `/share/`                        | Read/Write |
| Add-on config     | `/addon_configs/*/`              | Read/Write |

Media placed under `/media/` (e.g., via the HA Files add-on or Samba add-on) is directly accessible. For example, if your media is at `/media/IliadMedia/Video/Movies`, add a Jellyfin library pointing to `/media/IliadMedia/Video/Movies`.

## Mounting Drives

### Local Drives

Use the `localdisks` option to mount local USB, SATA, or NVMe drives. Specify device names, UUIDs, or labels separated by commas:

```yaml
localdisks: "sda1,sdb1,MYUSB"
```

Drives are mounted under `/mnt/` in the container (e.g., `/mnt/sda1`, `/mnt/MYUSB`).

### Network Shares (SMB/CIFS)

Use the `networkdisks` option to mount remote SMB/CIFS shares:

```yaml
networkdisks: "//192.168.1.100/media"
cifsusername: "myuser"
cifspassword: "mypassword"
cifsdomain: "workgroup"
```

Multiple shares can be separated by commas. Shares are mounted under `/mnt/` (e.g., `/mnt/media`).

## Hardware Acceleration

### Intel / AMD (VAAPI)

Works out of the box if `/dev/dri` is present on the host. The add-on exposes GPU devices automatically.

In Jellyfin: **Dashboard > Playback > Transcoding > Hardware Acceleration** select **Video Acceleration API (VAAPI)**.

### Raspberry Pi

The add-on exposes `/dev/dri`, `/dev/vchiq`, and `/dev/video10-16` for hardware acceleration.

**Pi 4**: Enable `dtoverlay=vc4-fkms-v3d` in `/boot/usercfg.txt` for `/dev/dri` support.

**Pi 5**: V4L2 M2M and VAAPI should work with the exposed `/dev/dri` device.

In Jellyfin: **Dashboard > Playback > Transcoding > Hardware Acceleration** select:

- **Video Acceleration API (VAAPI)** if `/dev/dri/renderD128` is available
- **OpenMAX** if `/dev/vchiq` is available
- **Video4Linux2 (V4L2)** if `/dev/video10-12` are available

### Docker Mods for Hardware Acceleration

Additional hardware acceleration can be enabled via Docker Mods:

| Mod                                      | Description                                    |
| ---------------------------------------- | ---------------------------------------------- |
| `linuxserver/mods:jellyfin-opencl-intel` | Intel OpenCL for tone-mapping (DV, HDR10, HLG) |
| `linuxserver/mods:jellyfin-amd`          | AMD hardware acceleration                      |
| `linuxserver/mods:jellyfin-rffmpeg`      | Custom FFmpeg build with additional codecs     |

```yaml
DOCKER_MODS:
  - "linuxserver/mods:jellyfin-opencl-intel"
```

## Ports

| Port   | Protocol | Default  | Description                                       |
| ------ | -------- | -------- | ------------------------------------------------- |
| `8096` | TCP      | `8096`   | HTTP web interface                                |
| `8920` | TCP      | `8920`   | HTTPS web interface (optional, requires SSL cert) |
| `7359` | UDP      | Disabled | Client discovery on LAN                           |
| `1900` | UDP      | Disabled | DLNA service discovery                            |

The HTTP port (8096) is enabled by default. Enable other ports in the add-on Configuration tab by changing them from empty to the desired host port.

## SSL / HTTPS

To enable HTTPS on port 8920:

1. Generate a PFX certificate:

   ```bash
   openssl pkcs12 -export -in fullchain.pem -inkey private_key.pem -passout pass: -out server.pfx
   chmod 0700 server.pfx
   ```

2. Place the `.pfx` file in your SSL directory (accessible via the `ssl` mapping)
3. In Jellyfin: **Dashboard > Networking > HTTPS Settings** — set the certificate path and enable HTTPS

## Adding to HA Sidebar

Jellyfin is available via HA Ingress (sidebar). If it doesn't appear:

1. Go to **Settings > Add-ons > Jellyfin**
2. Ensure **Show in sidebar** is enabled
3. Reload the HA page

You can also access Jellyfin directly at `http://<your-ha-ip>:8096` without the sidebar.

## Troubleshooting

### Add-on won't start

- Check logs in **Settings > Add-ons > Jellyfin > Log**
- Ensure `data_location` is a valid, writable path
- If using network shares, verify credentials and connectivity

### No hardware transcoding

- Check that GPU devices exist: `ls -la /dev/dri/` on the host
- For Pi 4: ensure `dtoverlay=vc4-fkms-v3d` is enabled
- Check Jellyfin transcoding logs for errors
- Try different acceleration methods (VAAPI, V4L2, OpenMAX)

### Media files not visible

- Ensure media is under `/media/`, `/share/`, or a mounted drive
- Check file permissions (PGID/PUID)
- Jellyfin needs read access to all media directories

### Performance on Raspberry Pi

- Use **direct play** when possible (no transcoding)
- Set transcoding to a lower resolution if needed
- Use V4L2 hardware acceleration for supported codecs
- Transcode cache writes to `data_location/transcode` — ensure fast storage

## Upstream Documentation

- [Jellyfin Documentation](https://jellyfin.org/docs/)
- [Jellyfin Clients](https://jellyfin.org/clients/)
- [LinuxServer Docker Image](https://github.com/linuxserver/docker-jellyfin)
