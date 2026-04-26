## 10.11.9 (27-04-2026)

- Fix startup failure: JELLYFIN_WEB_DIR was incorrectly redirected to data
  location instead of /usr/share/jellyfin/web, preventing the web UI from
  loading
- Fix LOCATION fallback: the null/empty check was setting LOCATION to itself
  instead of /config due to sed substitution order

## 10.11.8 (26-04-2026)

- Initial release based on Jellyfin 10.11.8
- Uses linuxserver/docker-jellyfin as base image
- Hardware acceleration support (VAAPI, V4L2, MMAL/OpenMAX) for Intel, AMD, Raspberry Pi
- HA ingress via sidebar (ingress_stream)
- SMB/CIFS network share mounting
- Local disk mounting (USB, SATA, NVMe)
- Custom environment variables
- Docker mods support for additional hardware acceleration
- AppArmor profile for media server permissions
