<!-- markdownlint-disable -->
<!-- Changelog entries mirror upstream release notes verbatim; upstream formatting is intentionally preserved, so style rules are disabled for this file. -->

## 5.2.3_v2.0.14-ls477 (2026-09-21)

Upstream image rebuild (`5.2.3_v2.0.14-ls476` → `5.2.3_v2.0.14-ls477`) — packaging / base-image refresh, no application changes (qBittorrent **5.2.3**).


## 5.2.3_v2.0.14-ls476 (2026-09-14)

Upstream image rebuild (`5.2.3_v2.0.14-ls475` → `5.2.3_v2.0.14-ls476`) — packaging / base-image refresh, no application changes (qBittorrent **5.2.3**).

## 5.2.3_v2.0.14-ls475 (2026-09-07)

Upstream image rebuild (`5.2.3_v2.0.14-ls474` → `5.2.3_v2.0.14-ls475`) — packaging / base-image refresh, no application changes (qBittorrent **5.2.3**).

## 5.2.3_v2.0.14-ls474 (2026-08-31)

Upstream image rebuild (`5.2.3_v2.0.14-ls473` → `5.2.3_v2.0.14-ls474`) — packaging / base-image refresh, no application changes (qBittorrent **5.2.3**).

## 5.2.3_v2.0.14-ls473 (2026-08-24)

Upstream image rebuild (`5.2.3_v2.0.14-ls472` → `5.2.3_v2.0.14-ls473`) — packaging / base-image refresh, no application changes (qBittorrent **5.2.3**).

## 5.2.3_v2.0.14-ls472 (2026-08-17)

Upstream image rebuild (`5.2.3_v2.0.14-ls471` → `5.2.3_v2.0.14-ls472`) — packaging / base-image refresh, no application changes (qBittorrent **5.2.3**).

## 5.2.3_v2.0.14-ls471 (2026-08-11)

Upstream image rebuild (`5.2.3_v2.0.13-ls470` → `5.2.3_v2.0.14-ls471`) — packaging / base-image refresh, no application changes (qBittorrent **5.2.3**).

## 5.2.3_v2.0.13-ls470 (2026-08-10)

Upstream image rebuild (`5.2.3_v2.0.13-ls469` → `5.2.3_v2.0.13-ls470`) — packaging / base-image refresh, no application changes (qBittorrent **5.2.3**).

## 5.2.3_v2.0.13-ls469 (2026-07-20)

Upstream image rebuild (`5.2.3_v2.0.13-ls468` → `5.2.3_v2.0.13-ls469`) — packaging / base-image refresh, no application changes (qBittorrent **5.2.3**).

## 5.2.3_v2.0.13-ls468 (2026-07-13)

Upstream image rebuild (`5.2.3_v2.0.13-ls467` → `5.2.3_v2.0.13-ls468`) — packaging / base-image refresh, no application changes (qBittorrent **5.2.3**).

## 5.2.3_v2.0.13-ls467 (2026-07-09)

Upstream image rebuild (`5.2.3_v2.0.13-ls466` → `5.2.3_v2.0.13-ls467`) — packaging / base-image refresh, no application changes (qBittorrent **5.2.3**).

## 5.2.3_v2.0.13-ls466 (2026-07-08)

Updated to upstream qBittorrent **5.2.3** (image `5.2.3_v2.0.13-ls466`):

- BUGFIX: Fix MIME header encoding in email to require ASCII (quinot) #24382
- BUGFIX: Fix potential invalid migration procedure (Chocobo1) #24502
- BUGFIX: Resolve relative UI theme paths (TurboTheTurtle) #24514
- BUGFIX: Clear transfer filters when sections collapse (TurboTheTurtle) #24517
- BUGFIX: Fix potential deadlock when database transaction failed (Chocobo1) #24542
- BUGFIX: Fix wrong torrent tracker conversion (Chocobo1) #24546
- BUGFIX: Fix wrong encoding for Web Seeds (Chocobo1) #24593
- BUGFIX: Use stricter parsing for Peer Address inputs (Chocobo1) #24595
- BUGFIX: Revise regex expression for parsing HTML links (Chocobo1) #24597
- WEBUI: Correctly escape CSS query selector so the UI won't break (vafada) #24539
- RSS: Fix feeds not following the specified interval (vafada) #24553
- SEARCH: Fix plugin counting when updating (Chocobo1) #24544
- WINDOWS: Avoid using invalid file attributes when renaming files (Chocobo1) #24543

[Full release notes](https://github.com/qbittorrent/qBittorrent/releases/tag/release-5.2.3)

## 5.2.2_v2.0.13-ls465 (2026-07-06)

Upstream image rebuild (`5.2.2_v2.0.13-ls464` → `5.2.2_v2.0.13-ls465`) — packaging / base-image refresh, no application changes (qBittorrent **5.2.2**).

## 5.2.2_v2.0.13-ls464 (2026-06-29)

Upstream image rebuild (`5.2.2_v2.0.13-ls463` → `5.2.2_v2.0.13-ls464`) — packaging / base-image refresh, no application changes (qBittorrent **5.2.2**).

## 5.2.2_v2.0.13-ls463 (2026-06-22)

Upstream image rebuild (`5.2.2_v2.0.13-ls462` → `5.2.2_v2.0.13-ls463`) — packaging / base-image refresh, no application changes (qBittorrent **5.2.2**).

## 5.2.2_v2.0.13-ls462 (2026-06-16)

Updated to upstream qBittorrent **5.2.2** (image `5.2.2_v2.0.13-ls462`):

- FEATURE: Use D-Bus to show file in file managers (Chocobo1) #24340
- BUGFIX: Fix friendlyUnitCompact precision calculation (vafada) #24323
- BUGFIX: Remove all top-level folders (glassez) #24333
- BUGFIX: Use proper API for checking exit status (Chocobo1) #24349
- BUGFIX: Delete stale lockfile when hostname mismatch (TurboTheTurtle, glassez) #24363
- BUGFIX: Fix wrong removal procedure of watched folder paths (Chocobo1) #24413
- BUGFIX: Don't reannounce before interface changes are applied (glassez) #24447
- BUGFIX: Use Latin script for Bosnian locale name (Andy Ye) #24342
- WEBUI: Fix performance of global checkbox toggling (tehcneko) #24316
- WEBUI: Fix Safari transfer list header misalignment (Piccirello) #24377
- WEBUI: Fix error when submitting magnet before metadata loads (Piccirello) #24378
- WEBUI: Use correct row id when updating Rss Downloader feed selection (Chocobo1) #24402
- WEBUI: Use SameSite=Lax for session cookie to fix cross-site login (Piccirello) #24422
- WEBUI: Bring back properties panel expand/collapse button (vafada) #24430
- WEBAPI: Only use X-Forwarded-Host header when reverse proxy support is enabled (Chocobo1) #24457
- RSSS: Fix "RSS Smart Episode Filter" RegEx (nathanon-akk, glassez) #24398
- RSS: Fix previously matched episode format (glassez) #24452
- WINDOWS: Fix Python fallback search path (TurboTheTurtle) #24325
- WINDOWS: NSIS: Allow to install x64 binary on ARM64 (Chocobo1) #24358

[Full release notes](https://github.com/qbittorrent/qBittorrent/releases/tag/release-5.2.2)

## 5.2.1_v2.0.13-ls461 (2026-06-15)

Upstream image rebuild (`5.2.1_v2.0.13-ls460` → `5.2.1_v2.0.13-ls461`) — packaging / base-image refresh, no application changes (qBittorrent **5.2.1**).

## 5.2.1_v2.0.13-ls460 (2026-06-09)

Upstream image rebuild (`5.2.1_v2.0.12-ls459` → `5.2.1_v2.0.13-ls460`) — packaging / base-image refresh, no application changes (qBittorrent **5.2.1**).

## 5.2.1_v2.0.12-ls459 (2026-05-26)

Updated to upstream qBittorrent **5.2.1** (image `5.2.1_v2.0.12-ls459`):

- BUGFIX: Fix building with latest zlib (glassez) #24200
- BUGFIX: Remove old-format lockfile when starting (glassez) #24218
- BUGFIX: Prevent SSRF via HTTP redirection (AlexandrBlishun) #24270
- BUGFIX: Delete stale lockfile when machine-id mismatch (glassez) #24285
- BUGFIX: Fix handling of 'Accept-Encoding' header (glassez) #24286
- WEBUI: Avoid search downloader for magnet links (TurboTheTurtle) #24211
- WEBUI: Work around browser extension interfering with Add Torrent Dialog (vafada) #24240
- WEBUI: Filter all children of content root (vafada) #24243
- WEBAPI: Don't store API result between calls (beryxz) #24262
- RSS: Fix refresh is indefinitely called when there are no feeds (glassez) #24199
- SEARCH: Avoid proxy interfering with multiprocessing pool (Chocobo1) #24234

[Full release notes](https://github.com/qbittorrent/qBittorrent/releases/tag/release-5.2.1)

## 5.2.0_v2.0.12-ls458 (2026-05-19)

Upstream image rebuild (`5.2.0_v2.0.12-ls455` → `5.2.0_v2.0.12-ls458`) — packaging / base-image refresh, no application changes (qBittorrent **5.2.0**).

## 5.2.0_v2.0.12-ls455 (2026-05-12)

Updated to upstream qBittorrent **5.2.0** (image `5.2.0_v2.0.12-ls455`):

- FEATURE: Show free disk space in status bar (glassez)
- FEATURE: Add control for 'hostname resolver cache expiry interval' (Chocobo1)
- FEATURE: Show info hash in log when a duplicate torrent is added (Chocobo1)
- FEATURE: Swap add file/link buttons on toolbar (lemantisee)
- FEATURE: Revise labels for 'duplicate torrent' actions (Chocobo1)
- FEATURE: Allow to pass torrent comment to external program (glassez)
- FEATURE: Revise Interface section layout in Options dialog (Chocobo1)
- FEATURE: Revise label wordings (Chocobo1)
- FEATURE: Allow to customize PiecesBar colors (glassez)
- FEATURE: Allow to customize ProgressBar color (glassez)
- FEATURE: Add option to make progress bar to follow torrent state color (vafada)
- FEATURE: Add option to disable torrent state colors (glassez)
- FEATURE: Allow to copy content paths of selected torrents (vafada)
- FEATURE: Restore default drag behavior in Torrent Content widget (loop-nop)
- FEATURE: Add Torrent Creator toolbar button (cocopaw)
- FEATURE: Allow to configure style and color scheme on all platforms (glassez)
- FEATURE: Add reboot option when downloads complete (bacek97)
- FEATURE: Implement separate (advanced) "Tracker status" filter (glassez)
- FEATURE: Calculate torrent pieces asynchronously (Chocobo1)
- FEATURE: Use subcategories unconditionally (glassez)
- FEATURE: Allow to set torrent share limits per category (glassez)
- FEATURE: Move torrents to parent category when category is removed (glassez)
- FEATURE: Persist additional trackers and load it on startup (vafada)
- FEATURE: Add "Created On" column to transfer list ((aaron-kruse))
- FEATURE: Add a small gap between progress bars (glassez)
- FEATURE: Add translations for Albanian, Bosnian, Kazakh, Nepali, Serbian (Latin)
- PERFORMANCE: Improve resume queue load performance (TheLQ)
- PERFORMANCE: Avoid copying resume data when loading torrents (glassez)
- BUGFIX: Fix crash when exiting immediately after adding a torrent (glassez)
- BUGFIX: Revise wordings related to SOCKS4 proxy (Chocobo1)
- BUGFIX: Remove dubious seeding time max value (glassez)
- BUGFIX: Make modifying log file perms best effort (Piccirello)
- BUGFIX: Reannounce DHT when reannouncing all trackers (Piccirello)
- BUGFIX: Block invalid file names when renaming torrent content (cocopaw)
- BUGFIX: Don't create lock file in internal data folders (glassez)
- BUGFIX: Log a critical error before aborting the app (glassez)
- BUGFIX: Raise connection max limits (Chocobo1)
- BUGFIX: Make the active torrents filter reflect actual transfers (HanabishiRecca)
- BUGFIX: Raise 'torrent share ratio' maximum limit (Chocobo1)
- BUGFIX: Use consistent text for "Do not download" priority (JohnVeness)
- BUGFIX: Fix incorrect save path when torrent is added from watched folder (glassez)
- BUGFIX: Change "Session" column headings to match non-"Session" (JohnVeness)
- BUGFIX: Fix fail to start seeding newly created torrent in Torrent Creator (Chocobo1)
- BUGFIX: Fix crash when exiting immediately after adding the torrent (glassez)
- BUGFIX: Fix crash due to invalid entry in ipfilter.dat (glassez)
- BUGFIX: Fix crash when closing app with AddNewTorrentDialog opened (glassez)
- WEBUI: Select next available search tab after closing last active tab with X button (sk0merko)
- WEBUI: Support creating new torrents (tehcneko)
- WEBUI: Add headers to RSS entry viewer (Chocobo1)
- WEBUI: Fix dark mode in RSS entry viewer (Chocobo1)

*(…release notes truncated — follow the link below for the full list)*

[Full release notes](https://github.com/qbittorrent/qBittorrent/releases/tag/release-5.2.0)

## 5.1.4-r3-ls452 (2026-05-01)

Upstream image rebuild (`5.1.4` → `5.1.4-r3-ls452`) — packaging / base-image refresh, no application changes (qBittorrent **5.1.4**).

## 5.1.4 (26-04-2026)

- Initial release based on qBittorrent 5.1.4
- Uses linuxserver/docker-qbittorrent as base image
- HA ingress via sidebar (ingress_stream)
- SMB/CIFS network share mounting
- Local disk mounting (USB, SATA, NVMe)
- Custom environment variables
- AppArmor profile for permissions
