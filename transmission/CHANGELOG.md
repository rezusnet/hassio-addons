<!-- markdownlint-disable -->
<!-- Changelog entries mirror upstream release notes verbatim; upstream formatting is intentionally preserved, so style rules are disabled for this file. -->

## 4.1.3-r0-ls362 (2026-09-16)

Upstream image rebuild (`4.1.3-r0-ls361` → `4.1.3-r0-ls362`) — packaging / base-image refresh, no application changes (Transmission **4.1.3**).

## 4.1.3-r0-ls361 (2026-09-09)

Upstream image rebuild (`4.1.3-r0-ls360` → `4.1.3-r0-ls361`) — packaging / base-image refresh, no application changes (Transmission **4.1.3**).

## 4.1.3-r0-ls360 (2026-09-02)

Upstream image rebuild (`4.1.3-r0-ls359` → `4.1.3-r0-ls360`) — packaging / base-image refresh, no application changes (Transmission **4.1.3**).

## 4.1.3-r0-ls359 (2026-08-26)

Upstream image rebuild (`4.1.3-r0-ls358` → `4.1.3-r0-ls359`) — packaging / base-image refresh, no application changes (Transmission **4.1.3**).

## 4.1.3-r0-ls358 (2026-08-19)

Upstream image rebuild (`4.1.3-r0-ls357` → `4.1.3-r0-ls358`) — packaging / base-image refresh, no application changes (Transmission **4.1.3**).

## 4.1.3-r0-ls357 (2026-08-05)

Upstream image rebuild (`4.1.3-r0-ls356` → `4.1.3-r0-ls357`) — packaging / base-image refresh, no application changes (Transmission **4.1.3**).

## 4.1.3-r0-ls356 (2026-07-29)

Upstream image rebuild (`4.1.3-r0-ls355` → `4.1.3-r0-ls356`) — packaging / base-image refresh, no application changes (Transmission **4.1.3**).

## 4.1.3-r0-ls355 (2026-07-22)

Upstream image rebuild (`4.1.3-r0-ls354` → `4.1.3-r0-ls355`) — packaging / base-image refresh, no application changes (Transmission **4.1.3**).

## 4.1.3-r0-ls354 (2026-07-15)

Upstream image rebuild (`4.1.3-r0-ls353` → `4.1.3-r0-ls354`) — packaging / base-image refresh, no application changes (Transmission **4.1.3**).

## 4.1.3-r0-ls353 (2026-07-08)

Upstream image rebuild (`4.1.3-r0-ls352` → `4.1.3-r0-ls353`) — packaging / base-image refresh, no application changes (Transmission **4.1.3**).

## 4.1.3-r0-ls352 (2026-07-01)

Updated to upstream Transmission **4.1.3** (image `4.1.3-r0-ls352`):

### Transmission 4.1.3

This is Transmission 4.1.3, a bugfix release. It fixes a potential CRSF security issue for users who enable remote access to Transmission. Users are encouraged to upgrade to this version.

### What's New in 4.1.3

### All Platforms

* Fixed a CORS bug that leaked the anti-CSRF nonce. ([#8938](https://github.com/transmission/transmission/pull/8938))
* Fixed a use-after-free bug in peer code. ([#8921](https://github.com/transmission/transmission/pull/8921))
* Fixed build error when compiling with [fmt](https://github.com/fmtlib/fmt) 12.2.0. ([#8942](https://github.com/transmission/transmission/pull/8942))

### Everything Else

* Fixed a `4.1.2` build error in tests. ([#8881](https://github.com/transmission/transmission/pull/8881))

[Full release notes](https://github.com/transmission/transmission/releases/tag/4.1.3)

## 4.1.2-r0-ls350 (2026-06-24)

Upstream image rebuild (`4.1.2-r0-ls349` → `4.1.2-r0-ls350`) — packaging / base-image refresh, no application changes (Transmission **4.1.2**).

## 4.1.2-r0-ls349 (2026-06-17)

Upstream image rebuild (`4.1.2-r0-ls348` → `4.1.2-r0-ls349`) — packaging / base-image refresh, no application changes (Transmission **4.1.2**).

## 4.1.2-r0-ls348 (2026-06-10)

Upstream image rebuild (`4.1.2-r0-ls347` → `4.1.2-r0-ls348`) — packaging / base-image refresh, no application changes (Transmission **4.1.2**).

## 4.1.2-r0-ls347 (2026-06-04)

Updated to upstream Transmission **4.1.2** (image `4.1.2-r0-ls347`):

### Transmission 4.1.2

This is Transmission 4.1.2, a bugfix release. It fixes 20+ bugs and has a few performance improvements too. All users are encouraged to upgrade to this version.

This progress was possible because of good bug reports and performance logs reported by users. Thanks, and keep them coming!

### What's New in 4.1.2

### Highlights

* Fixed `4.1.0` bug that could cause duplicate HTTP announces to be sent to trackers. ([#8639](https://github.com/transmission/transmission/pull/8639))

### All Platforms

* Reject benc data that has invalid characters. ([#8577](https://github.com/transmission/transmission/pull/8577))
* Fixed a bug during the startup sequence where if one torrent failed to parse, subsequent torrents would also fail. ([#8605](https://github.com/transmission/transmission/pull/8605))
* Fixed a bug that stalled some downloads at 99%. ([#8654](https://github.com/transmission/transmission/pull/8654))
* Fixed a `4.1.0` upgrade bug that could overwrite `utp_enabled` and `tcp_enabled` settings. ([#8658](https://github.com/transmission/transmission/pull/8658))
* Fixed a `4.1.0` crash that could happen when a peer supplied `reqq` value smaller than 32 in LTEP handshake. ([#8713](https://github.com/transmission/transmission/pull/8713))
* Fixed a `4.1.0` regression that periodically wrote upload & download stats to disk even when Transmission had been idle since the last write, preventing the stats file's disk from hibernating while idle. ([#8722](https://github.com/transmission/transmission/pull/8722))
* Fixed a `4.1.0` bug that prevented TCP peer connections on some systems. ([#8748](https://github.com/transmission/transmission/pull/8748))
* Added safeguards to HTTP responses to prevent clickjacking. ([#8749](https://github.com/transmission/transmission/pull/8749))
* Fixed edge case that didn't preserve the order of a batch of torrents when moving their queue position up or down. ([#8782](https://github.com/transmission/transmission/pull/8782))
* Added sanitization for UTF-8 client names provided by peers during handshake. ([#8809](https://github.com/transmission/transmission/pull/8809))
* Stopped appending redundant zeros to blocklist files when downloaded from a remote URL. ([#8819](https://github.com/transmission/transmission/pull/8819))
* Fixed a build failure that occurred when building with link-time optimization. ([#8540](https://github.com/transmission/transmission/pull/8540))

### macOS Client

* Fixed a `4.1.0` memory leak. ([#8613](https://github.com/transmission/transmission/pull/8613))
* Fixed navigation focus issues in the Inspector. ([#8792](https://github.com/transmission/transmission/pull/8792), [#8810](https://github.com/transmission/transmission/pull/8810))
* Improved UI code to use less CPU. ([#8832](https://github.com/transmission/transmission/pull/8832), [#8833](https://github.com/transmission/transmission/pull/8833), [#8835](https://github.com/transmission/transmission/pull/8835), [#8836](https://github.com/transmission/transmission/pull/8836), [#8842](https://github.com/transmission/transmission/pull/8842), [#8846](https://github.com/transmission/transmission/pull/8846), [#8851](https://github.com/transmission/transmission/pull/8851))

### Qt Client

*(…release notes truncated — follow the link below for the full list)*

[Full release notes](https://github.com/transmission/transmission/releases/tag/4.1.2)

## 4.1.1-r1-ls346 (2026-06-01)

Upstream image rebuild (`4.1.1-r1-ls345` → `4.1.1-r1-ls346`) — packaging / base-image refresh, no application changes (Transmission **4.1.1**).

## 4.1.1-r1-ls345 (2026-05-27)

Upstream image rebuild (`4.1.1-r1-ls344` → `4.1.1-r1-ls345`) — packaging / base-image refresh, no application changes (Transmission **4.1.1**).

## 4.1.1-r1-ls344 (2026-05-24)

Upstream image rebuild (`4.1.1-r1-ls343` → `4.1.1-r1-ls344`) — packaging / base-image refresh, no application changes (Transmission **4.1.1**).

## 4.1.1-r1-ls343 (2026-05-13)

Upstream image rebuild (`4.1.1-r1-ls342` → `4.1.1-r1-ls343`) — packaging / base-image refresh, no application changes (Transmission **4.1.1**).

## 4.1.1-r1-ls342 (2026-05-12)

Upstream image rebuild (`4.1.1-r1-ls341` → `4.1.1-r1-ls342`) — packaging / base-image refresh, no application changes (Transmission **4.1.1**).

## 4.1.1-r1-ls341 (2026-05-01)

Upstream image rebuild (`4.1.1` → `4.1.1-r1-ls341`) — packaging / base-image refresh, no application changes (Transmission **4.1.1**).

## 4.1.1 (26-04-2026)

- Initial release based on Transmission 4.1.1
- Uses linuxserver/docker-transmission as base image
- HA ingress via sidebar (ingress_stream)
- SMB/CIFS network share mounting
- Local disk mounting (USB, SATA, NVMe)
- Custom environment variables
- AppArmor profile for permissions

### Upstream Transmission 4.1.1

### Transmission 4.1.1

This is Transmission 4.1.1, a bugfix release.

4.1.0 was in development for over a year, so we've gotten a lot of good feedback, including actionable bug reports, since it was released three weeks ago. 4.1.1 fixes 20+ bugs and also has some performance improvements. All users are encouraged to upgrade to this version.

This progress was possible because of good bug reports and performance logs reported by users. Thanks, and keep them coming!

### What's New in 4.1.1

### All Platforms

* Fixed a `4.1.0` bug that failed to report some filesystem errors to RPC clients who were querying the system's free space available. ([#8258](https://github.com/transmission/transmission/pull/8258))
* Fixed a `4.1.0` bug that kept a a torrent's updated queue position from being shown. ([#8298](https://github.com/transmission/transmission/pull/8298))
* Fixed a `4.1.0` bug that caused torrents' queuing order to sometimes be lost between sessions. ([#8306](https://github.com/transmission/transmission/pull/8306))
* Fixed "assertion failed: no timezone" error on OpenSolaris. ([#8358](https://github.com/transmission/transmission/pull/8358))
* Fixed a `4.0.0` bug that displayed the wrong mime-type icon for mp4 video files. ([#8411](https://github.com/transmission/transmission/pull/8411))
* Hardened .torrent parsing by exiting sooner if  `pieces` has an invalid size. ([#8412](https://github.com/transmission/transmission/pull/8412))
* Reverted a `4.1.0` RPC change that broke some 3rd party code by returning floating-point numbers, rather than integers, for speed limit fields. ([#8416](https://github.com/transmission/transmission/pull/8416))
* Fixed crash that could happen if a user paused a torrent and edited its tracker list at the same time. ([#8478](https://github.com/transmission/transmission/pull/8478))
* Fixed `4.1.0` crash on arm32 by switching crc32 libraries to Mark Madler's [crcany](https://github.com/madler/crcany). ([#8529](https://github.com/transmission/transmission/pull/8529))
* Require UTF-8 filenames in .torrent files, as required by the [BitTorrent spec](https://www.bittorrent.org/beps/bep_0003.html). ([#8541](https://github.com/transmission/transmission/pull/8541))
* Fixed crash that could occur when parsing a .torrent file with a bad `pieces` key. ([#8542](https://github.com/transmission/transmission/pull/8542))
* Fixed potential file descriptor leak when launching scripts on POSIX systems. ([#8549](https://github.com/transmission/transmission/pull/8549))
* Changed the network traffic algorithm to spread bandwidth more evenly amongst peers. ([#8259](https://github.com/transmission/transmission/pull/8259))
* Improved laggy user interface when bandwidth usage is high. ([#8454](https://github.com/transmission/transmission/pull/8454))

### macOS Client

*(…release notes truncated — follow the link below for the full list)*

[Full release notes](https://github.com/transmission/transmission/releases/tag/4.1.1)
