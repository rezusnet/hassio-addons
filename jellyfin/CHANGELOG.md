## 10.11.8 (28-04-2026)

- Correct add-on version to match actual Jellyfin 10.11.8 (LSIO image)
- Remove unused nginx package from Dockerfile
- Optimize for Raspberry Pi 5: accurate Pi hardware acceleration documentation
- Add Pi 5 device exposure (/dev/video19 rpivid, /dev/media0-5 media controller)
- Add platform diagnostics at startup: Pi model detection, video/media/DRI device
  enumeration, memory and disk space logging, Pi 5-specific warnings
- Fix ATTACHED_DEVICES_PERMS to include Pi 5 devices
- Document that jellyfin-ffmpeg has no V4L2 support (only Rockchip rkmpp and NVIDIA)
- Document recommended Jellyfin Dashboard settings for Pi 5 software transcoding
- Document Pi 4 vs Pi 5 hardware capabilities comparison table
- Add FFmpeg crash (exit 254) troubleshooting section
- Update add-on description to reflect Pi 5 software-only transcoding
- Fix startup failure: JELLYFIN_WEB_DIR was incorrectly redirected to data
  location instead of /usr/share/jellyfin/web, preventing the web UI from loading
- Fix LOCATION fallback: the null/empty check was setting LOCATION to itself
  instead of /config due to sed substitution order
- Fix init hang: 00-banner.sh bashio::supervisor.ping blocked forever in
  standalone mode
- Add cache-bust ARG to prevent stale module downloads
- SMB/CIFS network share mounting, local disk mounting, custom env vars, Docker mods
- AppArmor profile for media server permissions
