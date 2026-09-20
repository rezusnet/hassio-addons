<!-- markdownlint-disable -->
<!-- Changelog entries mirror upstream release notes verbatim; upstream formatting is intentionally preserved, so style rules are disabled for this file. -->

## 6.4.4.10685-ls317 (2026-09-17)

Updated to upstream Radarr **6.4.4.10685** (image `6.4.4.10685-ls317`):

*To receive further Pre-Release or final updates for a non-docker installation, please change the branch to **master**. (Settings -> General (Show Advanced Settings) -> Updates -> Branch)*

**If you are using docker you will need to update the container image.  *Do not attempt to update Radarr within an existing docker container.***

### Changes:

* a96bf7c3ecb23cb76993770727285dc17a613fbc Multiple Translations updated by Weblate
* 3fcf0db80f396059ffc1a4c513075a88a7816080 Don't skip health check if Allowed Hosts is set to *
* 92f24bcdb96def15923779e277afea878ee0de3a Fixed: Improve logging for 'Allowed Hosts' and 'Trusted Networks'
* 223dc1862d980517554acea36541a06c13ee27db Fix modals on iOS
* 7946e7bd2cec7a67227c642ab9c9fa61ef1c14c5 Fixed: Switch theme automatically on system change
* 7004fe8b3eee3f0280ea440dd6f59e576e0692b1 Produce distinct values in aggregated movie stats from Postgres
* c52c7f438764e793529e0cdbfdcc12400ff6fc35 New: Filter movies by movie file quality
* 0220f0daa9f68ffa40e5f0fe1ce4f909858ceba4 Log warning if hardlinking failed and fallbacks to copy
* 516ca5979e0b2ed776778e9b73158aec0a456c96 Restore auto width behavior from previous FontAwesome versions
* 36d8492959846d4189b60375835d48ce6e4e2dd2 Bump frontend dependencies
<details><summary><b>See More</b></summary>

* 02834499f47b077f63b993df3d8ec6af6e5ff5f4 Remove unused package references
* 35d35321fbe79c41ceae647659ed889af006b1f6 Multiple Translations updated by Weblate
* 255f38dce817a5a2fb0cdc9b9476324725dc75b3 Fixed: Refactor showing grabbed/blocklisted releases in Interactive Search
* 48a61bf63aabac13446c3792a1d6e0ec8ccd741d Bump to 6.4.4
* 04e27cb264104973e531cf5226430dabf5611786 Bump Sentry to 5.16.3
* 39c172d827a3738af4a2d9e951c7c52ce7153d77 Bump NUnit to 4.5.1
* e80abdd603ffbdcfc48615f824488f7c7402424f Improve external restart handling
* 68b93db78cb7a648d61a486d94eae703242e1e36 Fixed: Importing single files from Freebox
* 45da623c777c2451bff5684718832952925f2be3 Fixed: Re-grabbing a torrent that was already imported should re-import
* 9910767f58b0d9beb3b7fa671ed4695487d917d3 Fixed: Unexpected languages stored in DB will be treated as Unknown
* 2cfc781f85c6fb0355f4c37da5c68d86616e7bdf Fixed: Ignore invalid languages during Manual Import
* 40bb746c5e3f5929f09e0edb9350c721e7670065 Fixed: Connecting to Jellyfin 12+ (#11663)
* bdd5a726071630f408c85fe1b716c5bef108d513 Multiple Translations updated by Weblate
* 1906cfb3819b6e9f603642020c6a7d689c8e5352 Fixed: Format of timestamps for Discord notifications from some systems
* 02ef5f56d54aaf46216b6718fd3591ad253548e5 Bump to 6.4.3
* fb908fd5f4861a529e6d60e12ee0a214e24c80ef Remove configuring as service duplicated PostgresOptions
* e575ec5e5e856ebbfeef1c4c1f9b55a86e0d1641 Add isSaving to createSettingsSectionSelector
* c3f0654984994145deeb6bfbdd77654653fd2224 Fix allowed hosts check check on config file changes
* 387d43d7aecc3dfa63f780bf93a72e0966aab319 New: Add Trusted Networks setting
* 91c6dc4eac9883e8389145ff4728858442502212 New: Add hostname validation
* 72ae0c011dc3297b6b5b9feb8971da28977f510c Add reason to health check
* 94ef97b1f1187aeeca20d658a747620df8980238 Improve zip extraction
* a11778302bc04e9d60b7d1d0c640c423272deb0b Bump FluentAssertions to 7.2.2
* f62cb92c105b761c142cedfef2e3eed024f6e922 Display external ID only for main movie link group
* dbcb327a1134d26d2feb9b4589ee8c7b2dafb1ae New: Include External IDs for movies with links

*(…release notes truncated — follow the link below for the full list)*

[Full release notes](https://github.com/Radarr/Radarr/releases/tag/v6.4.4.10685)

## develop-6.4.4.10684-ls267 (2026-09-15)

Updated to upstream Radarr **6.4.4.10684** (image `develop-6.4.4.10684-ls267`):

*To receive further Pre-Release updates for a non-docker installation, please change the branch to **develop**. (Settings -> General (Show Advanced Settings) -> Updates -> Branch)*

**If you are using docker you will need to update the container image.  *Do not attempt to update Radarr within an existing docker container.***

### Changes:

* a96bf7c3ecb23cb76993770727285dc17a613fbc Multiple Translations updated by Weblate
* 3fcf0db80f396059ffc1a4c513075a88a7816080 Don't skip health check if Allowed Hosts is set to *
* 92f24bcdb96def15923779e277afea878ee0de3a Fixed: Improve logging for 'Allowed Hosts' and 'Trusted Networks'
* 223dc1862d980517554acea36541a06c13ee27db Fix modals on iOS
* 7946e7bd2cec7a67227c642ab9c9fa61ef1c14c5 Fixed: Switch theme automatically on system change
* 7004fe8b3eee3f0280ea440dd6f59e576e0692b1 Produce distinct values in aggregated movie stats from Postgres
* c52c7f438764e793529e0cdbfdcc12400ff6fc35 New: Filter movies by movie file quality
* 0220f0daa9f68ffa40e5f0fe1ce4f909858ceba4 Log warning if hardlinking failed and fallbacks to copy
* 516ca5979e0b2ed776778e9b73158aec0a456c96 Restore auto width behavior from previous FontAwesome versions
* 36d8492959846d4189b60375835d48ce6e4e2dd2 Bump frontend dependencies
<details><summary><b>See More</b></summary>

* 02834499f47b077f63b993df3d8ec6af6e5ff5f4 Remove unused package references
* 35d35321fbe79c41ceae647659ed889af006b1f6 Multiple Translations updated by Weblate
* 255f38dce817a5a2fb0cdc9b9476324725dc75b3 Fixed: Refactor showing grabbed/blocklisted releases in Interactive Search
* 48a61bf63aabac13446c3792a1d6e0ec8ccd741d Bump to 6.4.4
* 04e27cb264104973e531cf5226430dabf5611786 Bump Sentry to 5.16.3
* 39c172d827a3738af4a2d9e951c7c52ce7153d77 Bump NUnit to 4.5.1
* e80abdd603ffbdcfc48615f824488f7c7402424f Improve external restart handling

This list of changes was [auto generated](https://dev.azure.com/Radarr/961c82cf-1428-4ab0-9257-63be1671eac8/_release?releaseId=232&_a=release-summary).</details>

[Full release notes](https://github.com/Radarr/Radarr/releases/tag/v6.4.4.10684)

## 6.3.0.10514-ls316 (2026-09-14)

Upstream image rebuild (`6.3.0.10514-ls315` → `6.3.0.10514-ls316`) — packaging / base-image refresh, no application changes (Radarr **6.3.0.10514**).

## 6.3.0.10514-ls315 (2026-09-07)

Updated to upstream Radarr **6.3.0.10514** (image `6.3.0.10514-ls315`):

*To receive further Pre-Release or final updates for a non-docker installation, please change the branch to **master**. (Settings -> General (Show Advanced Settings) -> Updates -> Branch)*

**If you are using docker you will need to update the container image.  *Do not attempt to update Radarr within an existing docker container.***

### Changes:

* 7827e5368947f158ad06f757334f5cde6c406411 Fix build due to low disk space
* 90d0e26bd1d41c88e7a6bf710219edc818577f8e Multiple Translations updated by Weblate
* d944e0e4c9753604513b0b1823cb2bfd5f68e53d Fixed: Importing new items from Simkl lists
* 5b8c6f73da737c69bb74bde419673319f0d47e49 Fix: Bump FFProbe to 5.1.10
* c97100c1c8f3cdf839be3adca42835684cc92c36 Bump version to 6.3.0
* c3849dbcb02f6e38cb6206e672ca6e2313962b8c Upgrade StyleCop.Analyzers to Unstable 1.2.0.556
* 104fbe7e3f005c438ed6f91d013bd8d921483cb9 Fixed: Custom formats with year for imported files

This list of changes was [auto generated](https://dev.azure.com/Radarr/961c82cf-1428-4ab0-9257-63be1671eac8/_release?releaseId=222&_a=release-summary).

[Full release notes](https://github.com/Radarr/Radarr/releases/tag/v6.3.0.10514)

## develop-6.4.3.10645-ls265 (2026-09-01)

Updated to upstream Radarr **6.4.3.10645** (image `develop-6.4.3.10645-ls265`):

*To receive further Pre-Release updates for a non-docker installation, please change the branch to **develop**. (Settings -> General (Show Advanced Settings) -> Updates -> Branch)*

**If you are using docker you will need to update the container image.  *Do not attempt to update Radarr within an existing docker container.***

### Changes:

* 68b93db78cb7a648d61a486d94eae703242e1e36 Fixed: Importing single files from Freebox
* 45da623c777c2451bff5684718832952925f2be3 Fixed: Re-grabbing a torrent that was already imported should re-import
* 9910767f58b0d9beb3b7fa671ed4695487d917d3 Fixed: Unexpected languages stored in DB will be treated as Unknown
* 2cfc781f85c6fb0355f4c37da5c68d86616e7bdf Fixed: Ignore invalid languages during Manual Import
* 40bb746c5e3f5929f09e0edb9350c721e7670065 Fixed: Connecting to Jellyfin 12+ (#11663)
* bdd5a726071630f408c85fe1b716c5bef108d513 Multiple Translations updated by Weblate
* 1906cfb3819b6e9f603642020c6a7d689c8e5352 Fixed: Format of timestamps for Discord notifications from some systems
* 02ef5f56d54aaf46216b6718fd3591ad253548e5 Bump to 6.4.3
* fb908fd5f4861a529e6d60e12ee0a214e24c80ef Remove configuring as service duplicated PostgresOptions
* e575ec5e5e856ebbfeef1c4c1f9b55a86e0d1641 Add isSaving to createSettingsSectionSelector
<details><summary><b>See More</b></summary>

* c3f0654984994145deeb6bfbdd77654653fd2224 Fix allowed hosts check check on config file changes
* 387d43d7aecc3dfa63f780bf93a72e0966aab319 New: Add Trusted Networks setting
* 91c6dc4eac9883e8389145ff4728858442502212 New: Add hostname validation
* 72ae0c011dc3297b6b5b9feb8971da28977f510c Add reason to health check
* 94ef97b1f1187aeeca20d658a747620df8980238 Improve zip extraction
* a11778302bc04e9d60b7d1d0c640c423272deb0b Bump FluentAssertions to 7.2.2
* f62cb92c105b761c142cedfef2e3eed024f6e922 Display external ID only for main movie link group
* dbcb327a1134d26d2feb9b4589ee8c7b2dafb1ae New: Include External IDs for movies with links
* fd8eb4d1593f05b3025b17a61265cbc6593d8e91 Fixed: Don't allow pushed releases to bypass pending releases that recently expired
* c53ccacbce65ed6c61e802038213413d720e0bc6 Bump swiper to 14.1.0
* 3287f8e14ae5204604fb12d8fc1101b77903d35a New: Search movies by original title from page header
* 109f88d7b50a4ba9b1a8430dfafa0b5e0d6fc451 New: Use translations for days of week
* aae657b160787f1f3765d3ba5abbd6adb3a06f47 Convert getLanguageName to hook
* 25eeec39b5c43422e2e81cae3758a902890d9e40 Query options support for useApiQuery

This list of changes was [auto generated](https://dev.azure.com/Radarr/961c82cf-1428-4ab0-9257-63be1671eac8/_release?releaseId=230&_a=release-summary).</details>

[Full release notes](https://github.com/Radarr/Radarr/releases/tag/v6.4.3.10645)

## develop-6.4.2.10590-ls265 (2026-08-31)

Updated to upstream Radarr **6.4.2.10590** (image `develop-6.4.2.10590-ls265`):

*To receive further Pre-Release updates for a non-docker installation, please change the branch to **develop**. (Settings -> General (Show Advanced Settings) -> Updates -> Branch)*

**If you are using docker you will need to update the container image.  *Do not attempt to update Radarr within an existing docker container.***

### Changes:

* 2c24d9b4aafd00dedea4505119060c242c0963be Fixed: Trakt OAuth URL
* a598695ecd70c95b38f4f9efcd1dbe12cccd2f49 Multiple Translations updated by Weblate
* b8a3923bce9d80eccc0abcbc0cbb4ff4091e7999 Fixed: Parsing anime releases that contain year in the movie title
* 6a1c50028457d45712316d06b1c07f5387987835 Fixed: Broken Trakt links
* 6bb8edeafdf71829249702f0e85cd8d6c7809a5c Remove offensive joke about a sensitive topic
* ca451608dc60c6cec754aba8d96bfa30e9468ed5 Bump sqlite to 3.53.4
* c6fef4309de3ffdd5e0e9607ad30beb12d791333 Return maximum long value on overflow getting disk information
* 25062f2d7aec0bcc83551f48e94836fa658c28ef Fix queue not showing items with issues
* d2d9dce33baf969ee5801820ee7cdac25d5b8b89 Fix parsing already imported items from download clients
* 80bbaa6e413c84dc901b090d33ecc66190e7d83b Fixed: Parsing quality and languages when manual importing item with multiple movies error
<details><summary><b>See More</b></summary>

* 34b0f5450fdc346cc72cf18669e601d68b974250 Fixed: Parse Celdra as release group
* 598f989ad1163b3ed21ef57880ba8ba4d1b07e51 Bump to 6.4.2

This list of changes was [auto generated](https://dev.azure.com/Radarr/961c82cf-1428-4ab0-9257-63be1671eac8/_release?releaseId=228&_a=release-summary).</details>

[Full release notes](https://github.com/Radarr/Radarr/releases/tag/v6.4.2.10590)

## 6.3.0.10514-ls314 (2026-08-24)

Upstream image rebuild (`6.3.0.10514-ls313` → `6.3.0.10514-ls314`) — packaging / base-image refresh, no application changes (Radarr **6.3.0.10514**).

## 6.3.0.10514-ls313 (2026-08-03)

Updated to upstream Radarr **6.3.0.10514** (image `6.3.0.10514-ls313`):

*To receive further Pre-Release or final updates for a non-docker installation, please change the branch to **master**. (Settings -> General (Show Advanced Settings) -> Updates -> Branch)*

**If you are using docker you will need to update the container image.  *Do not attempt to update Radarr within an existing docker container.***

### Changes:

* 7827e5368947f158ad06f757334f5cde6c406411 Fix build due to low disk space
* 90d0e26bd1d41c88e7a6bf710219edc818577f8e Multiple Translations updated by Weblate
* d944e0e4c9753604513b0b1823cb2bfd5f68e53d Fixed: Importing new items from Simkl lists
* 5b8c6f73da737c69bb74bde419673319f0d47e49 Fix: Bump FFProbe to 5.1.10
* c97100c1c8f3cdf839be3adca42835684cc92c36 Bump version to 6.3.0
* c3849dbcb02f6e38cb6206e672ca6e2313962b8c Upgrade StyleCop.Analyzers to Unstable 1.2.0.556
* 104fbe7e3f005c438ed6f91d013bd8d921483cb9 Fixed: Custom formats with year for imported files

This list of changes was [auto generated](https://dev.azure.com/Radarr/961c82cf-1428-4ab0-9257-63be1671eac8/_release?releaseId=222&_a=release-summary).

[Full release notes](https://github.com/Radarr/Radarr/releases/tag/v6.3.0.10514)

## develop-6.4.0.10540-ls263 (2026-08-02)

Updated to upstream Radarr **6.4.0.10540** (image `develop-6.4.0.10540-ls263`):

*To receive further Pre-Release updates for a non-docker installation, please change the branch to **develop**. (Settings -> General (Show Advanced Settings) -> Updates -> Branch)*

**If you are using docker you will need to update the container image.  *Do not attempt to update Radarr within an existing docker container.***

### Changes:

* 0c78421d553f8395fee14171892da60650123c97 Fix disposing of the HttpRequestMessage
* 750247fbe7dbcaa06b3b95ef52286b7c314d46f8 Defer deserialize JSON response resource with Lazy
* 1737a7166976e077dc288081c3b47a85ac4ee79a Fix log message for MinCustomFormatScore rejection
* f3bb6321cdee98cf8f22c80acc26d847bd4ecba8 Ignore case for rating type enums
* 2089d4a33f2ffe0151cbab5ebb3b7ec48af3c34c Avoid suppresing search for movies errors
* 9d814137c12dae035e95ee14e3a2c079ce7d20db Wrap bulk UpdateMany/SetFields in a transaction
* 69f8ceaeb59021be314d7790a5eb1f38b99f10da Fixed: Improve cache busting for covers using a hash instead of file modification time

This list of changes was [auto generated](https://dev.azure.com/Radarr/961c82cf-1428-4ab0-9257-63be1671eac8/_release?releaseId=224&_a=release-summary).

[Full release notes](https://github.com/Radarr/Radarr/releases/tag/v6.4.0.10540)

## 6.3.0.10514-ls312 (2026-07-20)

Upstream image rebuild (`6.3.0.10514-ls311` → `6.3.0.10514-ls312`) — packaging / base-image refresh, no application changes (Radarr **6.3.0.10514**).

## 6.3.0.10514-ls311 (2026-07-13)

Updated to upstream Radarr **6.3.0.10514** (image `6.3.0.10514-ls311`):

*To receive further Pre-Release or final updates for a non-docker installation, please change the branch to **master**. (Settings -> General (Show Advanced Settings) -> Updates -> Branch)*

**If you are using docker you will need to update the container image.  *Do not attempt to update Radarr within an existing docker container.***

### Changes:

* 7827e5368947f158ad06f757334f5cde6c406411 Fix build due to low disk space
* 90d0e26bd1d41c88e7a6bf710219edc818577f8e Multiple Translations updated by Weblate
* d944e0e4c9753604513b0b1823cb2bfd5f68e53d Fixed: Importing new items from Simkl lists
* 5b8c6f73da737c69bb74bde419673319f0d47e49 Fix: Bump FFProbe to 5.1.10
* c97100c1c8f3cdf839be3adca42835684cc92c36 Bump version to 6.3.0
* c3849dbcb02f6e38cb6206e672ca6e2313962b8c Upgrade StyleCop.Analyzers to Unstable 1.2.0.556
* 104fbe7e3f005c438ed6f91d013bd8d921483cb9 Fixed: Custom formats with year for imported files

This list of changes was [auto generated](https://dev.azure.com/Radarr/961c82cf-1428-4ab0-9257-63be1671eac8/_release?releaseId=222&_a=release-summary).

[Full release notes](https://github.com/Radarr/Radarr/releases/tag/v6.3.0.10514)

## 6.2.1.10461-ls309 (2026-07-10)

Upstream image rebuild (`6.2.1.10461-ls308` → `6.2.1.10461-ls309`) — packaging / base-image refresh, no application changes (Radarr **6.2.1.10461**).

## 6.2.1.10461-ls308 (2026-06-29)

Upstream image rebuild (`6.2.1.10461-ls307` → `6.2.1.10461-ls308`) — packaging / base-image refresh, no application changes (Radarr **6.2.1.10461**).

## 6.2.1.10461-ls307 (2026-06-22)

Upstream image rebuild (`6.2.1.10461-ls306` → `6.2.1.10461-ls307`) — packaging / base-image refresh, no application changes (Radarr **6.2.1.10461**).

## 6.2.1.10461-ls306 (2026-06-15)

Upstream image rebuild (`6.2.1.10461-ls305` → `6.2.1.10461-ls306`) — packaging / base-image refresh, no application changes (Radarr **6.2.1.10461**).

## 6.2.1.10461-ls305 (2026-06-11)

Updated to upstream Radarr **6.2.1.10461** (image `6.2.1.10461-ls305`):

*To receive further Pre-Release or final updates for a non-docker installation, please change the branch to **master**. (Settings -> General (Show Advanced Settings) -> Updates -> Branch)*

**If you are using docker you will need to update the container image.  *Do not attempt to update Radarr within an existing docker container.***

### Changes:

* 4dcc7c78317ec2a58578c35bfa6dae559d98548f Fixed: Basic auth for qBittorrent
* 520bf4215a13223433ef6c77ad7e822cd8359c94 Bump BusyTimeout for SQLite to 1000ms
* 3b80076373859a5f866b1d52ddc25aa7613a064a Bump version to 6.2.1
* cf3775621be8e39c011cdff63f6939400a108bb5 Bump dessant github actions to fix token issues
* 4e1e87660094752d8f4dca40009ae29cda982e20 Reuse authentification cookies for qBittorrent calls
* 16c4ab2b0da866c1a72e14ed747fb0893628a716 New: Postgres Connection String option
* 559a2980c360473a9e017f37669cd5e300657cb8 New: Bump .NET to 8.0.27
* c7c205cafb4487317616aa57bc36e4948d10114c Fixed: Reduce data transfer when reading video stream from files (#11364)
* 5981aea577db5ae8e27920c50e7c6f23f1806f9c New: Simkl Anime List integration (#11465)
* 065414211d275a86c7b580d000065f548aafbcb5 Fix qBittorrent priority help text
<details><summary><b>See More</b></summary>

* eec3efdb317bdfc81d1a18c0d3af76d6d10cb096 New: API key support for qBittorrent
* b028efbe3eb5c5c9a4f0776627d22b0781e212d9 Fixed: Login with credentials on Qbittorrent 5.2
* 8ac3e4746a40390c4278e97af034f9dc710992c5 Fixed: Testing qBittorrent after credentials change would always pass tests
* 0134fdedcaff8eaeb6baaeee95e873a2b4881221 Prevent overflow exception for big numbers in SizeSuffix and Fluent.Round
* 7dd5365ccd5130b62b98f4bef9bfd69d7721aebc Fixed: Include quality modifier when augmenting quality from media info
* ece044e2701d0269e36e458572f48816e5293654 Log media info title used to augment quality
* 92268767921bddd1625c6acb80b704464b5feb0a Bump MailKit to 4.16.0
* 662324775ed72ea39589a2a8f9d7ffec39bca644 version bump to 6.2.0
* 331ce4579ce2f3d7cb06d82c0e62c42148acacb8 Close issues that don't follow issue templates
* 4b85fab05bc37a51c2e673673d9cabd4113fedd8 Fixed: Downloading backups when path contains a trailing slash
* 8ae71b54a784ec333d37dc2d62a22ab3c9825214 chore: Fix innosetup download URI
* 079e2136ee6d3b579329f18deaf2e59ed20d93ee version bump to 6.1.2

This list of changes was [auto generated](https://dev.azure.com/Radarr/961c82cf-1428-4ab0-9257-63be1671eac8/_release?releaseId=218&_a=release-summary).</details>

[Full release notes](https://github.com/Radarr/Radarr/releases/tag/v6.2.1.10461)

## develop-6.2.1.10437-ls256 (2026-06-01)

Updated to upstream Radarr **6.2.1.10437** (image `develop-6.2.1.10437-ls256`):

*To receive further Pre-Release updates for a non-docker installation, please change the branch to **develop**. (Settings -> General (Show Advanced Settings) -> Updates -> Branch)*

**If you are using docker you will need to update the container image.  *Do not attempt to update Radarr within an existing docker container.***

### Changes:

* 520bf4215a13223433ef6c77ad7e822cd8359c94 Bump BusyTimeout for SQLite to 1000ms
* 3b80076373859a5f866b1d52ddc25aa7613a064a Bump version to 6.2.1
* cf3775621be8e39c011cdff63f6939400a108bb5 Bump dessant github actions to fix token issues
* 4e1e87660094752d8f4dca40009ae29cda982e20 Reuse authentification cookies for qBittorrent calls
* 16c4ab2b0da866c1a72e14ed747fb0893628a716 New: Postgres Connection String option
* 559a2980c360473a9e017f37669cd5e300657cb8 New: Bump .NET to 8.0.27
* c7c205cafb4487317616aa57bc36e4948d10114c Fixed: Reduce data transfer when reading video stream from files (#11364)
* 5981aea577db5ae8e27920c50e7c6f23f1806f9c New: Simkl Anime List integration (#11465)
* 065414211d275a86c7b580d000065f548aafbcb5 Fix qBittorrent priority help text
* eec3efdb317bdfc81d1a18c0d3af76d6d10cb096 New: API key support for qBittorrent
<details><summary><b>See More</b></summary>

* b028efbe3eb5c5c9a4f0776627d22b0781e212d9 Fixed: Login with credentials on Qbittorrent 5.2
* 8ac3e4746a40390c4278e97af034f9dc710992c5 Fixed: Testing qBittorrent after credentials change would always pass tests
* 0134fdedcaff8eaeb6baaeee95e873a2b4881221 Prevent overflow exception for big numbers in SizeSuffix and Fluent.Round
* 7dd5365ccd5130b62b98f4bef9bfd69d7721aebc Fixed: Include quality modifier when augmenting quality from media info
* ece044e2701d0269e36e458572f48816e5293654 Log media info title used to augment quality

This list of changes was [auto generated](https://dev.azure.com/Radarr/961c82cf-1428-4ab0-9257-63be1671eac8/_release?releaseId=217&_a=release-summary).</details>

[Full release notes](https://github.com/Radarr/Radarr/releases/tag/v6.2.1.10437)

## 6.1.1.10360-ls303 (2026-05-19)

Upstream image rebuild (`6.1.1.10360-ls302` → `6.1.1.10360-ls303`) — packaging / base-image refresh, no application changes (Radarr **6.1.1.10360**).

## 6.1.1.10360-ls302 (2026-05-12)

Upstream image rebuild (`6.1.1.10360-ls300` → `6.1.1.10360-ls302`) — packaging / base-image refresh, no application changes (Radarr **6.1.1.10360**).

## 6.1.1.10360-ls300 (2026-05-01)

Upstream image rebuild (`6.1.1.10360` → `6.1.1.10360-ls300`) — packaging / base-image refresh, no application changes (Radarr **6.1.1.10360**).

## 6.1.1.10360 (26-04-2026)

- Initial release based on Radarr 6.1.1.10360
- Uses linuxserver/docker-radarr as base image
- HA ingress via sidebar (ingress_stream)
- SMB/CIFS network share mounting
- Local disk mounting (USB, SATA, NVMe)
- Custom environment variables
- AppArmor profile for media server permissions

### Upstream Radarr 6.1.1.10360

*To receive further Pre-Release or final updates for a non-docker installation, please change the branch to **master**. (Settings -> General (Show Advanced Settings) -> Updates -> Branch)*

**If you are using docker you will need to update the container image.  *Do not attempt to update Radarr within an existing docker container.***

### Changes:

* df8f82c3c61002b97490e003d8455c5dd15f3d76 chore: Fix innosetup download URI
* cf0d6b014222a6424bae52dbbb55849a6f874d2f Chore: Sonar Cloud version bump
* f1513ca39e7179030eb84ac3769bdc6e41b9c05b Multiple Translations updated by Weblate
* 7062b3a1786d8825648ef70a277a29233b85e118 Bump MailKit to 4.15.1 [ #11399 ]
* 7885404c2c2a850365c42608720f551aab9d180a Bump ImageSharp to 3.1.12 [ #11397 ]
* 1ce378356645c21dcb3fb9d583958aa778263f84 Fixed: Parsing URLs on some systems due to Locale
* 1a2b90bf3660cb937042b9fb12ce5e24a0d67bbb Improve HTTP file mappers
* 89110c2cc8ec671d718cf34acc845f66d475a427 version bump to 6.1.1
* a12683502849fdc739b0e41505905a38aa416e90 New: Parse Group GiLG
* 4c007291833246d3ed78e6f396fc7e60cc9ca70c Fix: (#11303) collection API error when using `Movie CollectionThe` (#11304)
<details><summary><b>See More</b></summary>

* b59ff0a3b131d842266b5958bc9977dc87e0220d Skip proxy tests on MacOsX
* b9c2563c9b94b127a296907ca2e0e069c01c2575 Chore: Remove Readarr donation logo
* 949922b9a1873dc228c0693eea63af6f8c854f0d New: add TTL setting for pushover notifications
* 1b9662d58823ff02b7162282e84e4aed95db0126 chore: updated build images
* 005c870f692b9a2466c5f03e22014000728e4f4f bump to 6.1.0

This list of changes was [auto generated](https://dev.azure.com/Radarr/961c82cf-1428-4ab0-9257-63be1671eac8/_release?releaseId=210&_a=release-summary).</details>

[Full release notes](https://github.com/Radarr/Radarr/releases/tag/v6.1.1.10360)
