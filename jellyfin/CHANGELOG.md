
## 10.11.12 (27-04-2026)

- Force rebuild to pick up fixed 00-banner.sh (Docker layer caching prevented
  the banner fix from being included in 10.11.10/10.11.11)
- Add cache-bust ARG to prevent stale module downloads

## 10.11.11 (27-04-2026)

- Rebuild with fixed 00-banner.sh
## 10.11.10 (27-04-2026)

- Fix init hang: 00-banner.sh bashio::supervisor.ping blocked forever in
  standalone mode because the real bashio library's ping does an untimeouted
  curl to the Supervisor API. Replaced with non-blocking detection.

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
