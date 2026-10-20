<!-- markdownlint-disable -->
<!-- Changelog entries mirror upstream release notes verbatim; upstream formatting is intentionally preserved, so style rules are disabled for this file. -->

## develop-5.0.0.2701-ls199 (2026-10-20)

Updated to upstream Sonarr **5.0.0.2701** (image `develop-5.0.0.2701-ls199`):

<!-- Release notes generated using configuration in .github/release.yml at 7ccafd3a13b737aca0619d4eb0d985c89c00df73 -->

### What's Changed
### Changes
* Translations update from Servarr Weblate by @ServarrAdmin in https://github.com/Sonarr/Sonarr/pull/9156
* Improve form labels and modal headings for screen readers by @coopa11y in https://github.com/Sonarr/Sonarr/pull/9134
* Fixed: On Import Complete notification could use wrong series by @markus101 in https://github.com/Sonarr/Sonarr/pull/9151
* Ignore command body when deserializing command resource by @markus101 in https://github.com/Sonarr/Sonarr/pull/9154
* Fix option key for Disabled For Localhost by @mynameisbogdan in https://github.com/Sonarr/Sonarr/pull/9158
* Improve quality group appearance when editing groups by @markus101 in https://github.com/Sonarr/Sonarr/pull/9159
* Fixed: Version header missing from API error responses by @cplieger in https://github.com/Sonarr/Sonarr/pull/9161
* Fix error trying to return episode file that didn't exist by @cplieger in https://github.com/Sonarr/Sonarr/pull/9162
* Status indicator caused extra scrolling on Chromium browsers by @markus101 in https://github.com/Sonarr/Sonarr/pull/9163
* Responsive Sidebar/Header by @markus101 in https://github.com/Sonarr/Sonarr/pull/9164
* Fixed: Series files were always moved after changing path by @markus101 in https://github.com/Sonarr/Sonarr/pull/9165
* Fix deleting of release profiles by @markus101 in https://github.com/Sonarr/Sonarr/pull/9169

### New Contributors
* @cplieger made their first contribution in https://github.com/Sonarr/Sonarr/pull/9161

**Full Changelog**: https://github.com/Sonarr/Sonarr/compare/v5.0.0.2668...v5.0.0.2701

[Full release notes](https://github.com/Sonarr/Sonarr/releases/tag/v5.0.0.2701)


## 4.0.20.3014-ls329 (2026-10-16)

Updated to upstream Sonarr **4.0.20.3014** (image `4.0.20.3014-ls329`):


### What's Changed
### Changes
* Fixed: Unexpected languages stored in DB will be treated as Unknown by @mynameisbogdan in https://github.com/Sonarr/Sonarr/pull/8810
* Jellyfin/Emby Connection Test and New Jellyfin Auth header by @markus101 in https://github.com/Sonarr/Sonarr/pull/8826
* Fixed: Avoid checking for free space if other specifications fail first by @mynameisbogdan in https://github.com/Sonarr/Sonarr/pull/8867


**Full Changelog**: https://github.com/Sonarr/Sonarr/compare/v4.0.19.2979...v4.0.20.3014

[Full release notes](https://github.com/Sonarr/Sonarr/releases/tag/v4.0.20.3014)


## develop-5.0.0.2608-ls194 (2026-10-15)

Updated to upstream Sonarr **5.0.0.2608** (image `develop-5.0.0.2608-ls194`):


### What's Changed
### Changes
* Translations update from Servarr Weblate by @ServarrAdmin in https://github.com/Sonarr/Sonarr/pull/9103
* Bump .NET to 10.0.13 by @mynameisbogdan in https://github.com/Sonarr/Sonarr/pull/9104
* Fix: Defer series path update until file move completes by @kushiemoon-dev in https://github.com/Sonarr/Sonarr/pull/8799
* New: Fail torrents with rejected file extensions that qBittorrent skipped downloading by @markus101 in https://github.com/Sonarr/Sonarr/pull/9074
* Update incomplete/invalid issue messaging by @markus101 in https://github.com/Sonarr/Sonarr/pull/9087
* Address some initial v5 UI feedback by @markus101 in https://github.com/Sonarr/Sonarr/pull/9092
* Stay on series details page when the title slug changes during a refresh by @markus101 in https://github.com/Sonarr/Sonarr/pull/9105
* Don't start interactive search for episode until requested by @markus101 in https://github.com/Sonarr/Sonarr/pull/9106
* Fixed: Ignore download removing from download client by @markus101 in https://github.com/Sonarr/Sonarr/pull/9107
* Label queued download progress in Calendar and Series views by @coopa11y in https://github.com/Sonarr/Sonarr/pull/9108
* Show Test All results on download client cards by @coopa11y in https://github.com/Sonarr/Sonarr/pull/9109
* Consider unknown series queue items filter in queue status count by @mynameisbogdan in https://github.com/Sonarr/Sonarr/pull/9114
* New: Fail executables and potentially dangerous files by default for most indexers by @markus101 in https://github.com/Sonarr/Sonarr/pull/9093


**Full Changelog**: https://github.com/Sonarr/Sonarr/compare/v5.0.0.2569...v5.0.0.2608

[Full release notes](https://github.com/Sonarr/Sonarr/releases/tag/v5.0.0.2608)


## 4.0.20.3014-ls328 (2026-10-13)

Upstream image rebuild (`4.0.20.3014-ls327` → `4.0.20.3014-ls328`) — packaging / base-image refresh, no application changes (Sonarr **4.0.20.3014**).


## 4.0.20.3014-ls327 (2026-10-10)

Upstream image rebuild (`4.0.20.3014-ls326` → `4.0.20.3014-ls327`) — packaging / base-image refresh, no application changes (Sonarr **4.0.20.3014**).


## 4.0.20.3014-ls326 (2026-09-26)

Upstream image rebuild (`4.0.20.3014-ls325` → `4.0.20.3014-ls326`) — packaging / base-image refresh, no application changes (Sonarr **4.0.20.3014**).


## 4.0.20.3014-ls325 (2026-09-17)

Updated to upstream Sonarr **4.0.20.3014** (image `4.0.20.3014-ls325`):


### What's Changed
### Changes
* Fixed: Unexpected languages stored in DB will be treated as Unknown by @mynameisbogdan in https://github.com/Sonarr/Sonarr/pull/8810
* Jellyfin/Emby Connection Test and New Jellyfin Auth header by @markus101 in https://github.com/Sonarr/Sonarr/pull/8826
* Fixed: Avoid checking for free space if other specifications fail first by @mynameisbogdan in https://github.com/Sonarr/Sonarr/pull/8867


**Full Changelog**: https://github.com/Sonarr/Sonarr/compare/v4.0.19.2979...v4.0.20.3014

[Full release notes](https://github.com/Sonarr/Sonarr/releases/tag/v4.0.20.3014)

## 4.0.19.2979-ls324 (2026-09-12)

Updated to upstream Sonarr **4.0.19.2979** (image `4.0.19.2979-ls324`):


### What's Changed
### Changes
* Fixed: Basic auth for qBittorrent by @mynameisbogdan in https://github.com/Sonarr/Sonarr/pull/8747


**Full Changelog**: https://github.com/Sonarr/Sonarr/compare/v4.0.18.2971...v4.0.19.2979

[Full release notes](https://github.com/Sonarr/Sonarr/releases/tag/v4.0.19.2979)

## develop-4.0.20.3012-ls191 (2026-09-10)

Updated to upstream Sonarr **4.0.20.3012** (image `develop-4.0.20.3012-ls191`):




**Full Changelog**: https://github.com/Sonarr/Sonarr/compare/v4.0.19.3011...v4.0.20.3012

[Full release notes](https://github.com/Sonarr/Sonarr/releases/tag/v4.0.20.3012)

## develop-4.0.19.3011-ls190 (2026-09-07)

Updated to upstream Sonarr **4.0.19.3011** (image `develop-4.0.19.3011-ls190`):




**Full Changelog**: https://github.com/Sonarr/Sonarr/compare/v4.0.19.3009...v4.0.19.3011

[Full release notes](https://github.com/Sonarr/Sonarr/releases/tag/v4.0.19.3011)

## 4.0.19.2979-ls323 (2026-09-05)

Updated to upstream Sonarr **4.0.19.2979** (image `4.0.19.2979-ls323`):


### What's Changed
### Changes
* Fixed: Basic auth for qBittorrent by @mynameisbogdan in https://github.com/Sonarr/Sonarr/pull/8747


**Full Changelog**: https://github.com/Sonarr/Sonarr/compare/v4.0.18.2971...v4.0.19.2979

[Full release notes](https://github.com/Sonarr/Sonarr/releases/tag/v4.0.19.2979)

## develop-4.0.19.3009-ls189 (2026-08-31)

Updated to upstream Sonarr **4.0.19.3009** (image `develop-4.0.19.3009-ls189`):




**Full Changelog**: https://github.com/Sonarr/Sonarr/compare/v4.0.19.3008...v4.0.19.3009

[Full release notes](https://github.com/Sonarr/Sonarr/releases/tag/v4.0.19.3009)

## develop-4.0.19.3008-ls188 (2026-08-30)

Updated to upstream Sonarr **4.0.19.3008** (image `develop-4.0.19.3008-ls188`):




**Full Changelog**: https://github.com/Sonarr/Sonarr/compare/v4.0.19.3007...v4.0.19.3008

[Full release notes](https://github.com/Sonarr/Sonarr/releases/tag/v4.0.19.3008)

## 4.0.19.2979-ls322 (2026-08-22)

Upstream image rebuild (`4.0.19.2979-ls321` → `4.0.19.2979-ls322`) — packaging / base-image refresh, no application changes (Sonarr **4.0.19.2979**).

## 4.0.19.2979-ls321 (2026-08-08)

Updated to upstream Sonarr **4.0.19.2979** (image `4.0.19.2979-ls321`):


### What's Changed
### Changes
* Fixed: Basic auth for qBittorrent by @mynameisbogdan in https://github.com/Sonarr/Sonarr/pull/8747


**Full Changelog**: https://github.com/Sonarr/Sonarr/compare/v4.0.18.2971...v4.0.19.2979

[Full release notes](https://github.com/Sonarr/Sonarr/releases/tag/v4.0.19.2979)

## develop-4.0.19.2997-ls183 (2026-08-05)

Updated to upstream Sonarr **4.0.19.2997** (image `develop-4.0.19.2997-ls183`):




**Full Changelog**: https://github.com/Sonarr/Sonarr/compare/v4.0.19.2995...v4.0.19.2997

[Full release notes](https://github.com/Sonarr/Sonarr/releases/tag/v4.0.19.2997)

## develop-4.0.19.2995-ls182 (2026-07-28)

Updated to upstream Sonarr **4.0.19.2995** (image `develop-4.0.19.2995-ls182`):


### What's Changed
### Changes
* Jellyfin/Emby Connection Test and New Jellyfin Auth header by @markus101 in https://github.com/Sonarr/Sonarr/pull/8826


**Full Changelog**: https://github.com/Sonarr/Sonarr/compare/v4.0.19.2991...v4.0.19.2995

[Full release notes](https://github.com/Sonarr/Sonarr/releases/tag/v4.0.19.2995)

## develop-4.0.19.2991-ls181 (2026-07-26)

Updated to upstream Sonarr **4.0.19.2991** (image `develop-4.0.19.2991-ls181`):


### What's Changed
### Changes
* Fixed: Unexpected languages stored in DB will be treated as Unknown by @mynameisbogdan in https://github.com/Sonarr/Sonarr/pull/8810


**Full Changelog**: https://github.com/Sonarr/Sonarr/compare/v4.0.18.2978...v4.0.19.2991

[Full release notes](https://github.com/Sonarr/Sonarr/releases/tag/v4.0.19.2991)

## 4.0.19.2979-ls320 (2026-07-18)

Upstream image rebuild (`4.0.19.2979-ls319` → `4.0.19.2979-ls320`) — packaging / base-image refresh, no application changes (Sonarr **4.0.19.2979**).

## 4.0.19.2979-ls319 (2026-07-10)

Upstream image rebuild (`4.0.19.2979-ls317` → `4.0.19.2979-ls319`) — packaging / base-image refresh, no application changes (Sonarr **4.0.19.2979**).

## 4.0.19.2979-ls317 (2026-07-04)

Upstream image rebuild (`4.0.19.2979-ls316` → `4.0.19.2979-ls317`) — packaging / base-image refresh, no application changes (Sonarr **4.0.19.2979**).

## 4.0.19.2979-ls316 (2026-06-27)

Updated to upstream Sonarr **4.0.19.2979** (image `4.0.19.2979-ls316`):


### What's Changed
### Changes
* Fixed: Basic auth for qBittorrent by @mynameisbogdan in https://github.com/Sonarr/Sonarr/pull/8747


**Full Changelog**: https://github.com/Sonarr/Sonarr/compare/v4.0.18.2971...v4.0.19.2979

[Full release notes](https://github.com/Sonarr/Sonarr/releases/tag/v4.0.19.2979)

## develop-4.0.18.2978-ls176 (2026-06-26)

Updated to upstream Sonarr **4.0.18.2978** (image `develop-4.0.18.2978-ls176`):


### What's Changed
### Changes
* Fixed: Basic auth for qBittorrent by @mynameisbogdan in https://github.com/Sonarr/Sonarr/pull/8747


**Full Changelog**: https://github.com/Sonarr/Sonarr/compare/v4.0.18.2976...v4.0.18.2978

[Full release notes](https://github.com/Sonarr/Sonarr/releases/tag/v4.0.18.2978)

## develop-4.0.18.2976-ls175 (2026-06-25)

Updated to upstream Sonarr **4.0.18.2976** (image `develop-4.0.18.2976-ls175`):




**Full Changelog**: https://github.com/Sonarr/Sonarr/compare/v4.0.17.2975...v4.0.18.2976

[Full release notes](https://github.com/Sonarr/Sonarr/releases/tag/v4.0.18.2976)

## 4.0.17.2952-ls314 (2026-06-13)

Upstream image rebuild (`4.0.17.2952-ls313` → `4.0.17.2952-ls314`) — packaging / base-image refresh, no application changes (Sonarr **4.0.17.2952**).

## 4.0.17.2952-ls313 (2026-06-06)

Upstream image rebuild (`4.0.17.2952-ls312` → `4.0.17.2952-ls313`) — packaging / base-image refresh, no application changes (Sonarr **4.0.17.2952**).

## 4.0.17.2952-ls312 (2026-05-24)

Upstream image rebuild (`4.0.17.2952-ls311` → `4.0.17.2952-ls312`) — packaging / base-image refresh, no application changes (Sonarr **4.0.17.2952**).

## 4.0.17.2952-ls311 (2026-05-12)

Upstream image rebuild (`4.0.17.2952-ls309` → `4.0.17.2952-ls311`) — packaging / base-image refresh, no application changes (Sonarr **4.0.17.2952**).

## 4.0.17.2952-ls309 (2026-05-01)

Upstream image rebuild (`4.0.17.2952` → `4.0.17.2952-ls309`) — packaging / base-image refresh, no application changes (Sonarr **4.0.17.2952**).

## 4.0.17.2952 (26-04-2026)

- Initial release based on Sonarr 4.0.17.2952
- Uses linuxserver/docker-sonarr as base image
- HA ingress via sidebar (ingress_stream)
- SMB/CIFS network share mounting
- Local disk mounting (USB, SATA, NVMe)
- Custom environment variables
- AppArmor profile for media server permissions

### Upstream Sonarr 4.0.17.2952




**Full Changelog**: https://github.com/Sonarr/Sonarr/compare/v4.0.16.2944...v4.0.17.2952

[Full release notes](https://github.com/Sonarr/Sonarr/releases/tag/v4.0.17.2952)
