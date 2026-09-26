<!-- markdownlint-disable -->
<!-- Changelog entries mirror upstream release notes verbatim; upstream formatting is intentionally preserved, so style rules are disabled for this file. -->

## 1.6.2-ls366 (2026-09-26)

Updated to upstream Bazarr **1.6.2** (image `v1.6.2-ls366`):

From newest to oldest:
- Fixed cutoff logic to correctly consider non-HI subtitles when HI is excluded in language profile for both series and movies. #3607 [7448b2a](https://github.com/morpheus65535/bazarr/commit/7448b2a7dc1a289fdc3978b782f72ecb86f8a85e)
- Added clickable GitHub issue links to release notes by parsing #&lt;number&gt; patterns and converting them to hyperlinks [02bae52](https://github.com/morpheus65535/bazarr/commit/02bae52912867767e2b484e9408b6041d8d0450b)
- Fixed napiprojekt to use SSL [d30a659](https://github.com/morpheus65535/bazarr/commit/d30a659d87c28fed41736b8678e186802132b861)
- Added hash-only mode to napiprojekt provider. #3227 [3cd0600](https://github.com/morpheus65535/bazarr/commit/3cd06003e49719892a1df362fc77f4a421536933)
- Improved subssabbz by adding a fallback to folder/file title for non-ASCII titles and prevent empty query dumps [3f012cc](https://github.com/morpheus65535/bazarr/commit/3f012ccc23f63a8bb5baff3159b9e69afc68a8b3)
- Fixed duplicate history entries by using subquery with MIN to select single external subtitle path per episode/movie instead of joining all subtitle records. #3558 [a500741](https://github.com/morpheus65535/bazarr/commit/a500741bf2ff0d90300a3d53c224e13d7e74358b)
- Added distinct clause to history queries to prevent duplicate entries in episode and movie subtitle history API endpoints. #3558 [f7c9919](https://github.com/morpheus65535/bazarr/commit/f7c99196424e0c06466cab36f1c762f008fa78db)
- Added existence of subtitle in database before attempting deletion to prevent unauthorized file deletion [c76f583](https://github.com/morpheus65535/bazarr/commit/c76f5833d5c9c8ec462c593e9e0b961918cde209)
- Added anime provider tsukihime [#3597](https://github.com/morpheus65535/bazarr/pull/3597)
- Refactored post-processing to pass arguments as list instead of command string to prevent shell injection and fix Windows path handling. #3598 [2a9f0b3](https://github.com/morpheus65535/bazarr/commit/2a9f0b3d1d51a5979b68d3ae018aafa1c6739332)
- Refactored post-processing placeholder replacement to use dictionary-based lookup and single regex pattern [954b47b](https://github.com/morpheus65535/bazarr/commit/954b47b11648f7b1e4d6c3339168bb573a368b33)
- Added quality check parameters for subsync framerate-fix mode to prevent ruining correct subtitles by settings minimum score, max offset, and max framerate deviation. #3599 [bb380cf](https://github.com/morpheus65535/bazarr/commit/bb380cf9a5a097b9f701ca53144a09e187e3f845)
- Added additional URL parameters to the generic webhook call [58e8729](https://github.com/morpheus65535/bazarr/commit/58e8729f61315aba5bda1cc5b1a47478b7ffedd6)
- Fixed mass checkbox disabled for non srt formats [fc8ab88](https://github.com/morpheus65535/bazarr/commit/fc8ab886e35046bfbefd2b4400d2fdaad4b64883)

[Full release notes](https://github.com/morpheus65535/bazarr/releases/tag/v1.6.2)


## 1.6.1-ls365 (2026-09-23)

Upstream image rebuild (`v1.6.1-ls364` → `v1.6.1-ls365`) — packaging / base-image refresh, no application changes (Bazarr **1.6.1**).


## 1.6.1-ls364 (2026-09-15)

Updated to upstream Bazarr **1.6.1** (image `1.6.1-ls364`):

From newest to oldest:
- Improved Gestdown provider matching by adding year match when TVDb ID matches between video and subtitle source. [9013092](https://github.com/morpheus65535/bazarr/commit/9013092b5b0ceb74891f13532be595fc3d4ad0c1)
- Fixed track ID collision with changed attributes in embedded subtitles indexing. #3588 [ed0d47e](https://github.com/morpheus65535/bazarr/commit/ed0d47e24b809370d3469b0746d732ba1c6428de)
- Fixed syncing issue with Sonarr and Radarr on edge racing condition cases [ea22d7a](https://github.com/morpheus65535/bazarr/commit/ea22d7a216aeef84a379a6153409faaf179a4ade)
- Fixed AnimeTosho discarding distinct release associations that share the same attachment URL. #3582 [82119a8](https://github.com/morpheus65535/bazarr/commit/82119a84846080797aac27f37110090eea725991)
- Added SubsDump subtitles provider [b26e644](https://github.com/morpheus65535/bazarr/commit/b26e644e75afa2b74198b2f63eb7f47a8375dde6)
- Improved OpenSubtitles API query by refining IMDb matching logic to properly match year when imdb does. #3574 [93fd517](https://github.com/morpheus65535/bazarr/commit/93fd5172545944ecfe1b16090d5f6a944814cc27)
- Fixed Lingarr translation with blank subtitle lines [4feb61c](https://github.com/morpheus65535/bazarr/commit/4feb61c88f3f0f140948a4e82a1f7b16caccd808)
- Fixed embedded subtitles handling by refining language fallback logic by taking disposition into account. #3573 [8cf46f5](https://github.com/morpheus65535/bazarr/commit/8cf46f526dbbabc885f29fc72418fc1f22242695)
- Fixed animetosho forced subtitles [#3580](https://github.com/morpheus65535/bazarr/pull/3580)
- Fixed Titrari repetitive subtitle descriptions issue [b0c23e3](https://github.com/morpheus65535/bazarr/commit/b0c23e3ebddfc0d2ab84de3a9538efdf3ec4038d)
- Improved SubDL provider resilience and runtime controls [4c66b91](https://github.com/morpheus65535/bazarr/commit/4c66b91bf5211f14ffd0baa734f940c8d63f5c18)
- Fixed translation of an embedded track in a single extract-and-translate job [1e789ac](https://github.com/morpheus65535/bazarr/commit/1e789acc415822c57e56519990ae05ae76c389ac)
- Improved blacklisting of individual subtitles in a list of subtitles, if there's a parse error in save_subtitles in subliminal [9d853cf](https://github.com/morpheus65535/bazarr/commit/9d853cfd10c3dab5dd169bcb9ed68a664a6f0644)
- Fixed queries for history API and upgrading subtitles to prevent duplicate entries. #3558 [3be7984](https://github.com/morpheus65535/bazarr/commit/3be798431d3c97532badae7789b12c8b30fad5d7)
- Split settings into tabs and categories [#3559](https://github.com/morpheus65535/bazarr/pull/3559)
- Fixed LegendasNet search returning no results when name is incorrect despite a valid IMDb ID, and added RAR support. [49fc02e](https://github.com/morpheus65535/bazarr/commit/49fc02e28f5df15db58f6f151fc2e8a7ffb00355)
- Improved Jimaku provider matching by selecting entries with exact AniList ID and logging unmatched results. #3302 [63459f5](https://github.com/morpheus65535/bazarr/commit/63459f55ddda00fdf559bb46e80af6c2b149732d)
- Patched the `deep_translator` module to allow custom user-agent to be used with Google Translate. #3557 [bd87c39](https://github.com/morpheus65535/bazarr/commit/bd87c393558a16e29f507c21e0571134195dd623)
- Redesign language mappings settings [#3552](https://github.com/morpheus65535/bazarr/pull/3552)

*(…release notes truncated — follow the link below for the full list)*

[Full release notes](https://github.com/morpheus65535/bazarr/releases/tag/v1.6.1)

## 1.6.0-ls363 (2026-09-09)

Upstream image rebuild (`1.6.0-ls362` → `1.6.0-ls363`) — packaging / base-image refresh, no application changes (Bazarr **1.6.0**).

## 1.6.0-ls362 (2026-09-02)

Upstream image rebuild (`1.6.0-ls361` → `1.6.0-ls362`) — packaging / base-image refresh, no application changes (Bazarr **1.6.0**).

## 1.6.0-ls361 (2026-08-26)

Upstream image rebuild (`1.6.0-ls360` → `1.6.0-ls361`) — packaging / base-image refresh, no application changes (Bazarr **1.6.0**).

## 1.6.0-ls360 (2026-08-19)

Upstream image rebuild (`1.6.0-ls359` → `1.6.0-ls360`) — packaging / base-image refresh, no application changes (Bazarr **1.6.0**).

## 1.6.0-ls359 (2026-08-17)

Upstream image rebuild (`1.6.0-ls358` → `1.6.0-ls359`) — packaging / base-image refresh, no application changes (Bazarr **1.6.0**).

## 1.6.0-ls358 (2026-08-12)

Upstream image rebuild (`1.6.0-ls357` → `1.6.0-ls358`) — packaging / base-image refresh, no application changes (Bazarr **1.6.0**).

## 1.6.0-ls357 (2026-08-05)

Upstream image rebuild (`1.6.0-ls356` → `1.6.0-ls357`) — packaging / base-image refresh, no application changes (Bazarr **1.6.0**).

## 1.6.0-ls356 (2026-07-22)

Upstream image rebuild (`1.6.0-ls355` → `1.6.0-ls356`) — packaging / base-image refresh, no application changes (Bazarr **1.6.0**).

## 1.6.0-ls355 (2026-07-15)

Upstream image rebuild (`development-v1.6.0-ls800` → `1.6.0-ls355`) — packaging / base-image refresh, no application changes (Bazarr **1.6.0**).

## development-v1.6.0-ls800 (2026-07-08)

Upstream image rebuild (`1.6.0-ls354` → `development-v1.6.0-ls800`) — packaging / base-image refresh, no application changes (Bazarr **1.6.0**).

## 1.6.0-ls354 (2026-07-05)

Updated to upstream Bazarr **1.6.0** (image `1.6.0-ls354`):

From newest to oldest:
- Refactored `postprocessing` function to handle subprocess invocation differently on Windows and Unix, ensuring path safety and avoiding OS command injection. Added comprehensive unit tests for both platforms to ensure behavior correctness. #3413 [5dd736c](https://github.com/morpheus65535/bazarr/commit/5dd736c398a18e7584fc7fa9a35d76871f948d44)
- Fixed UNC path handling in `pp_replace` by replacing `re.sub` string substitutions with lambda functions to prevent escape sequence misinterpretation. #3413 [4217a9b](https://github.com/morpheus65535/bazarr/commit/4217a9b4b585ce73510eeb5cfb2b956e27c98c73)
- Refactored SubDL provider by simplifying retry logic and improving error handling for rate limits and 404 responses. [047b915](https://github.com/morpheus65535/bazarr/commit/047b915d9da44b1c658bd3ce6957937742f77afe)
- Removed RateLimiting mixin from TimeoutSession in subliminal_patch HTTP module since it was interfering with providers' custom rate-limiting implementations. [7343b1d](https://github.com/morpheus65535/bazarr/commit/7343b1d15a094649ce4602dd1cb131f539246730)
- Improved audio languages detection when the returned value is a string instead of a language object [e677246](https://github.com/morpheus65535/bazarr/commit/e677246e57b80e81823266226b95a754b2b22fc2)
- Fixed RegieLive.ro subtitle downloads, and added better error handling [3b8094f](https://github.com/morpheus65535/bazarr/commit/3b8094fce778e28da8858e2695ab5698d131e8e3)
- Removed Podnapisi provider and all associated files, settings, and dependencies across Bazarr since it is no longer online. [7d43815](https://github.com/morpheus65535/bazarr/commit/7d438153f20de85a8be899c8c1d7ae35b178e8c7)
- Refactored LegendasNet provider to centralize API response handling using `checked` method; improved error handling, added retry logic for invalid access tokens, and streamlined HTTP status code validation. #3263 [9959c99](https://github.com/morpheus65535/bazarr/commit/9959c99b9375247d00efbab3820a021ed01b5cf9)
- Enhanced error handling in Gestdown provider by adding specific handling for `JSONDecodeError` and `KeyError` in API responses. #3365 [7c52af1](https://github.com/morpheus65535/bazarr/commit/7c52af1114b3989f74a36d81ee3fc234ca72716e)
- Fixed embedded Chinese subtitle language detection [04bd7b6](https://github.com/morpheus65535/bazarr/commit/04bd7b6446308d47df64a9375722f0f384e4f581)
- Refactored SubDL provider to introduce centralized API response handling via `checked` method; improved exception handling, added GMT midnight limit reset logic, and adjusted retry mechanisms. #3398 [14250a3](https://github.com/morpheus65535/bazarr/commit/14250a336a5bc4ea6a2f340d71a83155a6c2c71a)
- Added Bayflix and Vladoon Bulgarian subtitles providers [f5c9ecb](https://github.com/morpheus65535/bazarr/commit/f5c9ecb0e0bab6b5a3f179662bf427069ae7b5e4)
- Added the ability to configure base config file path from an environment variable [3c3d410](https://github.com/morpheus65535/bazarr/commit/3c3d410f56114e0768d69036de36b535b816d025)
- Improved subf2m privider to fall back to IMDB id search when localized movie title finds nothing [17778f7](https://github.com/morpheus65535/bazarr/commit/17778f745bee1334a34b789fe999c5833f0283b5)
- Updated cookie field descriptions for AvistaZ and CinemaZ providers settings to clarify required input format. #2797 [d41d563](https://github.com/morpheus65535/bazarr/commit/d41d56309505747df71ad9bfd48e24058806d43f)

*(…release notes truncated — follow the link below for the full list)*

[Full release notes](https://github.com/morpheus65535/bazarr/releases/tag/v1.6.0)

## 1.5.6-ls353 (2026-07-01)

Upstream image rebuild (`1.5.6-ls352` → `1.5.6-ls353`) — packaging / base-image refresh, no application changes (Bazarr **1.5.6**).

## 1.5.6-ls352 (2026-06-24)

Upstream image rebuild (`1.5.6-ls351` → `1.5.6-ls352`) — packaging / base-image refresh, no application changes (Bazarr **1.5.6**).

## 1.5.6-ls351 (2026-06-17)

Upstream image rebuild (`1.5.6-ls350` → `1.5.6-ls351`) — packaging / base-image refresh, no application changes (Bazarr **1.5.6**).

## 1.5.6-ls350 (2026-06-03)

Upstream image rebuild (`1.5.6-ls349` → `1.5.6-ls350`) — packaging / base-image refresh, no application changes (Bazarr **1.5.6**).

## 1.5.6-ls349 (2026-05-24)

Upstream image rebuild (`1.5.6-ls348` → `1.5.6-ls349`) — packaging / base-image refresh, no application changes (Bazarr **1.5.6**).

## 1.5.6-ls348 (2026-05-13)

Upstream image rebuild (`1.5.6-ls347` → `1.5.6-ls348`) — packaging / base-image refresh, no application changes (Bazarr **1.5.6**).

## 1.5.6-ls347 (2026-05-12)

Upstream image rebuild (`1.5.6-ls346` → `1.5.6-ls347`) — packaging / base-image refresh, no application changes (Bazarr **1.5.6**).

## 1.5.6-ls346 (2026-05-01)

Upstream image rebuild (`1.5.6` → `1.5.6-ls346`) — packaging / base-image refresh, no application changes (Bazarr **1.5.6**).

## 1.5.6 (26-04-2026)

- Initial release based on Bazarr 1.5.6
- Uses linuxserver/docker-bazarr as base image
- HA ingress via sidebar (ingress_stream)
- SMB/CIFS network share mounting
- Local disk mounting (USB, SATA, NVMe)
- Custom environment variables
- AppArmor profile for permissions

### Upstream Bazarr 1.5.6

From newest to oldest:
- Improved error handling in `subdl` provider to log specific "no subtitles found" cases instead of raising exceptions when title is not found. #3218 [5dc1d27](https://github.com/morpheus65535/bazarr/commit/5dc1d278e1b459b8bcb388097d150074307cb9ae)
- Improved `Gestdown` provider release matching [721361a](https://github.com/morpheus65535/bazarr/commit/721361a3619658742bc5d72ada25f5e24af1bdaa)
- Added Spain vs LATAM Spanish detection to SubX provider [97ecde2](https://github.com/morpheus65535/bazarr/commit/97ecde2ec7164411dc59e4a2e9344f8c971f9037)
- Fixed missing audio_exclude migration in upgrade_languages_profile_values [63878a9](https://github.com/morpheus65535/bazarr/commit/63878a93d7c124227413bc21a4b183731b761b47)
- More efficient Windows codepage post processing fix (without spawning process) [df18cad](https://github.com/morpheus65535/bazarr/commit/df18cadbf5ac8a52fc213fa51d6d8380881aa216)
- Fix for post-processing failing on non-English Windows systems [a49de53](https://github.com/morpheus65535/bazarr/commit/a49de53760a10cc71680615298a9cdf233fb7670)
- Fixed `assrt` provider skipping season pack subtitles for episode searches [b3c798c](https://github.com/morpheus65535/bazarr/commit/b3c798c6698bec885eed0d238def7418d5167d4e)
- Fixed Assrt provider crash on empty filelist and CJK title matching failure [70bd5d5](https://github.com/morpheus65535/bazarr/commit/70bd5d54435c668080e997bf80f723461eb905d6)
- Added "hostname" in Settings-->General for webhook security and updated logic to enforce its configuration. This prevents hostname poisoning vulnerability potential exploitation. [4b0c5a3](https://github.com/morpheus65535/bazarr/commit/4b0c5a34c97bbbeadfa3219e562bd919f68fd5d6)
- Fixed `subssabbz` search, diacritics, language comparison, and download error handling [cbf1aa7](https://github.com/morpheus65535/bazarr/commit/cbf1aa756a2e14d0bdddb6ddaebc0f0dc4af47c9)
- Added missing `subx` API key integration into providers' configuration. [ae51617](https://github.com/morpheus65535/bazarr/commit/ae516172b2cb6771d0190ba906ffdb75219f7cbe)
- Added Plex library refresh calls for series and movies after subtitle deletions or modifications if Plex integration is enabled. [8d5990b](https://github.com/morpheus65535/bazarr/commit/8d5990b63578ae19abfc51ba9880be45cdea36fb)
- Added `event_stream` calls into subtitles upgrade process for both episodes and movies to make sure that history get refreshed on subtitle upgrade. [90f9558](https://github.com/morpheus65535/bazarr/commit/90f955801fe2f607f55da6a7ffb2099ac91e5b8f)
- Added audio delay detection in MKV headers for `WhisperAI` using FFprobe [2ad9825](https://github.com/morpheus65535/bazarr/commit/2ad982527039fda172ad0c25c1588090e7926846)
- Added support for "backup" event type in Socket.IO and integrated event stream in the backup process. #3166 [af34874](https://github.com/morpheus65535/bazarr/commit/af348742a87019f432dd9f60b0c592cf322b0a69)
- Standardized the initialization of the `matches` attribute across all subtitle providers by setting it as a `set()`. #3192 [f0190d5](https://github.com/morpheus65535/bazarr/commit/f0190d54a62df22a25d62a57fca8f6fad6f72be7)
- Added SubX subtitle proxy for Subdivx Latam Spanish provider [8e56e40](https://github.com/morpheus65535/bazarr/commit/8e56e40b8f020ecc48c21ae86406a7e436fb542c)
- Fixed `check_login` decorator functionality [1d4953c](https://github.com/morpheus65535/bazarr/commit/1d4953c9662852e39e255e603ddfc40f79fddfbd)

*(…release notes truncated — follow the link below for the full list)*

[Full release notes](https://github.com/morpheus65535/bazarr/releases/tag/v1.5.6)
