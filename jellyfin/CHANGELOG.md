<!-- markdownlint-disable -->
<!-- Changelog entries mirror upstream release notes verbatim; upstream formatting is intentionally preserved, so style rules are disabled for this file. -->

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

### Upstream Jellyfin 10.11.8

### :rocket: Jellyfin Server 10.11.8

We are pleased to announce the latest stable release of Jellyfin, version 10.11.8! This minor release brings several bugfixes to improve your Jellyfin experience. As always, please ensure you take a full backup before upgrading!

**Note**: This release fixes several regressions from 10.11.7, with the goal to get people onto an updated release due to the forthcoming (t-minus 9 days) release of the GHSAs/CVEs that were fixed in 10.11.7. Please upgrade to this release as soon as you can.

You can find more details about and discuss this release [on our forums](https://forum.jellyfin.org/t-new-jellyfin-server-web-release-10-11-8).

### Changelog (3)

### 📈 General Changes
* Handle folders without associated library in FixLibrarySubtitleDownloadLanguages [PR #16540], by @Shadowghost
* Fix subtitle saving [PR #16539], by @MBR-0001
* Fix querying media with language filters [PR #16538], by @MBR-0001

[Full release notes](https://github.com/jellyfin/jellyfin/releases/tag/v10.11.8)
