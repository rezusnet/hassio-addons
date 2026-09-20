<!-- markdownlint-disable -->
<!-- Changelog entries mirror upstream release notes verbatim; upstream formatting is intentionally preserved, so style rules are disabled for this file. -->

## 2.6.5.5623-ls161 (2026-09-17)

Updated to upstream Prowlarr **2.6.5.5623** (image `2.6.5.5623-ls161`):

*To receive further updates for a non-docker installation, please change the branch to **master**. (Settings -> General (Show Advanced Settings) -> Updates -> Branch)*

**If you are using docker you will need to update the container image.  *Do not attempt to update Prowlarr within an existing docker container.***

### Changes:

* 12c327808314a7cae1b7301935ee10cabc19609f Multiple Translations updated by Weblate
* f2d7c495c1460fb402bfea59815df3ba839bacde Bump to 2.6.5
* 28827d0a11da741e6d9d2595e79feb18bb27f3c8 Fixed: Update help text for Allowed Hosts
* 403b2f165512709ca1f7fd80db0f64d1254c6042 Don't skip health check if Allowed Hosts is set to *
* 22941281abad142b449062ae7f1c67e268ca46ec Fixed: Improve logging for 'Allowed Hosts' and 'Trusted Networks'
* 693c7c3b0e8ec6e9dd792c01e5fa1091260b3be1 Multiple Translations updated by Weblate
* 0ee62b0f8eba7af4f6be6a280ffdb490048a0b67 Remove unused package references
* bc0feb6163fb3094c9ac4a0cae8a71c68425fe5f Bump to 2.6.4
* 765e24e3b3d7684f0f4a93694391d3188d14a4a4 Bump Sentry to 5.16.3
* 6aaafa68d279b03c90e6acbc5092b982478c8571 Improve external restart handling
<details><summary><b>See More</b></summary>

* a69014a3d2f57d1f4051d3bbd4b39e203cb18069 Fixed: Treat invalid contents as unavailable releases
* 3775057c2e1b761e71ba404a9f43b82527ca80c8 Fixed: Handle 307 and 308 redirects for indexer download requests
* a4302a225209331fd94eb8b15ae8a8ee5ca9c2fa Fixed: Prevent paths with multiple slashes causing backups to fail
* 455f1d62435ccc2e0383ac2f996dfbebf6e40c17 Fixed: Definition existence check before grabbing the remote definition
* 707f790d5814b4509bcb2f754dd871456ad85560 Fixed: Format of timestamps for Discord notifications from some systems
* a434ee05a27ebcf1d50b1c5c79175e0aeb54087c Multiple Translations updated by Weblate
* ad94fed77ed68cd23b9f20ba84f1100e73d8fbe6 Convert First Run to TypeScript
* eb9a3a3973d804cf42a594429b81f8be309b5cd5 Fix allowed hosts check check on config file changes
* c80c6fb1877292b177e240171b1ea0e9809349ea New: Add Trusted Networks setting
* c32fc1ba19972aaa777f2af0e332feea124d5e00 New: Add hostname validation
* 6a9a9a46098765626f570c9454357dfde1bf1fa2 Add reason to health check
* 79491b48ed97e9394e3ec06bc5e144156e73b7eb Improve zip extraction
* 9be50b90ef9c10755244c4f7dca4d48e663631a8 Bump to 2.6.3
* 647f0dcc8d86448409fc06db5fa071d99b7aaba0 Bump FluentAssertions to 7.2.2
* 8a08ee6a0646e2de3f57c8398f06eca81d537aeb Fixed: (BTN) Improve searching for episodes with 3 digit numbering
* 61bf5460d9cb2191a69e9d8225a7d4e996f5de84 Upgrade MonoTorrent to 3.0.2
* f45a2501b28ad915bddb9e8f822890c5f1c3060d Bump NUnit to 4.5.1
* 59b68a79dcfb75f9861662c878d5c46164de3724 Fixed: (MyAnonamouse) perpage parameter API (#2792)
* d6dcccd4256266c5b14cfc1e70c64221e20531bd Fix newznab redirect database migration
* 17e12c074efb6a00e4a85312b557a77ac692da4e Multiple Translations updated by Weblate
* 70d18b514aaa5f35779966a2a33c1d3fc3189003 Fixed: (FunFile) Moved to Cardigann
* 30342639a89e76cfd2179e1346f967a4356d1121 Update M-Team-TP categories
* e943e22fce654ee7b0b6f97da7df85de0585427d Improve download failed log message
* 9b4d30cedf1d7e8ff3622bdb88e06ebccab50c9d Defer deserialize JSON response resource with Lazy
* 1f7db1e651249f1a3da0d8b55fbc0b2dd980b37a Fixed: (MoreThanTV) Removed, site has shutdown
* 0b8dc38e373ff796d086cdd6e476a5c9e897ba7d Bump sqlite to 3.53.4
* 861b635b9a0165944bc47716bae1f250c14616fd Fixed: Catch empty cookies from FlareSolverr

*(…release notes truncated — follow the link below for the full list)*

[Full release notes](https://github.com/Prowlarr/Prowlarr/releases/tag/v2.6.5.5623)

## develop-2.6.4.5611-ls274 (2026-09-13)

Updated to upstream Prowlarr **2.6.4.5611** (image `develop-2.6.4.5611-ls274`):

*To receive further Pre-Release updates for a non-docker installation, please change the branch to **develop**. (Settings -> General (Show Advanced Settings) -> Updates -> Branch)*

**If you are using docker you will need to update the container image.  *Do not attempt to update Prowlarr within an existing docker container.***

### Changes:

* 693c7c3b0e8ec6e9dd792c01e5fa1091260b3be1 Multiple Translations updated by Weblate
* 0ee62b0f8eba7af4f6be6a280ffdb490048a0b67 Remove unused package references
* bc0feb6163fb3094c9ac4a0cae8a71c68425fe5f Bump to 2.6.4
* 765e24e3b3d7684f0f4a93694391d3188d14a4a4 Bump Sentry to 5.16.3
* 6aaafa68d279b03c90e6acbc5092b982478c8571 Improve external restart handling
* a69014a3d2f57d1f4051d3bbd4b39e203cb18069 Fixed: Treat invalid contents as unavailable releases
* 3775057c2e1b761e71ba404a9f43b82527ca80c8 Fixed: Handle 307 and 308 redirects for indexer download requests
* a4302a225209331fd94eb8b15ae8a8ee5ca9c2fa Fixed: Prevent paths with multiple slashes causing backups to fail
* 455f1d62435ccc2e0383ac2f996dfbebf6e40c17 Fixed: Definition existence check before grabbing the remote definition

This list of changes was [auto generated](https://dev.azure.com/Prowlarr/a958e221-aeac-4b0e-a862-d8ffe1df4b09/_release?releaseId=254&_a=release-summary).

[Full release notes](https://github.com/Prowlarr/Prowlarr/releases/tag/v2.6.4.5611)

## 2.5.2.5491-ls159 (2026-09-10)

Upstream image rebuild (`2.5.2.5491-ls158` → `2.5.2.5491-ls159`) — packaging / base-image refresh, no application changes (Prowlarr **2.5.2.5491**).

## 2.5.2.5491-ls158 (2026-09-03)

Updated to upstream Prowlarr **2.5.2.5491** (image `2.5.2.5491-ls158`):

*To receive further updates for a non-docker installation, please change the branch to **master**. (Settings -> General (Show Advanced Settings) -> Updates -> Branch)*

**If you are using docker you will need to update the container image.  *Do not attempt to update Prowlarr within an existing docker container.***

### Changes:

* c0f8c2c5bc0d7906e8d97e30a9bb7616f37d7090 Fix logging endpoint in Happy Eyeballs
* 61f939ba2f84fc67b82f2cc034295216f533426e Fix status icon for completed tasks without a message
* 714aecb21bc3e6baa4c87c1bb3cec8f4614b0c57 Multiple Translations updated by Weblate
* ab09b84cc7c8ee1f42b81abd532251be226e26f7 Bump AngleSharp, MailKit, SqlClient and Polly
* 819376addfc0efb9c25b07c3560cf735f0f9922e Fixed: (Indexers) Improve size precision for parsing bytes
* 1ecd3338cf7c370f9f8867a7a8b7fb09e1b6ed45 Bump to 2.5.2
* 872b21cd6b17fe5197e2a26fbe85471daf15f3c9 Fix FileList recent feed test
* dbe9ba4e08495b208e9ec9cac61f3263678c9be9 Fixed: (FileList) Update categories
* b25b8a49c5c586a786ca626dd79cda97c8ab842b Fix malformed cookie test
* 88147366daf9de70839370137f75cfb51457ff5d Avoid DNS resolution for IP addresses in Happy Eyeballs
<details><summary><b>See More</b></summary>

* 19529ba9b1fd996b338a6c25daf76b26e8450081 Reduce log noise in HttpHappyEyeballs
* f9069d44388d4f1a91527baba96bba8bed7b87d2 Use Happy Eyeballs for HTTP socket address selection
* e21636310c3aaa3b2b5b7312ceed14547a8c149f New: (Indexer) DesiGaane
* 825620385ac50e5611794a2ab48cb262e005ffe5 Fix build due to low disk space
* 93865723d91e756ac3877d5cdb3b31c6fef91f69 IPTorrents: Don't include 'o' param in query when using default search sorting
* 2d343dfbde35f38c1686b9b323eca14f30f6fab0 Multiple Translations updated by Weblate
* 1b4e088a29693899a66b2f5d1ffcafd63de683a2 New: (IPTorrents) Add sorting by leechers, snatches, size and name
* 1cfa034b7aecf98476b3829d2d79523ead687037 New: (IPTorrents) Add Sort by Seeders option (#2716)
* a22a385491e8d7ca45b11dbd3c5cb94f7f4fd377 Bump version to 2.5.1
* 464d6a22027473be9103f50730090193dd9b2755 New: (Indexer) Usenet NZBIndex (#2713)
* 4961d22ffc45e691606e82de498548d1430973f7 Fixed: (PreToMe) Add missing categories
* 9e19baf1ed29c18e7f3563e0a8cd2190b3db64a6 Fixed: (M-Team - TP) Categories update
* 2fd757a266143d7a845588867a2260b1d19c1265 Fixed: (MyAnonamouse) Author names not being decoded
* 6e55c4f25a7da63f09700d0aef5e5711a3ac5ea9 Fixed: (ImmortalSeed) Update categories
* 410b62ef7374e03a34cd7dd3343e6f69e871d69a Fixed: (AnimeBytes) Allow passkeys with length of 56 characters
* bd3bc4232ff1c20f9ec4782f83c336021d8ad216 Revert "New: (MyAnonamouse) Switch to downloading without session cookies"
* f746bc4b4ec8c89791008ce0f4f553db2d3fca66 Fixed: (Filelist) Update categories
* 94f6684098caa0e0e40b036d4cb38d22b626f07e Bump version to 2.5.0

This list of changes was [auto generated](https://dev.azure.com/Prowlarr/a958e221-aeac-4b0e-a862-d8ffe1df4b09/_release?releaseId=246&_a=release-summary).</details>

[Full release notes](https://github.com/Prowlarr/Prowlarr/releases/tag/v2.5.2.5491)

## develop-2.6.3.5592-ls272 (2026-09-01)

Updated to upstream Prowlarr **2.6.3.5592** (image `develop-2.6.3.5592-ls272`):

*To receive further Pre-Release updates for a non-docker installation, please change the branch to **develop**. (Settings -> General (Show Advanced Settings) -> Updates -> Branch)*

**If you are using docker you will need to update the container image.  *Do not attempt to update Prowlarr within an existing docker container.***

### Changes:

* 707f790d5814b4509bcb2f754dd871456ad85560 Fixed: Format of timestamps for Discord notifications from some systems
* a434ee05a27ebcf1d50b1c5c79175e0aeb54087c Multiple Translations updated by Weblate
* ad94fed77ed68cd23b9f20ba84f1100e73d8fbe6 Convert First Run to TypeScript
* eb9a3a3973d804cf42a594429b81f8be309b5cd5 Fix allowed hosts check check on config file changes
* c80c6fb1877292b177e240171b1ea0e9809349ea New: Add Trusted Networks setting
* c32fc1ba19972aaa777f2af0e332feea124d5e00 New: Add hostname validation
* 6a9a9a46098765626f570c9454357dfde1bf1fa2 Add reason to health check
* 79491b48ed97e9394e3ec06bc5e144156e73b7eb Improve zip extraction
* 9be50b90ef9c10755244c4f7dca4d48e663631a8 Bump to 2.6.3
* 647f0dcc8d86448409fc06db5fa071d99b7aaba0 Bump FluentAssertions to 7.2.2
<details><summary><b>See More</b></summary>

* 8a08ee6a0646e2de3f57c8398f06eca81d537aeb Fixed: (BTN) Improve searching for episodes with 3 digit numbering
* 61bf5460d9cb2191a69e9d8225a7d4e996f5de84 Upgrade MonoTorrent to 3.0.2
* f45a2501b28ad915bddb9e8f822890c5f1c3060d Bump NUnit to 4.5.1
* 59b68a79dcfb75f9861662c878d5c46164de3724 Fixed: (MyAnonamouse) perpage parameter API (#2792)
* d6dcccd4256266c5b14cfc1e70c64221e20531bd Fix newznab redirect database migration

This list of changes was [auto generated](https://dev.azure.com/Prowlarr/a958e221-aeac-4b0e-a862-d8ffe1df4b09/_release?releaseId=253&_a=release-summary).</details>

[Full release notes](https://github.com/Prowlarr/Prowlarr/releases/tag/v2.6.3.5592)

## 2.5.2.5491-ls157 (2026-08-27)

Updated to upstream Prowlarr **2.5.2.5491** (image `2.5.2.5491-ls157`):

*To receive further updates for a non-docker installation, please change the branch to **master**. (Settings -> General (Show Advanced Settings) -> Updates -> Branch)*

**If you are using docker you will need to update the container image.  *Do not attempt to update Prowlarr within an existing docker container.***

### Changes:

* c0f8c2c5bc0d7906e8d97e30a9bb7616f37d7090 Fix logging endpoint in Happy Eyeballs
* 61f939ba2f84fc67b82f2cc034295216f533426e Fix status icon for completed tasks without a message
* 714aecb21bc3e6baa4c87c1bb3cec8f4614b0c57 Multiple Translations updated by Weblate
* ab09b84cc7c8ee1f42b81abd532251be226e26f7 Bump AngleSharp, MailKit, SqlClient and Polly
* 819376addfc0efb9c25b07c3560cf735f0f9922e Fixed: (Indexers) Improve size precision for parsing bytes
* 1ecd3338cf7c370f9f8867a7a8b7fb09e1b6ed45 Bump to 2.5.2
* 872b21cd6b17fe5197e2a26fbe85471daf15f3c9 Fix FileList recent feed test
* dbe9ba4e08495b208e9ec9cac61f3263678c9be9 Fixed: (FileList) Update categories
* b25b8a49c5c586a786ca626dd79cda97c8ab842b Fix malformed cookie test
* 88147366daf9de70839370137f75cfb51457ff5d Avoid DNS resolution for IP addresses in Happy Eyeballs
<details><summary><b>See More</b></summary>

* 19529ba9b1fd996b338a6c25daf76b26e8450081 Reduce log noise in HttpHappyEyeballs
* f9069d44388d4f1a91527baba96bba8bed7b87d2 Use Happy Eyeballs for HTTP socket address selection
* e21636310c3aaa3b2b5b7312ceed14547a8c149f New: (Indexer) DesiGaane
* 825620385ac50e5611794a2ab48cb262e005ffe5 Fix build due to low disk space
* 93865723d91e756ac3877d5cdb3b31c6fef91f69 IPTorrents: Don't include 'o' param in query when using default search sorting
* 2d343dfbde35f38c1686b9b323eca14f30f6fab0 Multiple Translations updated by Weblate
* 1b4e088a29693899a66b2f5d1ffcafd63de683a2 New: (IPTorrents) Add sorting by leechers, snatches, size and name
* 1cfa034b7aecf98476b3829d2d79523ead687037 New: (IPTorrents) Add Sort by Seeders option (#2716)
* a22a385491e8d7ca45b11dbd3c5cb94f7f4fd377 Bump version to 2.5.1
* 464d6a22027473be9103f50730090193dd9b2755 New: (Indexer) Usenet NZBIndex (#2713)
* 4961d22ffc45e691606e82de498548d1430973f7 Fixed: (PreToMe) Add missing categories
* 9e19baf1ed29c18e7f3563e0a8cd2190b3db64a6 Fixed: (M-Team - TP) Categories update
* 2fd757a266143d7a845588867a2260b1d19c1265 Fixed: (MyAnonamouse) Author names not being decoded
* 6e55c4f25a7da63f09700d0aef5e5711a3ac5ea9 Fixed: (ImmortalSeed) Update categories
* 410b62ef7374e03a34cd7dd3343e6f69e871d69a Fixed: (AnimeBytes) Allow passkeys with length of 56 characters
* bd3bc4232ff1c20f9ec4782f83c336021d8ad216 Revert "New: (MyAnonamouse) Switch to downloading without session cookies"
* f746bc4b4ec8c89791008ce0f4f553db2d3fca66 Fixed: (Filelist) Update categories
* 94f6684098caa0e0e40b036d4cb38d22b626f07e Bump version to 2.5.0

This list of changes was [auto generated](https://dev.azure.com/Prowlarr/a958e221-aeac-4b0e-a862-d8ffe1df4b09/_release?releaseId=246&_a=release-summary).</details>

[Full release notes](https://github.com/Prowlarr/Prowlarr/releases/tag/v2.5.2.5491)

## develop-2.6.2.5562-ls271 (2026-08-24)

Updated to upstream Prowlarr **2.6.2.5562** (image `develop-2.6.2.5562-ls271`):

*To receive further Pre-Release updates for a non-docker installation, please change the branch to **develop**. (Settings -> General (Show Advanced Settings) -> Updates -> Branch)*

**If you are using docker you will need to update the container image.  *Do not attempt to update Prowlarr within an existing docker container.***

### Changes:

* 17e12c074efb6a00e4a85312b557a77ac692da4e Multiple Translations updated by Weblate
* 70d18b514aaa5f35779966a2a33c1d3fc3189003 Fixed: (FunFile) Moved to Cardigann
* 30342639a89e76cfd2179e1346f967a4356d1121 Update M-Team-TP categories
* e943e22fce654ee7b0b6f97da7df85de0585427d Improve download failed log message
* 9b4d30cedf1d7e8ff3622bdb88e06ebccab50c9d Defer deserialize JSON response resource with Lazy
* 1f7db1e651249f1a3da0d8b55fbc0b2dd980b37a Fixed: (MoreThanTV) Removed, site has shutdown
* 0b8dc38e373ff796d086cdd6e476a5c9e897ba7d Bump sqlite to 3.53.4
* 861b635b9a0165944bc47716bae1f250c14616fd Fixed: Catch empty cookies from FlareSolverr
* 50f3e7d33068e362fcd4e51f78ea6990f92623c9 Fix flaresolverr status code in failed exception
* 1efad4bbc390e1ee20818ea64748f7f9f24d2a13 Bump to 2.6.2

This list of changes was [auto generated](https://dev.azure.com/Prowlarr/a958e221-aeac-4b0e-a862-d8ffe1df4b09/_release?releaseId=251&_a=release-summary).

[Full release notes](https://github.com/Prowlarr/Prowlarr/releases/tag/v2.6.2.5562)

## 2.5.2.5491-ls156 (2026-08-06)

Updated to upstream Prowlarr **2.5.2.5491** (image `2.5.2.5491-ls156`):

*To receive further updates for a non-docker installation, please change the branch to **master**. (Settings -> General (Show Advanced Settings) -> Updates -> Branch)*

**If you are using docker you will need to update the container image.  *Do not attempt to update Prowlarr within an existing docker container.***

### Changes:

* c0f8c2c5bc0d7906e8d97e30a9bb7616f37d7090 Fix logging endpoint in Happy Eyeballs
* 61f939ba2f84fc67b82f2cc034295216f533426e Fix status icon for completed tasks without a message
* 714aecb21bc3e6baa4c87c1bb3cec8f4614b0c57 Multiple Translations updated by Weblate
* ab09b84cc7c8ee1f42b81abd532251be226e26f7 Bump AngleSharp, MailKit, SqlClient and Polly
* 819376addfc0efb9c25b07c3560cf735f0f9922e Fixed: (Indexers) Improve size precision for parsing bytes
* 1ecd3338cf7c370f9f8867a7a8b7fb09e1b6ed45 Bump to 2.5.2
* 872b21cd6b17fe5197e2a26fbe85471daf15f3c9 Fix FileList recent feed test
* dbe9ba4e08495b208e9ec9cac61f3263678c9be9 Fixed: (FileList) Update categories
* b25b8a49c5c586a786ca626dd79cda97c8ab842b Fix malformed cookie test
* 88147366daf9de70839370137f75cfb51457ff5d Avoid DNS resolution for IP addresses in Happy Eyeballs
<details><summary><b>See More</b></summary>

* 19529ba9b1fd996b338a6c25daf76b26e8450081 Reduce log noise in HttpHappyEyeballs
* f9069d44388d4f1a91527baba96bba8bed7b87d2 Use Happy Eyeballs for HTTP socket address selection
* e21636310c3aaa3b2b5b7312ceed14547a8c149f New: (Indexer) DesiGaane
* 825620385ac50e5611794a2ab48cb262e005ffe5 Fix build due to low disk space
* 93865723d91e756ac3877d5cdb3b31c6fef91f69 IPTorrents: Don't include 'o' param in query when using default search sorting
* 2d343dfbde35f38c1686b9b323eca14f30f6fab0 Multiple Translations updated by Weblate
* 1b4e088a29693899a66b2f5d1ffcafd63de683a2 New: (IPTorrents) Add sorting by leechers, snatches, size and name
* 1cfa034b7aecf98476b3829d2d79523ead687037 New: (IPTorrents) Add Sort by Seeders option (#2716)
* a22a385491e8d7ca45b11dbd3c5cb94f7f4fd377 Bump version to 2.5.1
* 464d6a22027473be9103f50730090193dd9b2755 New: (Indexer) Usenet NZBIndex (#2713)
* 4961d22ffc45e691606e82de498548d1430973f7 Fixed: (PreToMe) Add missing categories
* 9e19baf1ed29c18e7f3563e0a8cd2190b3db64a6 Fixed: (M-Team - TP) Categories update
* 2fd757a266143d7a845588867a2260b1d19c1265 Fixed: (MyAnonamouse) Author names not being decoded
* 6e55c4f25a7da63f09700d0aef5e5711a3ac5ea9 Fixed: (ImmortalSeed) Update categories
* 410b62ef7374e03a34cd7dd3343e6f69e871d69a Fixed: (AnimeBytes) Allow passkeys with length of 56 characters
* bd3bc4232ff1c20f9ec4782f83c336021d8ad216 Revert "New: (MyAnonamouse) Switch to downloading without session cookies"
* f746bc4b4ec8c89791008ce0f4f553db2d3fca66 Fixed: (Filelist) Update categories
* 94f6684098caa0e0e40b036d4cb38d22b626f07e Bump version to 2.5.0

This list of changes was [auto generated](https://dev.azure.com/Prowlarr/a958e221-aeac-4b0e-a862-d8ffe1df4b09/_release?releaseId=246&_a=release-summary).</details>

[Full release notes](https://github.com/Prowlarr/Prowlarr/releases/tag/v2.5.2.5491)

## develop-2.6.1.5509-ls270 (2026-08-05)

Updated to upstream Prowlarr **2.6.1.5509** (image `develop-2.6.1.5509-ls270`):

*To receive further Pre-Release updates for a non-docker installation, please change the branch to **develop**. (Settings -> General (Show Advanced Settings) -> Updates -> Branch)*

**If you are using docker you will need to update the container image.  *Do not attempt to update Prowlarr within an existing docker container.***

### Changes:

* c6034c86f0d6b5e7a04b7dd944c9e1067808b026 New: Show indexer specific categories in search
* dd09f6477feccbcc7e73acecd218b51731c50da5 Bump to 2.6.1

This list of changes was [auto generated](https://dev.azure.com/Prowlarr/a958e221-aeac-4b0e-a862-d8ffe1df4b09/_release?releaseId=248&_a=release-summary).

[Full release notes](https://github.com/Prowlarr/Prowlarr/releases/tag/v2.6.1.5509)

## 2.5.2.5491-ls155 (2026-07-23)

Updated to upstream Prowlarr **2.5.2.5491** (image `2.5.2.5491-ls155`):

*To receive further updates for a non-docker installation, please change the branch to **master**. (Settings -> General (Show Advanced Settings) -> Updates -> Branch)*

**If you are using docker you will need to update the container image.  *Do not attempt to update Prowlarr within an existing docker container.***

### Changes:

* c0f8c2c5bc0d7906e8d97e30a9bb7616f37d7090 Fix logging endpoint in Happy Eyeballs
* 61f939ba2f84fc67b82f2cc034295216f533426e Fix status icon for completed tasks without a message
* 714aecb21bc3e6baa4c87c1bb3cec8f4614b0c57 Multiple Translations updated by Weblate
* ab09b84cc7c8ee1f42b81abd532251be226e26f7 Bump AngleSharp, MailKit, SqlClient and Polly
* 819376addfc0efb9c25b07c3560cf735f0f9922e Fixed: (Indexers) Improve size precision for parsing bytes
* 1ecd3338cf7c370f9f8867a7a8b7fb09e1b6ed45 Bump to 2.5.2
* 872b21cd6b17fe5197e2a26fbe85471daf15f3c9 Fix FileList recent feed test
* dbe9ba4e08495b208e9ec9cac61f3263678c9be9 Fixed: (FileList) Update categories
* b25b8a49c5c586a786ca626dd79cda97c8ab842b Fix malformed cookie test
* 88147366daf9de70839370137f75cfb51457ff5d Avoid DNS resolution for IP addresses in Happy Eyeballs
<details><summary><b>See More</b></summary>

* 19529ba9b1fd996b338a6c25daf76b26e8450081 Reduce log noise in HttpHappyEyeballs
* f9069d44388d4f1a91527baba96bba8bed7b87d2 Use Happy Eyeballs for HTTP socket address selection
* e21636310c3aaa3b2b5b7312ceed14547a8c149f New: (Indexer) DesiGaane
* 825620385ac50e5611794a2ab48cb262e005ffe5 Fix build due to low disk space
* 93865723d91e756ac3877d5cdb3b31c6fef91f69 IPTorrents: Don't include 'o' param in query when using default search sorting
* 2d343dfbde35f38c1686b9b323eca14f30f6fab0 Multiple Translations updated by Weblate
* 1b4e088a29693899a66b2f5d1ffcafd63de683a2 New: (IPTorrents) Add sorting by leechers, snatches, size and name
* 1cfa034b7aecf98476b3829d2d79523ead687037 New: (IPTorrents) Add Sort by Seeders option (#2716)
* a22a385491e8d7ca45b11dbd3c5cb94f7f4fd377 Bump version to 2.5.1
* 464d6a22027473be9103f50730090193dd9b2755 New: (Indexer) Usenet NZBIndex (#2713)
* 4961d22ffc45e691606e82de498548d1430973f7 Fixed: (PreToMe) Add missing categories
* 9e19baf1ed29c18e7f3563e0a8cd2190b3db64a6 Fixed: (M-Team - TP) Categories update
* 2fd757a266143d7a845588867a2260b1d19c1265 Fixed: (MyAnonamouse) Author names not being decoded
* 6e55c4f25a7da63f09700d0aef5e5711a3ac5ea9 Fixed: (ImmortalSeed) Update categories
* 410b62ef7374e03a34cd7dd3343e6f69e871d69a Fixed: (AnimeBytes) Allow passkeys with length of 56 characters
* bd3bc4232ff1c20f9ec4782f83c336021d8ad216 Revert "New: (MyAnonamouse) Switch to downloading without session cookies"
* f746bc4b4ec8c89791008ce0f4f553db2d3fca66 Fixed: (Filelist) Update categories
* 94f6684098caa0e0e40b036d4cb38d22b626f07e Bump version to 2.5.0

This list of changes was [auto generated](https://dev.azure.com/Prowlarr/a958e221-aeac-4b0e-a862-d8ffe1df4b09/_release?releaseId=246&_a=release-summary).</details>

[Full release notes](https://github.com/Prowlarr/Prowlarr/releases/tag/v2.5.2.5491)

## develop-2.5.2.5483-ls269 (2026-07-20)

Updated to upstream Prowlarr **2.5.2.5483** (image `develop-2.5.2.5483-ls269`):

*To receive further Pre-Release updates for a non-docker installation, please change the branch to **develop**. (Settings -> General (Show Advanced Settings) -> Updates -> Branch)*

**If you are using docker you will need to update the container image.  *Do not attempt to update Prowlarr within an existing docker container.***

### Changes:

* 714aecb21bc3e6baa4c87c1bb3cec8f4614b0c57 Multiple Translations updated by Weblate
* ab09b84cc7c8ee1f42b81abd532251be226e26f7 Bump AngleSharp, MailKit, SqlClient and Polly
* 819376addfc0efb9c25b07c3560cf735f0f9922e Fixed: (Indexers) Improve size precision for parsing bytes
* 1ecd3338cf7c370f9f8867a7a8b7fb09e1b6ed45 Bump to 2.5.2
* 872b21cd6b17fe5197e2a26fbe85471daf15f3c9 Fix FileList recent feed test
* dbe9ba4e08495b208e9ec9cac61f3263678c9be9 Fixed: (FileList) Update categories
* b25b8a49c5c586a786ca626dd79cda97c8ab842b Fix malformed cookie test
* 88147366daf9de70839370137f75cfb51457ff5d Avoid DNS resolution for IP addresses in Happy Eyeballs
* 19529ba9b1fd996b338a6c25daf76b26e8450081 Reduce log noise in HttpHappyEyeballs
* f9069d44388d4f1a91527baba96bba8bed7b87d2 Use Happy Eyeballs for HTTP socket address selection
<details><summary><b>See More</b></summary>

* e21636310c3aaa3b2b5b7312ceed14547a8c149f New: (Indexer) DesiGaane

This list of changes was [auto generated](https://dev.azure.com/Prowlarr/a958e221-aeac-4b0e-a862-d8ffe1df4b09/_release?releaseId=245&_a=release-summary).</details>

[Full release notes](https://github.com/Prowlarr/Prowlarr/releases/tag/v2.5.2.5483)

## 2.4.0.5397-ls154 (2026-07-16)

Updated to upstream Prowlarr **2.4.0.5397** (image `2.4.0.5397-ls154`):

*To receive further updates for a non-docker installation, please change the branch to **master**. (Settings -> General (Show Advanced Settings) -> Updates -> Branch)*

**If you are using docker you will need to update the container image.  *Do not attempt to update Prowlarr within an existing docker container.***

### Changes:

* d6e8466d3ee32915d35476b9c225453984992697 Fixed: Basic auth for qBittorrent
* 1f760d4a99e432ac5b403d31f1fea47d24473530 Fix minage, minsize, and maxsize Newznab parameters using wrong source field
* 06304a677b55907fbe54bd097375b27836aa09d9 Fixed: (SecretCinema) Use release titles from API
* 1d7c91aabbd3fbb9a6e46ec24ab097e3f018c44b Multiple Translations updated by Weblate
* 0275db79285b27e72d2cd8cbbd6cafe1a93ec412 Reuse authentification cookies for qBittorrent calls
* 5f021105bfd359f15af92848e1d1c8a31bc65a12 Bump github actions to fix token issues
* bef55de933c6b73de0d41a1eda15d907468f8a4f Fixed: (SecretCinema) Improve release titles
* 32e606c1ab6b48843263c7cc3e2b252949e44790 New: (MyAnonamouse) Switch to downloading without session cookies
* b689dfe2aa27b1da8995b034f60e3b2cf94fa2c1 Fixed: (MyAnonamouse) Refactor freeleech wedge handling
* 638d2d10211767eff97b57a86a69a8fd3bbd4b3e New: Postgres Connection String option
<details><summary><b>See More</b></summary>

* cb80af4be1dfe277b4b1a71f026683a738cfe50e New: Bump .NET to 8.0.27
* 7e3b69b01f92422de1f873d60c00ddfab86160aa New: Basic Auth support for sync applications (#2677)
* 48648342832021707d14037474a5ec887f6b5348 Multiple Translations updated by Weblate
* facfb8f7eb291bc0f3b1cfdf20d2c90df685e77e New: API key support for qBittorrent
* ee093edf37649d6c5d9f49d918a8f93d68479542 Fixed: Login with credentials on Qbittorrent 5.2
* 2aa5de8616f02e0f110e54cd414e989b24066793 Fixed: Testing qBittorrent after credentials change would always pass tests
* 493cb04c22d30ce7bc7ba585eda797094801efbe Version bump to 2.4.0
* 18fe4ec4955f620013cd61daac8a760e033d8a67 Bump MailKit to 4.16.0
* de8738f1d3964177f1fc8cced07ded2b93c061aa Fixed: PWA Manifest images
* 46ce8e270138e757b14cc1b42b259419a2fac979 Version bump to 2.3.7
* c687bdb1fb47787de621c37221d5d95d4ca2fda1 Fixed: Don't send limit=0 to Newznab indexers (#2654)
* b2d49164bc52284a3856b20f5a963e6de10950fe Fixed: (ZonaQ) Obsolete per site policy
* 28bd80d3aa0738616f8aeac01dae053f0d2f6df0 Fixed: (SceneTime) Obsolete - migrated to YAML for Torznab API
* 0ffcfccf1df38e775e25431716387f6eae180231 Version bump to 2.3.6

This list of changes was [auto generated](https://dev.azure.com/Prowlarr/a958e221-aeac-4b0e-a862-d8ffe1df4b09/_release?releaseId=237&_a=release-summary).</details>

[Full release notes](https://github.com/Prowlarr/Prowlarr/releases/tag/v2.4.0.5397)

## develop-2.5.1.5464-ls268 (2026-07-13)

Updated to upstream Prowlarr **2.5.1.5464** (image `develop-2.5.1.5464-ls268`):

*To receive further Pre-Release updates for a non-docker installation, please change the branch to **develop**. (Settings -> General (Show Advanced Settings) -> Updates -> Branch)*

**If you are using docker you will need to update the container image.  *Do not attempt to update Prowlarr within an existing docker container.***

### Changes:

* 825620385ac50e5611794a2ab48cb262e005ffe5 Fix build due to low disk space
* 4961d22ffc45e691606e82de498548d1430973f7 Fixed: (PreToMe) Add missing categories
* 9e19baf1ed29c18e7f3563e0a8cd2190b3db64a6 Fixed: (M-Team - TP) Categories update
* 2fd757a266143d7a845588867a2260b1d19c1265 Fixed: (MyAnonamouse) Author names not being decoded
* 6e55c4f25a7da63f09700d0aef5e5711a3ac5ea9 Fixed: (ImmortalSeed) Update categories
* 410b62ef7374e03a34cd7dd3343e6f69e871d69a Fixed: (AnimeBytes) Allow passkeys with length of 56 characters

This list of changes was [auto generated](https://dev.azure.com/Prowlarr/a958e221-aeac-4b0e-a862-d8ffe1df4b09/_release?releaseId=243&_a=release-summary).

[Full release notes](https://github.com/Prowlarr/Prowlarr/releases/tag/v2.5.1.5464)

## 2.4.0.5397-ls153 (2026-07-10)

Upstream image rebuild (`2.4.0.5397-ls152` → `2.4.0.5397-ls153`) — packaging / base-image refresh, no application changes (Prowlarr **2.4.0.5397**).

## 2.4.0.5397-ls152 (2026-07-02)

Updated to upstream Prowlarr **2.4.0.5397** (image `2.4.0.5397-ls152`):

*To receive further updates for a non-docker installation, please change the branch to **master**. (Settings -> General (Show Advanced Settings) -> Updates -> Branch)*

**If you are using docker you will need to update the container image.  *Do not attempt to update Prowlarr within an existing docker container.***

### Changes:

* d6e8466d3ee32915d35476b9c225453984992697 Fixed: Basic auth for qBittorrent
* 1f760d4a99e432ac5b403d31f1fea47d24473530 Fix minage, minsize, and maxsize Newznab parameters using wrong source field
* 06304a677b55907fbe54bd097375b27836aa09d9 Fixed: (SecretCinema) Use release titles from API
* 1d7c91aabbd3fbb9a6e46ec24ab097e3f018c44b Multiple Translations updated by Weblate
* 0275db79285b27e72d2cd8cbbd6cafe1a93ec412 Reuse authentification cookies for qBittorrent calls
* 5f021105bfd359f15af92848e1d1c8a31bc65a12 Bump github actions to fix token issues
* bef55de933c6b73de0d41a1eda15d907468f8a4f Fixed: (SecretCinema) Improve release titles
* 32e606c1ab6b48843263c7cc3e2b252949e44790 New: (MyAnonamouse) Switch to downloading without session cookies
* b689dfe2aa27b1da8995b034f60e3b2cf94fa2c1 Fixed: (MyAnonamouse) Refactor freeleech wedge handling
* 638d2d10211767eff97b57a86a69a8fd3bbd4b3e New: Postgres Connection String option
<details><summary><b>See More</b></summary>

* cb80af4be1dfe277b4b1a71f026683a738cfe50e New: Bump .NET to 8.0.27
* 7e3b69b01f92422de1f873d60c00ddfab86160aa New: Basic Auth support for sync applications (#2677)
* 48648342832021707d14037474a5ec887f6b5348 Multiple Translations updated by Weblate
* facfb8f7eb291bc0f3b1cfdf20d2c90df685e77e New: API key support for qBittorrent
* ee093edf37649d6c5d9f49d918a8f93d68479542 Fixed: Login with credentials on Qbittorrent 5.2
* 2aa5de8616f02e0f110e54cd414e989b24066793 Fixed: Testing qBittorrent after credentials change would always pass tests
* 493cb04c22d30ce7bc7ba585eda797094801efbe Version bump to 2.4.0
* 18fe4ec4955f620013cd61daac8a760e033d8a67 Bump MailKit to 4.16.0
* de8738f1d3964177f1fc8cced07ded2b93c061aa Fixed: PWA Manifest images
* 46ce8e270138e757b14cc1b42b259419a2fac979 Version bump to 2.3.7
* c687bdb1fb47787de621c37221d5d95d4ca2fda1 Fixed: Don't send limit=0 to Newznab indexers (#2654)
* b2d49164bc52284a3856b20f5a963e6de10950fe Fixed: (ZonaQ) Obsolete per site policy
* 28bd80d3aa0738616f8aeac01dae053f0d2f6df0 Fixed: (SceneTime) Obsolete - migrated to YAML for Torznab API
* 0ffcfccf1df38e775e25431716387f6eae180231 Version bump to 2.3.6

This list of changes was [auto generated](https://dev.azure.com/Prowlarr/a958e221-aeac-4b0e-a862-d8ffe1df4b09/_release?releaseId=237&_a=release-summary).</details>

[Full release notes](https://github.com/Prowlarr/Prowlarr/releases/tag/v2.4.0.5397)

## develop-2.5.0.5422-ls266 (2026-06-28)

Updated to upstream Prowlarr **2.5.0.5422** (image `develop-2.5.0.5422-ls266`):

*To receive further Pre-Release updates for a non-docker installation, please change the branch to **develop**. (Settings -> General (Show Advanced Settings) -> Updates -> Branch)*

**If you are using docker you will need to update the container image.  *Do not attempt to update Prowlarr within an existing docker container.***

### Changes:

* bd3bc4232ff1c20f9ec4782f83c336021d8ad216 Revert "New: (MyAnonamouse) Switch to downloading without session cookies"
* f746bc4b4ec8c89791008ce0f4f553db2d3fca66 Fixed: (Filelist) Update categories
* 94f6684098caa0e0e40b036d4cb38d22b626f07e Bump version to 2.5.0

This list of changes was [auto generated](https://dev.azure.com/Prowlarr/a958e221-aeac-4b0e-a862-d8ffe1df4b09/_release?releaseId=239&_a=release-summary).

[Full release notes](https://github.com/Prowlarr/Prowlarr/releases/tag/v2.5.0.5422)

## 2.4.0.5397-ls151 (2026-06-24)

Upstream image rebuild (`2.4.0.5397-ls150` → `2.4.0.5397-ls151`) — packaging / base-image refresh, no application changes (Prowlarr **2.4.0.5397**).

## 2.4.0.5397-ls150 (2026-06-18)

Upstream image rebuild (`2.4.0.5397-ls149` → `2.4.0.5397-ls150`) — packaging / base-image refresh, no application changes (Prowlarr **2.4.0.5397**).

## 2.4.0.5397-ls149 (2026-06-11)

Updated to upstream Prowlarr **2.4.0.5397** (image `2.4.0.5397-ls149`):

*To receive further updates for a non-docker installation, please change the branch to **master**. (Settings -> General (Show Advanced Settings) -> Updates -> Branch)*

**If you are using docker you will need to update the container image.  *Do not attempt to update Prowlarr within an existing docker container.***

### Changes:

* d6e8466d3ee32915d35476b9c225453984992697 Fixed: Basic auth for qBittorrent
* 1f760d4a99e432ac5b403d31f1fea47d24473530 Fix minage, minsize, and maxsize Newznab parameters using wrong source field
* 06304a677b55907fbe54bd097375b27836aa09d9 Fixed: (SecretCinema) Use release titles from API
* 1d7c91aabbd3fbb9a6e46ec24ab097e3f018c44b Multiple Translations updated by Weblate
* 0275db79285b27e72d2cd8cbbd6cafe1a93ec412 Reuse authentification cookies for qBittorrent calls
* 5f021105bfd359f15af92848e1d1c8a31bc65a12 Bump github actions to fix token issues
* bef55de933c6b73de0d41a1eda15d907468f8a4f Fixed: (SecretCinema) Improve release titles
* 32e606c1ab6b48843263c7cc3e2b252949e44790 New: (MyAnonamouse) Switch to downloading without session cookies
* b689dfe2aa27b1da8995b034f60e3b2cf94fa2c1 Fixed: (MyAnonamouse) Refactor freeleech wedge handling
* 638d2d10211767eff97b57a86a69a8fd3bbd4b3e New: Postgres Connection String option
<details><summary><b>See More</b></summary>

* cb80af4be1dfe277b4b1a71f026683a738cfe50e New: Bump .NET to 8.0.27
* 7e3b69b01f92422de1f873d60c00ddfab86160aa New: Basic Auth support for sync applications (#2677)
* 48648342832021707d14037474a5ec887f6b5348 Multiple Translations updated by Weblate
* facfb8f7eb291bc0f3b1cfdf20d2c90df685e77e New: API key support for qBittorrent
* ee093edf37649d6c5d9f49d918a8f93d68479542 Fixed: Login with credentials on Qbittorrent 5.2
* 2aa5de8616f02e0f110e54cd414e989b24066793 Fixed: Testing qBittorrent after credentials change would always pass tests
* 493cb04c22d30ce7bc7ba585eda797094801efbe Version bump to 2.4.0
* 18fe4ec4955f620013cd61daac8a760e033d8a67 Bump MailKit to 4.16.0
* de8738f1d3964177f1fc8cced07ded2b93c061aa Fixed: PWA Manifest images
* 46ce8e270138e757b14cc1b42b259419a2fac979 Version bump to 2.3.7
* c687bdb1fb47787de621c37221d5d95d4ca2fda1 Fixed: Don't send limit=0 to Newznab indexers (#2654)
* b2d49164bc52284a3856b20f5a963e6de10950fe Fixed: (ZonaQ) Obsolete per site policy
* 28bd80d3aa0738616f8aeac01dae053f0d2f6df0 Fixed: (SceneTime) Obsolete - migrated to YAML for Torznab API
* 0ffcfccf1df38e775e25431716387f6eae180231 Version bump to 2.3.6

This list of changes was [auto generated](https://dev.azure.com/Prowlarr/a958e221-aeac-4b0e-a862-d8ffe1df4b09/_release?releaseId=237&_a=release-summary).</details>

[Full release notes](https://github.com/Prowlarr/Prowlarr/releases/tag/v2.4.0.5397)

## 2.3.5.5327-ls148 (2026-06-04)

Updated to upstream Prowlarr **2.3.5.5327** (image `2.3.5.5327-ls148`):

*To receive further updates for a non-docker installation, please change the branch to **master**. (Settings -> General (Show Advanced Settings) -> Updates -> Branch)*

**If you are using docker you will need to update the container image.  *Do not attempt to update Prowlarr within an existing docker container.***

### Changes:

* 3c4efa0226e73426366b2dfc6498179442791fbf Update browserlist db
* 50d31d0c5e0c7722cb863ee334bfb1d0fdad8e3c Fixed: Downloading backups when path contains a trailing slash
* f48c9f9f88f73db6c9945a0e0210d35673d1fe33 Improve HTTP file mappers
* 1ba2f2664968db44ac6157df6e864aa83882e42e New: Use instance name in PWA manifest
* c880b6c09c91e8d60a1390104d0b6903b267d4a5 Fixed: PWA Manifest with URL base
* 6fca0d0b6cdd00988800c893ecdabe5743d5264e Sync static resource mapper with upstream
* 990734205543c13aa240ae2a86b5ea83c7e32fe3 Close issues that don't follow issue templates
* 71d1a59008c0adf2b48cbf014532397912fa81e2 chore: Fix Innosetup download URI and bump Innosetup version
* 33fa39dc848661b167696e72f652f3bb827f165d Fixed: (SceneTime) Update layout selectors
* d133c825372075405e750acb94c5067134531ed5 Revert incorrectly deleted function in MigrationExtension
<details><summary><b>See More</b></summary>

* 6b446e1404c3b800aca21f2a3a0e0dc4113db227 chore: Clean up unused NuGet dependencies
* b0e879da5c8cd91fcb5952a90d8cb042c9531010 fixed: Loading native libraries on FreeBSD and Linux
* 5edde8d9bd65e6280d4bf6d78674bf702ec521c2 Switch to FluentMigrator.Runner.Core to avoid extranous platform runners
* ef5d670c39875b38623a6d281af06cc6f1926e52 Fallback to host sqlite3 on FreeBSD and Linux
* f56890687668a958554d066e93d93353e05ab383 Bump FluentMigrator to official 6.2.0
* 331e92ac62c4d774e9104fad780a4fb8519d2bac Bump to 2.3.5
* ec46b25be29b88624880b2ad26317c2d536ccc0c Multiple Translations updated by Weblate
* 8b3837cb6e6cc4bb3d232fa6d51ce42cee3a96b0 Fixed: Parsing URLs on some systems due to Locale
* ade5aee4a9dbbe1b3f7486e96a91949f8e3ea9d7 Multiple Translations updated by Weblate
* c48601311309e4e459b6fa172f5a40ca62805695 Fixed: (SceneTime) Update layout selectors and clean titles
* c512cafb4a78b0a0790bd54a5f3bd39302cbd057 New: Add AnimeZ
* 454641e8b5035fe8375b9904fe0ef0a0bd0490cd Bump to 2.3.4
* 7cac3fc174dc0c0cc4c1085e4ec1e2faf5a64ebf Fixed: (Nebulance) Update API call
* 43aca698402dfce42943b6a5106af90bb3e05c64 Multiple Translations updated by Weblate
* e8d4415a5cc39820929b1ed88170d608ea0496c4 fixed: (Scenetime) fix table selectors
* 5858c2dda6b261879a6724e18a85caff81812c14 Fixed: Limit redirects after login to local paths
* ce315afb2adf45aba004c4c1de2d8ada23469058 Updated Security Policy to match Radarr
* 407acb6844ba9d3db1143fc9b3af2d84ea1a06fb Shazbat fixes for searching and relogin if needed (#2607)
* c3a7fbdd861ef3205a476cffc3abc5cb0708f3bb Multiple Translations updated by Weblate
* 472c6f4273f0073e60c32fede559aa09b45ad847 Bump to 2.3.3
* baa4baf3caa09d8f1a97c564f097053e63d3a75e Multiple Translations updated by Weblate
* 852d62dcf0d5422e2cdb2cc8f87d4fe2dda5d9b9 Fixed: (Torrentday) fix category mapping for TVx265 and add TVUHD (#2593)
* 13493ddbce3faa4d391b08ab38640fc696d68844 Multiple Translations updated by Weblate
* a4a8e890c1fac737d8213dfc9cdaee727d03571e Fixed: (BeyondHD) Add movie prefix to TMDB ID queries [ #2591 ]
* 688434ced9f51d8031f93b1988cf18ebe7069c0c Bump BusyTimeout for SQLite to 1000ms
* 2ed910459f47d52cbc14adf8c75c63d67b298c6e Avoid unique constraints for primary keys in SQLite migrations

*(…release notes truncated — follow the link below for the full list)*

[Full release notes](https://github.com/Prowlarr/Prowlarr/releases/tag/v2.3.5.5327)

## develop-2.4.0.5391-ls263 (2026-06-01)

Updated to upstream Prowlarr **2.4.0.5391** (image `develop-2.4.0.5391-ls263`):

*To receive further Pre-Release updates for a non-docker installation, please change the branch to **develop**. (Settings -> General (Show Advanced Settings) -> Updates -> Branch)*

**If you are using docker you will need to update the container image.  *Do not attempt to update Prowlarr within an existing docker container.***

### Changes:

* 1d7c91aabbd3fbb9a6e46ec24ab097e3f018c44b Multiple Translations updated by Weblate
* 0275db79285b27e72d2cd8cbbd6cafe1a93ec412 Reuse authentification cookies for qBittorrent calls
* 5f021105bfd359f15af92848e1d1c8a31bc65a12 Bump github actions to fix token issues
* bef55de933c6b73de0d41a1eda15d907468f8a4f Fixed: (SecretCinema) Improve release titles
* 32e606c1ab6b48843263c7cc3e2b252949e44790 New: (MyAnonamouse) Switch to downloading without session cookies
* b689dfe2aa27b1da8995b034f60e3b2cf94fa2c1 Fixed: (MyAnonamouse) Refactor freeleech wedge handling
* 638d2d10211767eff97b57a86a69a8fd3bbd4b3e New: Postgres Connection String option
* cb80af4be1dfe277b4b1a71f026683a738cfe50e New: Bump .NET to 8.0.27
* 7e3b69b01f92422de1f873d60c00ddfab86160aa New: Basic Auth support for sync applications (#2677)
* 48648342832021707d14037474a5ec887f6b5348 Multiple Translations updated by Weblate
<details><summary><b>See More</b></summary>

* facfb8f7eb291bc0f3b1cfdf20d2c90df685e77e New: API key support for qBittorrent
* ee093edf37649d6c5d9f49d918a8f93d68479542 Fixed: Login with credentials on Qbittorrent 5.2
* 2aa5de8616f02e0f110e54cd414e989b24066793 Fixed: Testing qBittorrent after credentials change would always pass tests
* 493cb04c22d30ce7bc7ba585eda797094801efbe Version bump to 2.4.0

This list of changes was [auto generated](https://dev.azure.com/Prowlarr/a958e221-aeac-4b0e-a862-d8ffe1df4b09/_release?releaseId=236&_a=release-summary).</details>

[Full release notes](https://github.com/Prowlarr/Prowlarr/releases/tag/v2.4.0.5391)

## 2.3.5.5327-ls147 (2026-05-24)

Upstream image rebuild (`2.3.5.5327-ls146` → `2.3.5.5327-ls147`) — packaging / base-image refresh, no application changes (Prowlarr **2.3.5.5327**).

## 2.3.5.5327-ls146 (2026-05-19)

Upstream image rebuild (`2.3.5.5327-ls145` → `2.3.5.5327-ls146`) — packaging / base-image refresh, no application changes (Prowlarr **2.3.5.5327**).

## 2.3.5.5327-ls145 (2026-05-12)

Upstream image rebuild (`2.3.5.5327-ls144` → `2.3.5.5327-ls145`) — packaging / base-image refresh, no application changes (Prowlarr **2.3.5.5327**).

## 2.3.5.5327-ls144 (2026-05-01)

Upstream image rebuild (`2.3.5.5327` → `2.3.5.5327-ls144`) — packaging / base-image refresh, no application changes (Prowlarr **2.3.5.5327**).

## 2.3.5.5327 (26-04-2026)

- Initial release based on Prowlarr 2.3.5.5327
- Uses linuxserver/docker-prowlarr as base image
- HA ingress via sidebar (ingress_stream)
- SMB/CIFS network share mounting
- Local disk mounting (USB, SATA, NVMe)
- Custom environment variables
- AppArmor profile for permissions

### Upstream Prowlarr 2.3.5.5327

*To receive further updates for a non-docker installation, please change the branch to **master**. (Settings -> General (Show Advanced Settings) -> Updates -> Branch)*

**If you are using docker you will need to update the container image.  *Do not attempt to update Prowlarr within an existing docker container.***

### Changes:

* 3c4efa0226e73426366b2dfc6498179442791fbf Update browserlist db
* 50d31d0c5e0c7722cb863ee334bfb1d0fdad8e3c Fixed: Downloading backups when path contains a trailing slash
* f48c9f9f88f73db6c9945a0e0210d35673d1fe33 Improve HTTP file mappers
* 1ba2f2664968db44ac6157df6e864aa83882e42e New: Use instance name in PWA manifest
* c880b6c09c91e8d60a1390104d0b6903b267d4a5 Fixed: PWA Manifest with URL base
* 6fca0d0b6cdd00988800c893ecdabe5743d5264e Sync static resource mapper with upstream
* 990734205543c13aa240ae2a86b5ea83c7e32fe3 Close issues that don't follow issue templates
* 71d1a59008c0adf2b48cbf014532397912fa81e2 chore: Fix Innosetup download URI and bump Innosetup version
* 33fa39dc848661b167696e72f652f3bb827f165d Fixed: (SceneTime) Update layout selectors
* d133c825372075405e750acb94c5067134531ed5 Revert incorrectly deleted function in MigrationExtension
<details><summary><b>See More</b></summary>

* 6b446e1404c3b800aca21f2a3a0e0dc4113db227 chore: Clean up unused NuGet dependencies
* b0e879da5c8cd91fcb5952a90d8cb042c9531010 fixed: Loading native libraries on FreeBSD and Linux
* 5edde8d9bd65e6280d4bf6d78674bf702ec521c2 Switch to FluentMigrator.Runner.Core to avoid extranous platform runners
* ef5d670c39875b38623a6d281af06cc6f1926e52 Fallback to host sqlite3 on FreeBSD and Linux
* f56890687668a958554d066e93d93353e05ab383 Bump FluentMigrator to official 6.2.0
* 331e92ac62c4d774e9104fad780a4fb8519d2bac Bump to 2.3.5
* ec46b25be29b88624880b2ad26317c2d536ccc0c Multiple Translations updated by Weblate
* 8b3837cb6e6cc4bb3d232fa6d51ce42cee3a96b0 Fixed: Parsing URLs on some systems due to Locale
* ade5aee4a9dbbe1b3f7486e96a91949f8e3ea9d7 Multiple Translations updated by Weblate
* c48601311309e4e459b6fa172f5a40ca62805695 Fixed: (SceneTime) Update layout selectors and clean titles
* c512cafb4a78b0a0790bd54a5f3bd39302cbd057 New: Add AnimeZ
* 454641e8b5035fe8375b9904fe0ef0a0bd0490cd Bump to 2.3.4
* 7cac3fc174dc0c0cc4c1085e4ec1e2faf5a64ebf Fixed: (Nebulance) Update API call
* 43aca698402dfce42943b6a5106af90bb3e05c64 Multiple Translations updated by Weblate
* e8d4415a5cc39820929b1ed88170d608ea0496c4 fixed: (Scenetime) fix table selectors
* 5858c2dda6b261879a6724e18a85caff81812c14 Fixed: Limit redirects after login to local paths
* ce315afb2adf45aba004c4c1de2d8ada23469058 Updated Security Policy to match Radarr
* 407acb6844ba9d3db1143fc9b3af2d84ea1a06fb Shazbat fixes for searching and relogin if needed (#2607)
* c3a7fbdd861ef3205a476cffc3abc5cb0708f3bb Multiple Translations updated by Weblate
* 472c6f4273f0073e60c32fede559aa09b45ad847 Bump to 2.3.3
* baa4baf3caa09d8f1a97c564f097053e63d3a75e Multiple Translations updated by Weblate
* 852d62dcf0d5422e2cdb2cc8f87d4fe2dda5d9b9 Fixed: (Torrentday) fix category mapping for TVx265 and add TVUHD (#2593)
* 13493ddbce3faa4d391b08ab38640fc696d68844 Multiple Translations updated by Weblate
* a4a8e890c1fac737d8213dfc9cdaee727d03571e Fixed: (BeyondHD) Add movie prefix to TMDB ID queries [ #2591 ]
* 688434ced9f51d8031f93b1988cf18ebe7069c0c Bump BusyTimeout for SQLite to 1000ms
* 2ed910459f47d52cbc14adf8c75c63d67b298c6e Avoid unique constraints for primary keys in SQLite migrations

*(…release notes truncated — follow the link below for the full list)*

[Full release notes](https://github.com/Prowlarr/Prowlarr/releases/tag/v2.3.5.5327)
