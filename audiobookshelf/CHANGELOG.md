<!-- markdownlint-disable -->
<!-- Changelog entries mirror upstream release notes verbatim; upstream formatting is intentionally preserved, so style rules are disabled for this file. -->

## 2.36.1 (2026-09-17)

Updated to upstream Audiobookshelf **2.36.1**:

#### Important: New authentication system was added in [v2.26.0](https://github.com/advplyr/audiobookshelf/releases/tag/v2.26.0). See https://github.com/advplyr/audiobookshelf/discussions/4460 for details.

### Fixed

- Collapse series not working when filters are enabled #2807 #3049 by @schummar in #5280
- Podcast rescan emitting stale episodes on `item_updated` by @mikiher in #5409
- Updating or deleting a narrator in one library applying the change to all libraries
- Author endpoints not checking user can access the author's library
- Share endpoints not sending 404 status
- Upload endpoint not handling directory creation errors
- sqlite3 bindings not installing when using npm v12 #5412 by @Vito0912 in #5429

### Updated

- Comic book extractor file path sanitization by @Vito0912
- Auth settings PATCH sanitizes `authLoginCustomMessage` HTML
- API: Settings PATCH endpoint only accepts a fixed set of general settings (auth settings must go through the auth-settings endpoint)
- API: Cover endpoints only allow `webp`, `jpeg` and `png` as optional format param
- API: Library item media update no longer accepts `ebookFile`, `chapters` and `audioFiles` in request body
- More strings translated
  - Belarusian by @pavel-miniutka
  - Bengali by @ShamiaAkterShanta
  - Chinese (Simplified Han script) by @FiendFEARing
  - Chinese (Traditional Han script) by @JBlond @violawang0401-cloud
  - Croatian by Igor Dobrača
  - Czech by @kuci-JK
  - Danish by Kim Josefsen
  - Dutch by @Kwintenc
  - Finnish by @JBlond
  - French by Charlie, J. Lavoie
  - German by @VoltKraft; J. Lavoie, Zarakkas
  - Greek by J. Lavoie
  - Hungarian by @ugyes
  - Italian by @lollos78; J. Lavoie
  - Lithuanian by @Haya25 @PovilasID
  - Polish by @MarcinKlejna @TheMatrixan
  - Portuguese (Brazil) by @AgenteGabrielofc
  - Russian by @vmakeev

### Internal

- Restore the mount prefix when handing requests to Next.js by @mikiher in #5507
- Github workflow to generate translator credits for release notes by @nichwall in #5558

### New Contributors
* @schummar made their first contribution in https://github.com/advplyr/audiobookshelf/pull/5280

**Full Changelog**: https://github.com/advplyr/audiobookshelf/compare/v2.36.0...v2.36.1

[Full release notes](https://github.com/advplyr/audiobookshelf/releases/tag/v2.36.1)

## 2.36.0 (2026-07-28)

Updated to upstream Audiobookshelf **2.36.0**:

#### Important: New authentication system was added in [v2.26.0](https://github.com/advplyr/audiobookshelf/releases/tag/v2.26.0). See https://github.com/advplyr/audiobookshelf/discussions/4460 for details.

### Added

- Logout all devices button on account page (in #5395)
- Auth sessions table on account page w/ ability to logout of individual sessions (in #5400)

### Fixed

- Weak protocol validation for OIDC post-login callback URL by @mikiher in #5386
- User delete endpoint allowing for root account deletion by @mikiher in #5370
- API and websocket authentication allowing refresh tokens by @mikiher in #5387
- Bulk library item download endpoint not checking access on individual items by @mikiher in #5388
- Manual podcast episode match not setting the enclosure url #5317 by @mikiher in #5318

### Updated

- Changing user password invalidates all auth sessions (in #5393)
- Extend refresh token grace period to 10 minutes and allow `REFRESH_TOKEN_GRACE_PERIOD` env variable override #5281 by @DanielAshley in #5376
- API: New GET endpoints `/api/me/progress`, `/api/me/bookmarks`, `/api/me/bookmarks/:libraryItemId` by @Vito0912 in #5363
- API: Add all minified fields to expanded library item JSON by @mikiher in #5341
- API: Server settings now include `timeZone` for server timezone (for giving accurate cron job next schedule date)
- API: `/logout` endpoint now supports `?allDevices=1` query param to delete all other sessions and rotate current (in #5395)
- API: New endpoint GET `/api/me/sessions` to get all auth sessions (in #5400 and #5405)
- API: New endpoint DELETE `/api/me/sessions/:id` to delete an auth session (in #5405)
- New socket event `authors_num_books_updated` is emitted during a scan when author book count changes by @mikiher in #5354
- Socket event `author_added` is now emitted during scans by @mikiher in #5354
- UI/UX: Update outdated help links for new docs site by @francisrath in #5336
- More strings translated
  - Chinese (Simplified Han script) by @FiendFEARing
  - Danish by @MikkelOlesen @hhjuhl
  - Greek by @no1ta
  - Icelandic by @axelbjornsson
  - Portuguese (Brazil) by @AgenteGabrielofc
  - Tamil by @TamilNeram

### Internal

- Read AllowedDevOrigins from dev.js into ALLOWED_DEV_ORIGINS env var by @mikiher in #5291
- Setup internal-api file upload passthrough for next.js by @mikiher in #5325
- Readme update about frontend rewrite by @nichwall in #5407

### New Contributors
* @DanielAshley made their first contribution in https://github.com/advplyr/audiobookshelf/pull/5376
* @francisrath made their first contribution in https://github.com/advplyr/audiobookshelf/pull/5336

**Full Changelog**: https://github.com/advplyr/audiobookshelf/compare/v2.35.1...v2.36.0

[Full release notes](https://github.com/advplyr/audiobookshelf/releases/tag/v2.36.0)

## 2.35.1 (2026-05-29)

Updated to upstream Audiobookshelf **2.35.1**:

#### Important: New authentication system was added in [v2.26.0](https://github.com/advplyr/audiobookshelf/releases/tag/v2.26.0). See https://github.com/advplyr/audiobookshelf/discussions/4460 for details.

### Fixed

- Duplicate refresh tokens across sessions can cause unexpected logout #5253 by @nichwall in #5255
- Server crash when renaming an author to another author when they are both on the same book #5247 by @nichwall in #5256
- Server crash when invalid `metadata.json` is scanned in #5268
- Sequelize user queries to use direct case-insensitive username/email matching

**Full Changelog**: https://github.com/advplyr/audiobookshelf/compare/v2.35.0...v2.35.1

[Full release notes](https://github.com/advplyr/audiobookshelf/releases/tag/v2.35.1)

## 2.35.0 (2026-05-19)

Updated to upstream Audiobookshelf **2.35.0**:

#### Important: New authentication system was added in [v2.26.0](https://github.com/advplyr/audiobookshelf/releases/tag/v2.26.0). See https://github.com/advplyr/audiobookshelf/discussions/4460 for details.

### Added

- Access token refresh grace period (fixes frequently needing to re-login) #4630 by @nichwall in #5004

### Fixed

- Listening sessions from Android app showing device name as `Abs iOS`
- RSS feeds serving m4b files with incorrect Content-Type #5041 by @brandonfhall in #5221

### Changed

- Book & podcast descriptions from audio files are sanitized
- `cancel_scan` and `set_log_listener` socket events validate account type and log level
- More strings translated
  - Belarusian by @pavel-miniutka
  - Polish by @TheMatrixan

### New Contributors
* @brandonfhall made their first contribution in https://github.com/advplyr/audiobookshelf/pull/5221

**Full Changelog**: https://github.com/advplyr/audiobookshelf/compare/v2.34.0...v2.35.0

[Full release notes](https://github.com/advplyr/audiobookshelf/releases/tag/v2.35.0)

## 2.34.0 (2026-05-01)

Updated to upstream Audiobookshelf **2.34.0**:

#### Important: New authentication system was added in [v2.26.0](https://github.com/advplyr/audiobookshelf/releases/tag/v2.26.0). See https://github.com/advplyr/audiobookshelf/discussions/4460 for details.

### Added

- Japanese language and Japan as podcast search region by @na3shkw in #5211
- Autocomplete attributes on login and setup fields for password manager support by @meek2100 in #5089

### Fixed

- Recent episodes not updating from cache when media progress changes in #5159
- Error logging when a podcast's auto-download schedule has an invalid cron expression

### Changed

- Public media item shares: use start time passed in query parameter for existing sessions by @pjkottke in #5163
- Podcast episode downloads use SSRF filtering on the HTTP request (matches other external requests)
- Podcast create and update validate the auto-download schedule cron expression and sanitizes the HTML description
- Playlists, collections, and library item batch API routes enforce library and per-item access
- More strings translated
  - Belarusian by @pavel-miniutka
  - Hungarian by @ugyes
  - Japanese by @na3shkw

### Internal

- ApiCacheManager test coverage for recent-episodes cache invalidation

### New Contributors
* @pjkottke made their first contribution in https://github.com/advplyr/audiobookshelf/pull/5163
* @meek2100 made their first contribution in https://github.com/advplyr/audiobookshelf/pull/5089
* @na3shkw made their first contribution in https://github.com/advplyr/audiobookshelf/pull/5211

**Full Changelog**: https://github.com/advplyr/audiobookshelf/compare/v2.33.2...v2.34.0

[Full release notes](https://github.com/advplyr/audiobookshelf/releases/tag/v2.34.0)

## 2.33.2 (25-04-2026)

- Fix version to match actual upstream audiobookshelf release

### Upstream Audiobookshelf 2.33.2

#### Important: New authentication system was added in [v2.26.0](https://github.com/advplyr/audiobookshelf/releases/tag/v2.26.0). See https://github.com/advplyr/audiobookshelf/discussions/4460 for details.

### Fixed

- Matroska audiobooks (`.mka`) with the Opus codec failing to play in web client by @rktjmp in #5115
- UI/UX: Share player not using libraries cover aspect ratio setting
- Backup uploads leaving temporary files behind when the uploaded file failed validation
- Path traversal check on the filesystem path-exists endpoint not handling all edge cases

### Changed

- Bulk download endpoint now ensures all requested items belong to the library being requested
- Backup load and upload now validate the backup `details` entry exists and is within a reasonable size limit
- Podcast create endpoint validates that the podcast path is inside the selected library folder
- Author and library item cover image endpoints now clamp width/height query params to a maximum of 4096
- Podcast episode subtitles parsed from RSS feeds are now sanitized for HTML
- `author_updated`/`author_added` socket events emitted when updating authors in the book details edit modal by @mikiher in #5158
- `item_removed` socket event payload now includes `libraryId` so clients can ignore events for other libraries by @mikiher in #5160
- More strings translated
  - Belarusian by @pavel-miniutka
  - Bulgarian by @lembata
  - German by @JBlond @LaurinSorgend
  - Italian by @tizio04
  - Russian by @Hopelite @vmakeev
  - Spanish by @cyphra

### New Contributors
* @rktjmp made their first contribution in https://github.com/advplyr/audiobookshelf/pull/5115

**Full Changelog**: https://github.com/advplyr/audiobookshelf/compare/v2.33.1...v2.33.2

[Full release notes](https://github.com/advplyr/audiobookshelf/releases/tag/v2.33.2)

## 2.33.15 (20-04-2026)

- Move full documentation to DOCS.md (Documentation tab in HA)
- Slim README.md to essentials (Info tab)
- Include official Audiobookshelf docs: first launch, library setup, formats, directory structure
- Add guides: reverse proxy, OpenID Connect, troubleshooting, mobile apps

## 2.33.14 (20-04-2026)

- Fix query_logging schema: use str? instead of list() to avoid YAML boolean coercion of 'off'

## 2.33.13 (20-04-2026)

- Expose all Audiobookshelf environment variables as HA add-on options (22 total)
- New options: allow_iframe, max_failed_episode_checks, access_token_expiry, refresh_token_expiry, router_base_path, exp_proxy_support, use_x_accel, skip_binaries_check, query_logging, sqlite_cache_size, sqlite_mmap_size, sqlite_temp_store
- Add full README.md documentation for every option

## 2.33.12 (20-04-2026)

- Remove ingress proxy — Audiobookshelf Nuxt SPA is incompatible with HA ingress
- Direct Web UI access via "Open Web UI" button (opens in new tab)
- Revert to simple startup matching upstream docker image

## 2.33.11 (20-04-2026)

- Add Node.js ingress proxy for HA sidebar panel support (did not work)

## 2.33.10 (20-04-2026)

- Remove HA ingress (incompatible with Audiobookshelf Nuxt SPA absolute API paths)
- Expose port 8133 directly for web UI access
- Revert client file rewriting — use upstream default ROUTER_BASE_PATH=/audiobookshelf
- Access the UI at http://<HA-IP>:8133/audiobookshelf/
- Optionally add a sidebar panel via HA Settings → Dashboards → Add Panel (iframe)

## 2.33.9 (20-04-2026)

- Disable ingress_stream to fix buffering issues with Nuxt SPA

## 2.33.8 (19-04-2026)

- Fix ingress: rewrite client asset paths at build time to serve from /
- Set ROUTER_BASE_PATH=/ for HA ingress compatibility
- Remove ingress_entry, use default /

## 2.33.7 (19-04-2026)

- Fix ingress_entry: remove leading slash (was causing //audiobookshelf/)
- Change internal port from 80 to 8133 to avoid conflicts

## 2.33.6 (19-04-2026)

- Fix ingress UI: use ingress_entry=/audiobookshelf/ instead of ROUTER_BASE_PATH=/
- Keep upstream default ROUTER_BASE_PATH=/audiobookshelf for correct asset loading

## 2.33.5 (19-04-2026)

- Fix ingress: set ROUTER_BASE_PATH=/ so app serves from root
- Fix tini subreaper warning with -s flag

## 2.33.4 (19-04-2026)

- Fix startup: tini is at /sbin/tini, not /usr/bin/tini

## 2.33.3 (17-04-2026)

- Fix schema validation: remove space in int(10,300) type expression

## 2.33.2 (17-04-2026)

- Replace icon with high-resolution version (512x512)

### Upstream Audiobookshelf 2.33.2

#### Important: New authentication system was added in [v2.26.0](https://github.com/advplyr/audiobookshelf/releases/tag/v2.26.0). See https://github.com/advplyr/audiobookshelf/discussions/4460 for details.

### Fixed

- Matroska audiobooks (`.mka`) with the Opus codec failing to play in web client by @rktjmp in #5115
- UI/UX: Share player not using libraries cover aspect ratio setting
- Backup uploads leaving temporary files behind when the uploaded file failed validation
- Path traversal check on the filesystem path-exists endpoint not handling all edge cases

### Changed

- Bulk download endpoint now ensures all requested items belong to the library being requested
- Backup load and upload now validate the backup `details` entry exists and is within a reasonable size limit
- Podcast create endpoint validates that the podcast path is inside the selected library folder
- Author and library item cover image endpoints now clamp width/height query params to a maximum of 4096
- Podcast episode subtitles parsed from RSS feeds are now sanitized for HTML
- `author_updated`/`author_added` socket events emitted when updating authors in the book details edit modal by @mikiher in #5158
- `item_removed` socket event payload now includes `libraryId` so clients can ignore events for other libraries by @mikiher in #5160
- More strings translated
  - Belarusian by @pavel-miniutka
  - Bulgarian by @lembata
  - German by @JBlond @LaurinSorgend
  - Italian by @tizio04
  - Russian by @Hopelite @vmakeev
  - Spanish by @cyphra

### New Contributors
* @rktjmp made their first contribution in https://github.com/advplyr/audiobookshelf/pull/5115

**Full Changelog**: https://github.com/advplyr/audiobookshelf/compare/v2.33.1...v2.33.2

[Full release notes](https://github.com/advplyr/audiobookshelf/releases/tag/v2.33.2)

## 2.33.1 (17-04-2026)

- Initial release
- Based on Audiobookshelf v2.33.1
- Self-hosted audiobook and podcast server
- Web UI with HA ingress support (websocket enabled)
- Audiobook and podcast streaming with multi-user support
- Configurable media paths (audiobooks, podcasts)
- Supports all audio formats and ebooks (epub, pdf, cbr, cbz)
- Automatic library scanning
- Extended options: backup path, CORS, SSRF filter, rate limiting
- Custom environment variables support

### Upstream Audiobookshelf 2.33.1

#### Important: New authentication system was added in [v2.26.0](https://github.com/advplyr/audiobookshelf/releases/tag/v2.26.0). See https://github.com/advplyr/audiobookshelf/discussions/4460 for details.

### Fixed

- API Keys not respecting user enabled/disabled flag

### Changed

- Podcast episode update endpoint sanitizes HTML for subtitle
- Playlist & collection create/update endpoints strip HTML tags from name
- More strings translated
  - Belarusian by @pavel-miniutka
  - German by @fabianjuelich
  - Spanish by @cyphra

**Full Changelog**: https://github.com/advplyr/audiobookshelf/compare/v2.33.0...v2.33.1

[Full release notes](https://github.com/advplyr/audiobookshelf/releases/tag/v2.33.1)
