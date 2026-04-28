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

Media placed under `/media/` (e.g., via the HA Files add-on or Samba add-on) is directly accessible.

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

### Raspberry Pi 5

The Pi 5's BCM2712 SoC has **no hardware video encoder**. It has an HEVC/H.265 hardware decoder (`rpivid`), but `jellyfin-ffmpeg` does not include the V4L2 request API needed to use it. Jellyfin has officially [deprecated V4L2 support for Raspberry Pi](https://jellyfin.org/docs/general/post-install/transcoding/hardware-acceleration/).

**All transcoding on Pi 5 is software-only** (CPU). The Cortex-A76 quad-core CPU can handle 1080p software transcoding at approximately 1x realtime speed.

#### Recommended Dashboard Settings for Pi 5

Go to **Dashboard > Playback > Transcoding**:

| Setting                  | Value       | Why                                    |
| ------------------------ | ----------- | -------------------------------------- |
| Hardware acceleration    | **None**    | No working HW accel on Pi 5            |
| Enable hardware decoding | **Uncheck** | No supported hardware decoder          |
| Enable hardware encoding | **Uncheck** | No hardware encoder exists             |
| Transcoding thread count | **4**       | Match Pi 5's 4 cores                   |
| Allow encoding in HEVC   | **Disable** | HEVC encoding is very slow in software |
| Max streaming bitrate    | **20 Mbps** | Limits transcode load                  |

#### Performance Tips

- **Use Direct Play** whenever possible -- no transcoding needed. Configure clients to prefer original quality.
- **Put `data_location` on fast storage** -- use a USB SSD or NVMe drive for the transcode cache. SD cards are too slow and will cause buffering.
- **Use H.264/AAC media** -- most clients can direct-play H.264. Avoid HEVC unless your clients support it natively.
- **Ensure active cooling** -- the Pi 5 thermal throttles at 80C, which halves transcoding speed.
- **Limit to 1 simultaneous transcode** -- the Pi 5 lacks CPU headroom for multiple streams.
- **Avoid 4K transcoding** -- the CPU cannot transcode 4K in realtime. Use 4K only with Direct Play clients.

#### Increasing CMA for 4K HEVC (Experimental)

If you plan to experiment with HEVC hardware decode via a custom FFmpeg build, increase the CMA pool:

```ini
dtoverlay=vc4-kms-v3d-pi5,cma-256
```

Add this to `/boot/firmware/config.txt` (or `/boot/config.txt`) on the host. Available sizes: 64 (default), 96, 128, 192, 256, 320, 384, 448, 512 MB.

### Raspberry Pi 4

The Pi 4 has limited hardware acceleration via V4L2 M2M and OpenMAX. This support is deprecated in Jellyfin and may break in future releases.

1. Enable `dtoverlay=vc4-fkms-v3d` in `/boot/usercfg.txt` for `/dev/dri` support
2. In Jellyfin: **Dashboard > Playback > Transcoding > Hardware Acceleration** select **Video4Linux2 (V4L2)**
3. Available devices: `/dev/video10-12` (V4L2 M2M), `/dev/vchiq` (OpenMAX)

| Capability    | Pi 4 | Pi 5                                         |
| ------------- | ---- | -------------------------------------------- |
| HEVC decode   | Yes  | HW exists but unsupported by jellyfin-ffmpeg |
| H.264 decode  | Yes  | No hardware decoder                          |
| H.264 encode  | Yes  | No hardware encoder                          |
| HEVC encode   | No   | No hardware encoder                          |
| VAAPI         | No   | No                                           |
| OpenMAX (OMX) | Yes  | No (no `/dev/vchiq`)                         |
| V4L2 M2M      | Yes  | Deprecated                                   |
| Best accel    | V4L2 | **None (software only)**                     |

### Docker Mods for Hardware Acceleration

Additional hardware acceleration can be enabled via Docker Mods:

| Mod                                      | Description                                    |
| ---------------------------------------- | ---------------------------------------------- |
| `linuxserver/mods:jellyfin-opencl-intel` | Intel OpenCL for tone-mapping (DV, HDR10, HLG) |
| `linuxserver/mods:jellyfin-amd`          | AMD hardware acceleration                      |
| `linuxserver/mods:jellyfin-rffmpeg`      | Remote FFmpeg distributed transcoding          |

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
3. In Jellyfin: **Dashboard > Networking > HTTPS Settings** -- set the certificate path and enable HTTPS

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
- For Pi 5: hardware transcoding is not supported -- use software transcoding
- For Pi 4: ensure `dtoverlay=vc4-fkms-v3d` is enabled
- Check Jellyfin transcoding logs for errors

### Media files not visible

- Ensure media is under `/media/`, `/share/`, or a mounted drive
- Check file permissions (PGID/PUID)
- Jellyfin needs read access to all media directories

### Playback buffering or stuttering

- **Use Direct Play** -- configure clients to prefer original quality, not lower bitrates that require transcoding
- Check network speed between client and server (use Ethernet, not Wi-Fi)
- On Pi 5: the CPU can only handle ~1x realtime for 1080p software transcoding
- Move `data_location` to a USB SSD if currently on SD card
- Ensure active cooling on Pi 5 to prevent thermal throttling
- Check the add-on log for platform diagnostics (device enumeration, memory, disk space)

### FFmpeg crashes or exit code 254

- This typically indicates the CPU ran out of resources during software transcoding
- Disable HEVC encoding in Dashboard > Playback
- Lower the maximum streaming bitrate to reduce transcode resolution
- Limit to 1 simultaneous transcode
- Check available memory in the add-on log
- Ensure the transcode directory has sufficient free space

## Upstream Documentation

- [Jellyfin Documentation](https://jellyfin.org/docs/)
- [Jellyfin Hardware Acceleration](https://jellyfin.org/docs/general/post-install/transcoding/hardware-acceleration/)
- [Jellyfin Clients](https://jellyfin.org/clients/)
- [LinuxServer Docker Image](https://github.com/linuxserver/docker-jellyfin)
