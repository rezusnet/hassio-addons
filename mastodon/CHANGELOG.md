<!-- markdownlint-disable -->
<!-- Changelog entries mirror upstream release notes verbatim; upstream formatting is intentionally preserved, so style rules are disabled for this file. -->

## 4.7.2-ls214 (2026-09-25)

Upstream image rebuild (`v4.7.2-ls213` → `v4.7.2-ls214`) — packaging / base-image refresh, no application changes (Mastodon **4.7.2**).


## 4.7.2-ls213 (2026-09-16)

Updated to upstream Mastodon **4.7.2** (image `4.7.2-ls213`):

<h1><picture>
  <source media="(prefers-color-scheme: dark)" srcset="./lib/assets/wordmark.dark.png?raw=true">
  <source media="(prefers-color-scheme: light)" srcset="./lib/assets/wordmark.light.png?raw=true">
  <img alt="Mastodon" src="./lib/assets/wordmark.light.png?raw=true" height="34">
</picture></h1>

### Changelog

### Security

- Temporarily disable HEIF support

### Fixes

- Fix relative privacy policy links in subscription emails (#40486 by @crafkaz)
- Fix canonical email blocks interfering with freezing or approving users (#40463 by @ClearlyClaire)
- Fix 500 error when trying to upload a non-custom-filter JSON import (#40449 and #40451 by @ClearlyClaire)
- Fix 500 error when submitting a status twice (#40439 by @ClearlyClaire)
- Fix self-deleted accounts not being un-deleted when using `tootctl accounts create --reattach` (#40430 by @mjankowski)
- Fix account deletion not deleting generated annual reports (#40394 by @ClearlyClaire)
- Fix notifications not being cleaned up when notification requests are deleted in bulk (#40393 by @ClearlyClaire)

### Upgrade notes

To get the code for v4.7.2, use `git fetch && git checkout v4.7.2`.

> [!NOTE]
> As always, make sure you have backups of the database before performing any upgrades. If you are using docker-compose, this is how a backup command might look: `docker exec mastodon_db_1 pg_dump -Fc -U postgres postgres > name_of_the_backup.dump`

### Dependencies

External dependencies have not changed since v4.6.0.

- Ruby: 3.3 or newer
- PostgreSQL: 14 or newer
- Elasticsearch (recommended, for full-text search): 7.x (OpenSearch should also work)
- LibreTranslate (optional, for translations): 1.3.3 or newer
- Redis: 7.0 or newer
- Node: 22 or newer
- libvips: 8.13 or newer
- FFMpeg: 5.1 or newer

### Update steps

The following instructions are for updating from 4.7.0.

If you are upgrading directly from an earlier release, please carefully read the upgrade notes for the skipped releases as well, as they often require extra steps such as database migrations. In particular, it is very important to read the [4.7.0 release notes](https://github.com/mastodon/mastodon/releases/tag/v4.7.0).

1. Restart all Mastodon processes

[Full release notes](https://github.com/mastodon/mastodon/releases/tag/v4.7.2)

## 4.7.1-ls212 (2026-09-04)

Upstream image rebuild (`4.7.1-ls211` → `4.7.1-ls212`) — packaging / base-image refresh, no application changes (Mastodon **4.7.1**).

## 4.7.1-ls211 (2026-09-02)

Updated to upstream Mastodon **4.7.1** (image `4.7.1-ls211`):

<h1><picture>
  <source media="(prefers-color-scheme: dark)" srcset="./lib/assets/wordmark.dark.png?raw=true">
  <source media="(prefers-color-scheme: light)" srcset="./lib/assets/wordmark.light.png?raw=true">
  <img alt="Mastodon" src="./lib/assets/wordmark.light.png?raw=true" height="34">
</picture></h1>

### Changelog

### Security

- Fix password authentication bypass in 2FA auth for LDAP/PAM/SSO accounts ([GHSA-vx32-x96w-qq65](https://github.com/mastodon/mastodon/security/advisories/GHSA-vx32-x96w-qq65))
- Fix Denial of Service when processing pathological JSON-LD activities ([GHSA-vgm8-frgh-rh2v](https://github.com/mastodon/mastodon/security/advisories/GHSA-vgm8-frgh-rh2v))
- Fix disabled staff accounts still having access to admin API ([GHSA-62j4-hvj7-px3f](https://github.com/mastodon/mastodon/security/advisories/GHSA-62j4-hvj7-px3f))

### Fixes

- Fix invited-without-approval-bypass not being asked for a textual reason (#40332 by @ClearlyClaire)
- Fix email blocks domain filter not being kept through pagination (#40254 by @ClearlyClaire)
- Fix `config/` directory missing from Bootsnap precompilation options in Dockerfile (#40255 by @ClearlyClaire)
- Fix some of 4.7 migrations not re-running cleanly when interrupted (#40264 by @ClearlyClaire)
- Fix account creation failing on `ActiveRecord::Encryption` configuration in `mastodon:setup` rake task (#40275 by @ClearlyClaire)

### Upgrade notes

To get the code for v4.7.1, use `git fetch && git checkout v4.7.1`.

> [!NOTE]
> As always, make sure you have backups of the database before performing any upgrades. If you are using docker-compose, this is how a backup command might look: `docker exec mastodon_db_1 pg_dump -Fc -U postgres postgres > name_of_the_backup.dump`

### Dependencies

External dependencies have not changed since v4.6.0.

- Ruby: 3.3 or newer
- PostgreSQL: 14 or newer
- Elasticsearch (recommended, for full-text search): 7.x (OpenSearch should also work)
- LibreTranslate (optional, for translations): 1.3.3 or newer
- Redis: 7.0 or newer
- Node: 22 or newer
- libvips: 8.13 or newer
- FFMpeg: 5.1 or newer

### Update steps

The following instructions are for updating from 4.7.0.

If you are upgrading directly from an earlier release, please carefully read the upgrade notes for the skipped releases as well, as they often require extra steps such as database migrations. In particular, it is very important to read the [4.7.0 release notes](https://github.com/mastodon/mastodon/releases/tag/v4.7.0).

### Non-Docker

> [!TIP]
> The `charlock_holmes` gem may fail to build on some systems with recent versions of gcc.
If you run into this issue, try `BUNDLE_BUILD__CHARLOCK_HOLMES="--with-cxxflags=-std=c++17" bundle install`.

1. Install dependencies with `bundle install`
2. Restart all Mastodon processes.

### When using Docker

1. Restart all Mastodon processes.

[Full release notes](https://github.com/mastodon/mastodon/releases/tag/v4.7.1)

## 4.7.0-ls210 (2026-08-28)

Upstream image rebuild (`4.7.0-ls209` → `4.7.0-ls210`) — packaging / base-image refresh, no application changes (Mastodon **4.7.0**).

## 4.7.0-ls209 (2026-08-21)

Updated to upstream Mastodon **4.7.0** (image `4.7.0-ls209`):

<h1><picture>
  <source media="(prefers-color-scheme: dark)" srcset="./lib/assets/wordmark.dark.png?raw=true">
  <source media="(prefers-color-scheme: light)" srcset="./lib/assets/wordmark.light.png?raw=true">
  <img alt="Mastodon" src="./lib/assets/wordmark.light.png?raw=true" height="34">
</picture></h1>

This version introduces very few user-facing changes but substantially reworks Mastodon's internals to increase security, support new protocols, and pave the way for new features. Updating to this version will be required for zero-downtime migration to the upcoming Mastodon 5.0.

### Upgrade overview

This release contains upgrade notes that deviate from the norm:

ℹ️ Requires assets recompilation\
ℹ️ Requires streaming server restart\
ℹ️ Requires unusually long database migrations

For more information, view the complete release notes and scroll down to the upgrade instructions section.

### Changelog

### Added

- Add audit logs for Hashtags (#39473, #39337 and #39670 by @arte7)
- Add search field to admin ip blocks (#39404 by @arte7)
- Add notifications for out-of-support versions of Mastodon (#39732 and #39734 by @ClearlyClaire)
- Add Elasticsearch request timeout of 10s (can be overridden through `ES_QUERY_TIMEOUT`) (#40064 by @ClearlyClaire)
- Add ActivityPub attributes to current span when processing Activities (#40041 by @jhbabon)
- Add OTel span attribute to deprecated endpoints (#40030 by @jhbabon)
- Add default permission check to admin area (#39974 by @oneiros)
- Add uniqueness constraint on Account `uri` (#39882, #39999 and #39861 by @ClearlyClaire)
- Add new theme tokens `bg-blend`, `bg-highlight`, and `border-strong` (#39786 by @diondiondion)
- Add support for `Link` objects in `attachment` (FEP-8967) (#36104, #39977 and #39983 by @Gargron, @TheEssem and @shleeable)
  - Mastodon will use the first `Link` attachment, if any, as preview card.
  - If there is no `Link` attachment, Mastodon will still scan the message content's to populate one. This may change in a later release.
  - Mastodon sets a `Link` attachment for outgoing posts with a preview card.
- Add support for remote accounts changing handles (#39785, #39850, #39865 and #40045 by @ClearlyClaire)
  - ActivityPub actor `id` is now used as the primary identifier, instead of webfinger handle.
  - Remote actors that change handles are now renamed instead of a duplicate account being created then the two merged.
  - Mastodon does not offer its users to change handles yet.
  - The concept of “invalid handles” has been added to handle some edge cases. An account with an invalid handle
    is an account for which the handle cannot be currently verified, but is otherwise valid.
    In the REST API, they have their `username` and `domain` attribute overridden and this is made explicit through the [`invalid_handle` attribute](https://docs.joinmastodon.org/entities/Account/#invalid_handle).
- Add outgoing RFC9421 HTTP Message Signatures as fallback to earlier draft (#39756 by @ClearlyClaire)
- Change how local users' keypairs are stored (#39658, #39668, #39662, #39684, #39686, #39690 and #40138 by @ClearlyClaire)
  - This moves local users' keypairs to the dedicated table that was created in 4.6.
  - Private keys are now encrypted at rest, and the new infrastructure will allow for key rotation in the future.
- Add support for `expires` in Linked Data Signatures and Object Integrity Proofs (#39701 by @ClearlyClaire)

*(…release notes truncated — follow the link below for the full list)*

[Full release notes](https://github.com/mastodon/mastodon/releases/tag/v4.7.0)

## 4.6.6-ls207 (2026-08-16)

Upstream image rebuild (`4.6.6-ls206` → `4.6.6-ls207`) — packaging / base-image refresh, no application changes (Mastodon **4.6.6**).

## 4.6.6-ls206 (2026-08-14)

Updated to upstream Mastodon **4.6.6** (image `4.6.6-ls206`):

<h1><picture>
  <source media="(prefers-color-scheme: dark)" srcset="./lib/assets/wordmark.dark.png?raw=true">
  <source media="(prefers-color-scheme: light)" srcset="./lib/assets/wordmark.light.png?raw=true">
  <img alt="Mastodon" src="./lib/assets/wordmark.light.png?raw=true" height="34">
</picture></h1>

### Upgrade overview

This release contains upgrade notes that deviate from the norm:

ℹ️ Requires assets recompilation

For more information, view the complete release notes and scroll down to the upgrade instructions section.

### Changelog

### Changed

- Change `mastodon:setup` task warning about trademark to match `masto` but ignore subdomains (#40143 by @ClearlyClaire)

### Fixed

- Fix connection errors when processing `fediverse:creator` preventing creation of preview cards (#40135 by @ClearlyClaire)
- Fix Web UI being inaccessible with URLs ending with `.zip` (#40134 by @ClearlyClaire)
- Fix semitransparent background of picture-in-picture video player (#40132 by @diondiondion)
- Fix title tooltip appearing for fullscreen videos (#40127 by @diondiondion)
- Fix image preview too dark in alt text editor dialog (#40126 by @diondiondion)
- Fix domain block impact queries being rejected (#40122 by @ClearlyClaire)
- Fix mobile navigation scrolling to top while opening (#40042 by @sharlayan)
- Fix selected account being lost when creating a collection (#39897 and #40133 by @diondiondion and @sharlayan)

### Upgrade notes

To get the code for v4.6.6, use `git fetch && git checkout v4.6.6`.

> [!NOTE]
> As always, make sure you have backups of the database before performing any upgrades. If you are using docker-compose, this is how a backup command might look: `docker exec mastodon_db_1 pg_dump -Fc -U postgres postgres > name_of_the_backup.dump`

### Dependencies

External dependencies have not changed since v4.6.0.

- Ruby: 3.3 or newer
- PostgreSQL: 14 or newer
- Elasticsearch (recommended, for full-text search): 7.x (OpenSearch should also work)
- LibreTranslate (optional, for translations): 1.3.3 or newer
- Redis: 7.0 or newer
- Node: 22 or newer
- libvips: 8.13 or newer
- FFMpeg: 5.1 or newer

### Update steps

The following instructions are for updating from 4.6.5.

If you are upgrading directly from an earlier release, please carefully read the upgrade notes for the skipped releases as well, as they often require extra steps such as database migrations. In particular, it is very important to read the [4.6.0 release notes](https://github.com/mastodon/mastodon/releases/tag/v4.6.0).

### Non-Docker

1. Precompile the assets: `RAILS_ENV=production bundle exec rails assets:precompile`
2. Restart all Mastodon processes.

### When using Docker

1. Restart all Mastodon processes.

[Full release notes](https://github.com/mastodon/mastodon/releases/tag/v4.6.6)

## 4.6.5-ls205 (2026-08-07)

Updated to upstream Mastodon **4.6.5** (image `4.6.5-ls205`):

<h1><picture>
  <source media="(prefers-color-scheme: dark)" srcset="./lib/assets/wordmark.dark.png?raw=true">
  <source media="(prefers-color-scheme: light)" srcset="./lib/assets/wordmark.light.png?raw=true">
  <img alt="Mastodon" src="./lib/assets/wordmark.light.png?raw=true" height="34">
</picture></h1>

### Upgrade overview

This release contains upgrade notes that deviate from the norm:

ℹ️ Requires assets recompilation

For more information, view the complete release notes and scroll down to the upgrade instructions section.

### Changelog

### Fixed

- Fix Collection items being rejected because of incorrect attribute being read (#40052 by @shleeable)
- Fix typo in embedded quote handling code (#40049 by @shleeable)
- Fix account merging worker incorrectly merging `Appeal` and `AccountWarning` records (#39982 by @shleeable)
- Fix off-by-one in handling of updated remote posts allowing up to 5 attachments (#39978 by @shleeable)
- Fix collection items limit not being consistently applied (#39969 by @oneiros)
- Fix oversized profile image crop uploads (#39958 by @sharlayan)
- Fix emoji autocomplete sometimes suggesting emojis for earlier keystrokes (#39947 by @ChaosExAnima)

### Upgrade notes

To get the code for v4.6.5, use `git fetch && git checkout v4.6.5`.

> [!NOTE]
> As always, make sure you have backups of the database before performing any upgrades. If you are using docker-compose, this is how a backup command might look: `docker exec mastodon_db_1 pg_dump -Fc -U postgres postgres > name_of_the_backup.dump`

### Dependencies

External dependencies have not changed since v4.6.0.

- Ruby: 3.3 or newer
- PostgreSQL: 14 or newer
- Elasticsearch (recommended, for full-text search): 7.x (OpenSearch should also work)
- LibreTranslate (optional, for translations): 1.3.3 or newer
- Redis: 7.0 or newer
- Node: 22 or newer
- libvips: 8.13 or newer
- FFMpeg: 5.1 or newer

### Update steps

The following instructions are for updating from 4.6.4.

If you are upgrading directly from an earlier release, please carefully read the upgrade notes for the skipped releases as well, as they often require extra steps such as database migrations. In particular, it is very important to read the [4.6.0 release notes](https://github.com/mastodon/mastodon/releases/tag/v4.6.0).

### Non-Docker

1. Precompile the assets: `RAILS_ENV=production bundle exec rails assets:precompile`
2. Restart all Mastodon processes.

### When using Docker

1. Restart all Mastodon processes.

[Full release notes](https://github.com/mastodon/mastodon/releases/tag/v4.6.5)

## 4.6.4-ls204 (2026-07-31)

Upstream image rebuild (`4.6.4-ls203` → `4.6.4-ls204`) — packaging / base-image refresh, no application changes (Mastodon **4.6.4**).

## 4.6.4-ls203 (2026-07-28)

Updated to upstream Mastodon **4.6.4** (image `4.6.4-ls203`):

<h1><picture>
  <source media="(prefers-color-scheme: dark)" srcset="./lib/assets/wordmark.dark.png?raw=true">
  <source media="(prefers-color-scheme: light)" srcset="./lib/assets/wordmark.light.png?raw=true">
  <img alt="Mastodon" src="./lib/assets/wordmark.light.png?raw=true" height="34">
</picture></h1>

### Upgrade overview

This release contains upgrade notes that deviate from the norm:

ℹ️ Requires assets recompilation

For more information, view the complete release notes and scroll down to the upgrade instructions section.

### Changelog

### Security

- Fix incorrect permission enforcement ([GHSA-7jvv-fhmg-wpfw](https://github.com/mastodon/mastodon/security/advisories/GHSA-7jvv-fhmg-wpfw), [GHSA-hx34-2pfw-2qfj](https://github.com/mastodon/mastodon/security/advisories/GHSA-hx34-2pfw-2qfj))
- Fix SSRF protection bypass via IPv4-compatible IPv6 addresses ([GHSA-vwhj-3g83-v276](https://github.com/mastodon/mastodon/security/advisories/GHSA-vwhj-3g83-v276))
- Update dependencies

### Changed

- Change autosuggestions to include second word in web UI (#39622 and #39696 by @Gargron and @zunda)

### Fixed

- Fix being unable to vote in polls without an expiration date (#39949 by @ClearlyClaire)
- Fix performance of user-focused queries in admin dashboard (#39929 by @ClearlyClaire)
- Fix Web Push subscription deletion endpoint incorrectly expecting anti-CSRF tokens (#39918 by @ClearlyClaire)
- Fix `ActivityPub::Activity::Create` trying to re-create known statuses when author changes (#39916 by @ClearlyClaire)
- Fix typo in quotes list error handling (#39904 by @shleeable)
- Fix lax relevancy check in inbound activity processing (#39892 by @ClearlyClaire)
- Fix `Account::Merging` concern not supporting Quotes or Collections, refactor it (#39884 by @ClearlyClaire)
- Fix various emoji search issues (#39815 by @ChaosExAnima)
- Fix swapped order of "accept/reject" actions in follow requests (#39862 by @diondiondion)
- Fix suspended accounts not being removed from follow request count in `/api/v1/accounts/verify_credentials` (#39858 by @ClearlyClaire)
- Fix "Learn more" link target in column post privacy hint (#39829 by @diondiondion)
- Fix page refresh when trying to save custom profile fields (#39828 by @diondiondion)
- Fix followed tags not being properly cleaned up when an account is deleted (#39824 by @shleeable)
- Fix CW being copied to body when editing quote posts with empty text (#39823 and #39837 by @shleeable and @ClearlyClaire)
- Fix handling of `QuoteRequest` rejections when those can't be found by `id` (#39820 by @shleeable)
- Fix autofollow option being ignored in invite moderation interface (#39819 by @shleeable)
- Fix pagination overlapping announcement reactions bar (#39814 by @diondiondion)
- Fix very wide images overflowing posts horizontally (#39812 by @diondiondion)
- Fix collections not being removed when an account is deleted (#39809 by @oneiros)
- Fix account followed languages selector (#39801 by @ChaosExAnima)
- Fix error handling in `ActivityPub::ProcessFeaturedItemService` (#39787 by @ClearlyClaire)
- Fix display of past relative times (#39742 by @ClearlyClaire)
- Fix pinned post button width (#39724 by @ChaosExAnima)

### Upgrade notes

To get the code for v4.6.4, use `git fetch && git checkout v4.6.4`.

*(…release notes truncated — follow the link below for the full list)*

[Full release notes](https://github.com/mastodon/mastodon/releases/tag/v4.6.4)

## 4.6.3-ls202 (2026-07-24)

Upstream image rebuild (`4.6.3-ls201` → `4.6.3-ls202`) — packaging / base-image refresh, no application changes (Mastodon **4.6.3**).

## 4.6.3-ls201 (2026-07-16)

Upstream image rebuild (`glitch-v4.6.3-ls340` → `4.6.3-ls201`) — packaging / base-image refresh, no application changes (Mastodon **4.6.3**).

## glitch-v4.6.3-ls340 (2026-07-15)

Upstream image rebuild (`4.6.3-ls200` → `glitch-v4.6.3-ls340`) — packaging / base-image refresh, no application changes (Mastodon **4.6.3**).

## 4.6.3-ls200 (2026-07-04)

Updated to upstream Mastodon **4.6.3** (image `4.6.3-ls200`):

<h1><picture>
  <source media="(prefers-color-scheme: dark)" srcset="./lib/assets/wordmark.dark.png?raw=true">
  <source media="(prefers-color-scheme: light)" srcset="./lib/assets/wordmark.light.png?raw=true">
  <img alt="Mastodon" src="./lib/assets/wordmark.light.png?raw=true" height="34">
</picture></h1>

### Upgrade overview

This release contains upgrade notes that deviate from the norm:

ℹ️ Requires assets recompilation

For more information, view the complete release notes and scroll down to the upgrade instructions section.

### Changelog

### Security

- Update dependencies

### Added

- Add “Update available” navigation item at top of navbar when new Mastodon versions are available (#39705 by @ClearlyClaire)
- Add rendering of post images in emails (#39636 by @diondiondion)

### Fixed

- Fix “view collection” menu item appearing on collection page (#39694 by @mkljczk)
- Fix incorrect filter cache key sometimes causing incorrect filters to be applied (#39698 by @ClearlyClaire)
- Fix missing `to_json` to publish announcement reaction worker (#39685 by @mjankowski)
- Fix duplicate "clear" button shown in main search input in Chrome (#39679 by @diondiondion)
- Fix visual glitch with the spoiler button (#39677 by @ChaosExAnima)
- Fix invisible username during post highlight animation (#39659 by @diondiondion)
- Fix follow button floating on profiles when overview landing page is enabled (#39650 by @FFederi)
- Fix encryption warning "read more" link (#39635 by @thomas-pike)
- Fix `tootctl media lookup` failing on some setups (#39615 by @brookmiles)
- Fix visible transparent navigation link borders in Windows forced-contrast mode (#39614 by @diondiondion)
- Fix crash with some browser extensions injecting custom elements in the page (#39507 by @OriginalRoOhi)

### Upgrade notes

To get the code for v4.6.3, use `git fetch && git checkout v4.6.3`.

> [!NOTE]
> As always, make sure you have backups of the database before performing any upgrades. If you are using docker-compose, this is how a backup command might look: `docker exec mastodon_db_1 pg_dump -Fc -U postgres postgres > name_of_the_backup.dump`

### Dependencies

External dependencies have not changed since v4.6.0.

- Ruby: 3.3 or newer
- PostgreSQL: 14 or newer
- Elasticsearch (recommended, for full-text search): 7.x (OpenSearch should also work)
- LibreTranslate (optional, for translations): 1.3.3 or newer
- Redis: 7.0 or newer
- Node: 22 or newer
- libvips: 8.13 or newer
- FFMpeg: 5.1 or newer

### Update steps

The following instructions are for updating from 4.6.2.


If you are upgrading directly from an earlier release, please carefully read the upgrade notes for the skipped releases as well, as they often require extra steps such as database migrations. In particular, it is very important to read the [4.6.0 release notes](https://github.com/mastodon/mastodon/releases/tag/v4.6.0).

### Non-Docker

> [!TIP]
> The `charlock_holmes` gem may fail to build on some systems with recent versions of gcc.
If you run into this issue, try `BUNDLE_BUILD__CHARLOCK_HOLMES="--with-cxxflags=-std=c++17" bundle install`.

1. Install dependencies with `bundle install` and `yarn install --immutable`
2. Precompile the assets: `RAILS_ENV=production bundle exec rails assets:precompile`
3. Restart all Mastodon processes.

### When using Docker

1. Restart all Mastodon processes.

[Full release notes](https://github.com/mastodon/mastodon/releases/tag/v4.6.3)

## 4.6.2-ls199 (2026-07-03)

Upstream image rebuild (`4.6.2-ls198` → `4.6.2-ls199`) — packaging / base-image refresh, no application changes (Mastodon **4.6.2**).

## 4.6.2-ls198 (2026-06-26)

Updated to upstream Mastodon **4.6.2** (image `4.6.2-ls198`):

<h1><picture>
  <source media="(prefers-color-scheme: dark)" srcset="./lib/assets/wordmark.dark.png?raw=true">
  <source media="(prefers-color-scheme: light)" srcset="./lib/assets/wordmark.light.png?raw=true">
  <img alt="Mastodon" src="./lib/assets/wordmark.light.png?raw=true" height="34">
</picture></h1>

This release is made solely to update FFmpeg in our docker container images to fix [CVE-2026-8461](https://github.com/advisories/GHSA-qff7-4q6c-m8h6) (critical severity). It is critical to update if you use our docker container images.

If you are not using our docker container images, please make sure your system FFmpeg is updated to a fixed version, that is, 8.1.2, 7.1.5, 6.1.6, or 5.1.10.

For the recently released v4.6.1, see  [4.6.1 release notes](https://github.com/mastodon/mastodon/releases/tag/v4.6.1) for information.

### Changelog

### Security

- Update FFMpeg version used in the container image to fix [CVE-2026-8461](https://github.com/advisories/GHSA-qff7-4q6c-m8h6) (critical severity)

### Upgrade notes

To get the code for v4.6.2, use `git fetch && git checkout v4.6.2`.

> [!NOTE]
> As always, make sure you have backups of the database before performing any upgrades. If you are using docker-compose, this is how a backup command might look: `docker exec mastodon_db_1 pg_dump -Fc -U postgres postgres > name_of_the_backup.dump`

### Dependencies

External dependencies have not changed since v4.6.0.

- Ruby: 3.3 or newer
- PostgreSQL: 14 or newer
- Elasticsearch (recommended, for full-text search): 7.x (OpenSearch should also work)
- LibreTranslate (optional, for translations): 1.3.3 or newer
- Redis: 7.0 or newer
- Node: 22 or newer
- libvips: 8.13 or newer
- FFMpeg: 5.1 or newer

### Update steps

The following instructions are for updating from 4.6.1.

If you are upgrading directly from an earlier release, please carefully read the upgrade notes for the skipped releases as well, as they often require extra steps such as database migrations. In particular, it is very important to read the [4.6.0 release notes](https://github.com/mastodon/mastodon/releases/tag/v4.6.0).

1. Restart all Mastodon processes.

[Full release notes](https://github.com/mastodon/mastodon/releases/tag/v4.6.2)

## 4.6.1-ls198 (2026-06-25)

Updated to upstream Mastodon **4.6.1** (image `4.6.1-ls198`):

<h1><picture>
  <source media="(prefers-color-scheme: dark)" srcset="./lib/assets/wordmark.dark.png?raw=true">
  <source media="(prefers-color-scheme: light)" srcset="./lib/assets/wordmark.light.png?raw=true">
  <img alt="Mastodon" src="./lib/assets/wordmark.light.png?raw=true" height="34">
</picture></h1>

This is a patch release for 4.6.

Check out the [4.6.0 release notes](https://github.com/mastodon/mastodon/releases/tag/v4.6.0) for information.

### Upgrade overview

This release contains upgrade notes that deviate from the norm:

ℹ️ Requires assets recompilation

For more information, view the complete release notes and scroll down to the upgrade instructions section.

### Changelog

### Security

- Update dependencies

### Added

- Add `avatar_description` and `header_description` to `/api/v1/accounts/update_credentials` (#39547 and #39574 by @ClearlyClaire and @mkljczk)
  - This is available starting from Mastodon API version `11` and intended to provide an easier implementation path for clients implementing a similar feature in forks.
  - The new `/api/v1/profile` API remains the recommended API for setting avatar and header description as well as other profile values.

### Fixed

- Fix combobox menu not closing after a selection (#39595 by @diondiondion)
- Fix Emoji IndexedDB upgrades when multiple tabs are open (#39576 by @ChaosExAnima)
- Fix combobox listbox not scrolling up when new suggestions have loaded (#39588 by @diondiondion)
- Fix media modal navigation in RTL languages (#39587 by @diondiondion)
- Fix accounts not visible in collection editor in advanced web interface (#39586 by @diondiondion)
- Fix error on login with certain LDAP configurations (#39571 by @oneiros)
- Fix simplified layout applying to other pages in web UI (#39570 by @Gargron)
- Fix emoji database loading in web worker (#39558 and #39562 by @ChaosExAnima)
- Fix display name length limit being incorrectly enforced in web UI (#39499 by @shleeable)
- Fix advanced UI columns not using mobile styles (#39528 by @diondiondion)
- Fix "private mention" post heading overlapping thread line (#39521 and #39554 by @diondiondion)
- Fix misattribution of remote featured collections in some cases (#39523, #39525, and #39550 by @oneiros)
- Fix custom profile field overflow (#39513 by @diondiondion)
- Fix fetching unknown key when it's not the actor's first, and add error handling for unavailable keys (#39512 by @ClearlyClaire)

### Upgrade notes

To get the code for v4.6.1, use `git fetch && git checkout v4.6.1`.

> [!NOTE]
> As always, make sure you have backups of the database before performing any upgrades. If you are using docker-compose, this is how a backup command might look: `docker exec mastodon_db_1 pg_dump -Fc -U postgres postgres > name_of_the_backup.dump`

### Dependencies

External dependencies have not changed since v4.6.0.

- Ruby: 3.3 or newer
- PostgreSQL: 14 or newer
- Elasticsearch (recommended, for full-text search): 7.x (OpenSearch should also work)
- LibreTranslate (optional, for translations): 1.3.3 or newer
- Redis: 7.0 or newer
- Node: 22 or newer
- libvips: 8.13 or newer
- FFMpeg: 5.1 or newer

### ImageMagick removal and libvips replacement

ImageMagick has been deprecated since Mastodon 4.4.0 and is now unsupported. If you used `MASTODON_USE_LIBVIPS=false`, this will be ignored and you will need to install `libvips`.

### Theming system changes

*(…release notes truncated — follow the link below for the full list)*

[Full release notes](https://github.com/mastodon/mastodon/releases/tag/v4.6.1)

## 4.6.0-ls197 (2026-06-18)

Updated to upstream Mastodon **4.6.0** (image `4.6.0-ls197`):

<h1><picture>
  <source media="(prefers-color-scheme: dark)" srcset="./lib/assets/wordmark.dark.png?raw=true">
  <source media="(prefers-color-scheme: light)" srcset="./lib/assets/wordmark.light.png?raw=true">
  <img alt="Mastodon" src="./lib/assets/wordmark.light.png?raw=true" height="34">
</picture></h1>

For a user-focused highlight of these changes, see https://blog.joinmastodon.org/2026/06/mastodon-4.6/
For changes of particular interest to application developers, see https://blog.joinmastodon.org/2026/06/mastodon-4-6-for-devs/
For a more detailed run-down on the changes, see the Changelog section below!

### Upgrade overview

> [!TIP]
> A [hotfix release](https://github.com/mastodon/mastodon/releases/tag/v4.6.1) is available for this branch, please update directly to it or a later version, while following the instructions below.

This release contains upgrade notes that deviate from the norm:

:warning: The minimum supported version for Ruby has been bumped to 3.3\
:warning: The minimum supported version for Node.JS has been bumped to 22\
:warning: The minimum supported version for FFMpeg has been bumped to 5.1\
:warning: ImageMagick support has been dropped, libvips is required\
:warning: Custom themes need to be updated\
ℹ️ Requires assets recompilation\
ℹ️ Requires streaming server restart\
ℹ️ Requires database migrations

For more information, view the complete release notes and scroll down to the upgrade instructions section.

### Changelog

### Added

- **Add collections** (#37992, #37005, #37049, #37020, #37053, #37110, #37117, #37122, #37154, #37157, #37176, #37192, #37222, #37225, #37254, #37277, #37298, #37322, #37434, #37468, #37514, #37512, #37549, #37556, #37560, #37580, #37591, #37552, #37618, #37643, #37658, #37731, #37678, #37741, #37762, #37790, #37805, #37823, #37837, #37842, #37850, #37848, #37812, #37950, #37898, #37916, #37920, #37927, #37928, #37961, #37967, #37974, #37989, #37986, #38004, #38026, #38027, #38030, #38038, #38065, #38081, #38082, #38096, #38106, #38113, #38124, #38133, #38144, #38153, #38166, #38167, #38169, #38170, #38177, #38193, #38213, #38251, #38255, #38256, #38282, #38298, #38292, #38307, #38306, #38316, #38115, #38329, #38334, #38337, #38351, #38368, #38370, #38356, #38383, #38386, #38385, #38394, #38393, #38399, #38402, #38409, #38414, #38413, #38424, #38425, #38450, #38508, #38528, #38534, #38536, #38540, #38543, #38491, #38586, #38611, #38588, #38612, #38628, #38626, #38630, #38633, #38629, #38638, #38645, #38644, #38636, #38660, #38657, #38688, #38690, #38672, #38698, #38697, #38708, #38712, #38713, #38709, #38719, #38728, #38730, #38732, #38739, #38749, #38751, #38750, #38767, #38769, #38783, #38785, #38959, #38786, #38794, #38776, #38817, #38792, #38822, #38827, #38831, #38830, #38844, #38843, #38852, #38850, #38847, #38865, #38897, #38900, #38919, #38933, #38934, #38935, #38942, #38941, #38954, #38961, #38957, #38962, #38991, #39009, #39062, #39029, #39069, #39020, #39073, #39082, #39096, #39080, #39182, #39143, #39127, #37929, #38029, #39194, #39198, #39210, #39211, #39202, #39214, #39215, #39220, #39234, #39260, #39251, #39361, #39357, #39349, #39287, #39376, #39289, #39342, #38711, #39379, #39282, #39286, #39296, #39047, #39346, #39373, #39372, #39429, and #39457 by @ChaosExAnima, @ClearlyClaire, @Gargron, @arte7, @diondiondion, @mjankowski, @oneiros, and @shleeable)

*(…release notes truncated — follow the link below for the full list)*

[Full release notes](https://github.com/mastodon/mastodon/releases/tag/v4.6.0)

## 4.5.11-ls196 (2026-06-12)

Upstream image rebuild (`4.5.11-ls195` → `4.5.11-ls196`) — packaging / base-image refresh, no application changes (Mastodon **4.5.11**).

## 4.5.11-ls195 (2026-06-04)

Updated to upstream Mastodon **4.5.11** (image `4.5.11-ls195`):

<h1><picture>
  <source media="(prefers-color-scheme: dark)" srcset="./lib/assets/wordmark.dark.png?raw=true">
  <source media="(prefers-color-scheme: light)" srcset="./lib/assets/wordmark.light.png?raw=true">
  <img alt="Mastodon" src="./lib/assets/wordmark.light.png?raw=true" height="34">
</picture></h1>

### Changelog

### Security

- Fix allowed attribution domains spoofing ([GHSA-rwcw-vq68-g34p](https://github.com/mastodon/mastodon/security/advisories/GHSA-rwcw-vq68-g34p))
- Fix uncaught exception in message sanitization causing Denial of Service ([GHSA-qrgq-9fx2-vf2r](https://github.com/mastodon/mastodon/security/advisories/GHSA-qrgq-9fx2-vf2r))
- Update dependencies

### Fixed

- Fix remote statuses with large media descriptions being rejected (#39135 by @ClearlyClaire)

### Upgrade notes

To get the code for v4.5.11, use `git fetch && git checkout v4.5.11`.

> [!NOTE]
> As always, make sure you have backups of the database before performing any upgrades. If you are using docker-compose, this is how a backup command might look: `docker exec mastodon_db_1 pg_dump -Fc -U postgres postgres > name_of_the_backup.dump`

### Dependencies

External dependencies have not changed since v4.5.0.

- Ruby: 3.2 or newer
- PostgreSQL: 14 or newer
- Elasticsearch (recommended, for full-text search): 7.x (OpenSearch should also work)
- LibreTranslate (optional, for translations): 1.3.3 or newer
- Redis: 7.0 or newer
- Node: 20.19 or newer
- libvips (optional, instead of ImageMagick): 8.13 or newer
- ImageMagick (optional if using libvips): 6.9.7-7 or newer

### Update steps

The following instructions are for updating from 4.5.10.

If you are upgrading directly from an earlier release, please carefully read the upgrade notes for the skipped releases as well, as they often require extra steps such as database migrations. In particular, it is very important to read the [4.5.0 release notes](https://github.com/mastodon/mastodon/releases/tag/v4.5.0).

### Non-Docker

> [!TIP]
> The `charlock_holmes` gem may fail to build on some systems with recent versions of gcc.
If you run into this issue, try `BUNDLE_BUILD__CHARLOCK_HOLMES="--with-cxxflags=-std=c++17" bundle install`.

1. Install dependencies with `bundle install`
2. Restart all Mastodon processes.

### When using Docker

1. Restart all Mastodon processes.

[Full release notes](https://github.com/mastodon/mastodon/releases/tag/v4.5.11)

## 4.5.10-ls194 (2026-05-29)

Upstream image rebuild (`4.5.10-ls193` → `4.5.10-ls194`) — packaging / base-image refresh, no application changes (Mastodon **4.5.10**).

## 4.5.10-ls193 (2026-05-24)

Updated to upstream Mastodon **4.5.10** (image `4.5.10-ls193`):

<h1><picture>
  <source media="(prefers-color-scheme: dark)" srcset="./lib/assets/wordmark.dark.png?raw=true">
  <source media="(prefers-color-scheme: light)" srcset="./lib/assets/wordmark.light.png?raw=true">
  <img alt="Mastodon" src="./lib/assets/wordmark.light.png?raw=true" height="34">
</picture></h1>

### Upgrade overview

This release contains upgrade notes that deviate from the norm:

ℹ️ Requires assets recompilation

For more information, view the complete release notes and scroll down to the upgrade instructions section.

### Changelog

### Security

- Fix SSRF protection bypass ([GHSA-crr4-7rm4-8gpw](https://github.com/mastodon/mastodon/security/advisories/GHSA-crr4-7rm4-8gpw), [GHSA-xx55-4rrg-8xg6](https://github.com/mastodon/mastodon/security/advisories/GHSA-xx55-4rrg-8xg6))
- Fix Linked-Data Signature bypass through JSON-LD graph restructuring features ([GHSA-53m7-2wrh-q839](https://github.com/mastodon/mastodon/security/advisories/GHSA-53m7-2wrh-q839), [GHSA-chgx-jx3p-rf73](https://github.com/mastodon/mastodon/security/advisories/GHSA-chgx-jx3p-rf73))
- Updated dependencies

### Fixed

- Fix type of `interactingObject`, `interactionTarget` and add missing `QuoteAuthorization` (#38940 by @ClearlyClaire)

### Removed

- Remove unused devise strategies (#38795 by @ClearlyClaire)

### Upgrade notes

To get the code for v4.5.10, use `git fetch && git checkout v4.5.10`.

> [!NOTE]
> As always, make sure you have backups of the database before performing any upgrades. If you are using docker-compose, this is how a backup command might look: `docker exec mastodon_db_1 pg_dump -Fc -U postgres postgres > name_of_the_backup.dump`

### Dependencies

External dependencies have not changed since v4.5.0.

- Ruby: 3.2 or newer
- PostgreSQL: 14 or newer
- Elasticsearch (recommended, for full-text search): 7.x (OpenSearch should also work)
- LibreTranslate (optional, for translations): 1.3.3 or newer
- Redis: 7.0 or newer
- Node: 20.19 or newer
- libvips (optional, instead of ImageMagick): 8.13 or newer
- ImageMagick (optional if using libvips): 6.9.7-7 or newer

### Update steps

The following instructions are for updating from 4.5.9.

If you are upgrading directly from an earlier release, please carefully read the upgrade notes for the skipped releases as well, as they often require extra steps such as database migrations. In particular, it is very important to read the [4.5.0 release notes](https://github.com/mastodon/mastodon/releases/tag/v4.5.0).

### Non-Docker

> [!TIP]
> The `charlock_holmes` gem may fail to build on some systems with recent versions of gcc.
If you run into this issue, try `BUNDLE_BUILD__CHARLOCK_HOLMES="--with-cxxflags=-std=c++17" bundle install`.

1. Install dependencies with `bundle install` and `yarn install --immutable`
2. Precompile the assets: `RAILS_ENV=production bundle exec rails assets:precompile`
3. Restart all Mastodon processes.

### When using Docker

1. Restart all Mastodon processes.

[Full release notes](https://github.com/mastodon/mastodon/releases/tag/v4.5.10)

## 4.5.9-ls192 (2026-05-19)

Upstream image rebuild (`4.5.9-ls191` → `4.5.9-ls192`) — packaging / base-image refresh, no application changes (Mastodon **4.5.9**).

## 4.5.9-ls191 (2026-05-12)

Upstream image rebuild (`4.5.9` → `4.5.9-ls191`) — packaging / base-image refresh, no application changes (Mastodon **4.5.9**).

## 4.5.9 (02-05-2026)

- Initial release based on linuxserver/docker-mastodon v4.5.9
- HA ingress support via nginx HTTP (port 80)
- Auto-generation and persistence of SECRET_KEY_BASE, OTP_SECRET, VAPID keys, and Active Record encryption keys
- External PostgreSQL and Redis required
- SMTP email configuration
- HTTPS nginx redirect disabled for ingress compatibility
- Elasticsearch support optional (ES_ENABLED toggle)
- Port 443 exposed for direct/federation access

### Upstream Mastodon 4.5.9

<h1><picture>
  <source media="(prefers-color-scheme: dark)" srcset="./lib/assets/wordmark.dark.png?raw=true">
  <source media="(prefers-color-scheme: light)" srcset="./lib/assets/wordmark.light.png?raw=true">
  <img alt="Mastodon" src="./lib/assets/wordmark.light.png?raw=true" height="34">
</picture></h1>

### Upgrade overview

This release contains upgrade notes that deviate from the norm:

ℹ️ Requires assets recompilation

For more information, view the complete release notes and scroll down to the upgrade instructions section.

### Changelog

### Security

- Insufficient verification of email addresses ([GHSA-5r37-qpwq-2jhh](https://github.com/mastodon/mastodon/security/advisories/GHSA-5r37-qpwq-2jhh))
- Updated dependencies

### Added

- Add trademark warning to `mastodon:setup` task (#38548 by @ClearlyClaire)

### Fixed

- Fix definition for `quote` in JSON-LD context (#38686 by @ClearlyClaire)
- Fix being unable to disable sound for quote update notification (#38537 by @ClearlyClaire)
- Fix being able to quote someone you blocked (#38608 by @ClearlyClaire)

### Upgrade notes

To get the code for v4.5.9, use `git fetch && git checkout v4.5.9`.

> [!NOTE]
> As always, make sure you have backups of the database before performing any upgrades. If you are using docker-compose, this is how a backup command might look: `docker exec mastodon_db_1 pg_dump -Fc -U postgres postgres > name_of_the_backup.dump`

### Dependencies

External dependencies have not changed since v4.5.0.

- Ruby: 3.2 or newer
- PostgreSQL: 14 or newer
- Elasticsearch (recommended, for full-text search): 7.x (OpenSearch should also work)
- LibreTranslate (optional, for translations): 1.3.3 or newer
- Redis: 7.0 or newer
- Node: 20.19 or newer
- libvips (optional, instead of ImageMagick): 8.13 or newer
- ImageMagick (optional if using libvips): 6.9.7-7 or newer

### Update steps

The following instructions are for updating from 4.5.8.

If you are upgrading directly from an earlier release, please carefully read the upgrade notes for the skipped releases as well, as they often require extra steps such as database migrations. In particular, it is very important to read the [4.5.0 release notes](https://github.com/mastodon/mastodon/releases/tag/v4.5.0).

### Non-Docker

> [!TIP]
> The `charlock_holmes` gem may fail to build on some systems with recent versions of gcc.
If you run into this issue, try `BUNDLE_BUILD__CHARLOCK_HOLMES="--with-cxxflags=-std=c++17" bundle install`.

1. Install dependencies with `bundle install` and `yarn install --immutable`
2. Precompile the assets: `RAILS_ENV=production bundle exec rails assets:precompile`
3. Restart all Mastodon processes.

### When using Docker

1. Restart all Mastodon processes.

[Full release notes](https://github.com/mastodon/mastodon/releases/tag/v4.5.9)
