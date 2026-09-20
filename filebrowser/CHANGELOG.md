<!-- markdownlint-disable -->
<!-- Changelog entries mirror upstream release notes verbatim; upstream formatting is intentionally preserved, so style rules are disabled for this file. -->

## 2.63.23 (2026-07-28)

Updated to upstream File Browser **2.63.23**:

File Browser is winding down and this is the last planned release. The repository is archived on **2026-09-01**. After that date there will be no further releases, bug fixes, or security fixes. Existing releases and Docker images stay online and will not be withdrawn.

This release changes the links from filebrowser.org to this repository directly, to avoid link breakage in the future.

### Changelog
* e8a388f840173580116f2743813d03b22286e44e chore(release): 2.63.23
* 0dfe44649c79deeeaa449041440a277656f1dfc6 docs: cleanup header
* 05ee853eefd356128849c667081665f9ce05c85e docs: clear inconsistencies, point at repo instead of website

[Full release notes](https://github.com/filebrowser/filebrowser/releases/tag/v2.63.23)

## 2.63.21 (2026-07-27)

Updated to upstream File Browser **2.63.21**:

### Changelog
* f6fb8f6bf52d714b2215534033a3c96316069efc chore(release): 2.63.21
* e6d70cf24c0cd79a1787601dc99104ec7e7ca3ef fix(http): canonicalize paths before checking access rules (#6045)
* 41e2b1bbbae47e12cedb684f49964df77fe710c7 docs: update CLAUDE.md
* 41b01a7404c1a278284a03bf6f3b56ce440b997a chore: update Go deps
* 0dd89058867f87a7bc04aa7517d21528a280e27c Revert "chore(deps): update all non-major dependencies (#5946)"
* 032271bafab16b6d36236c46ac0d832f60e0f435 chore(deps): update all non-major dependencies (#5946)

[Full release notes](https://github.com/filebrowser/filebrowser/releases/tag/v2.63.21)

## 2.63.20 (2026-07-26)

Updated to upstream File Browser **2.63.20**:

### Changelog
* 50125a5d21c9f5e9a78db80d77a26139614ce72e chore(release): 2.63.20
* bc3d75a94a4b921fb24e2ebc231fb35e4e14064f test(users): cover concurrent provisioning into one scope
* fb6aeba9eae7b8eb401e0db325973781e1ffd08b fix(users): make the provisioned scope check atomic with the save
* 67e893eee7ee411e166d3fcd759a87b6f0971277 fix: use aria-selected
* 4a4b0f8c840f1f83be09495d54d964da5c52f5e1 docs: update CLAUDE instructions
* 660d84661d32b271a037e4af25856833d49dca99 docs: update CLAUDE.md
* 392253c5636c8e9a1d4d0d46c94c70b8134187c6 docs: update SECURITY.md and add CLAUDE.md

[Full release notes](https://github.com/filebrowser/filebrowser/releases/tag/v2.63.20)

## 2.63.18 (2026-07-05)

Updated to upstream File Browser **2.63.18**:

### Changelog
* fe7efb2e6afe66774cd86a5b0a03033bd514d0c0 chore(release): 2.63.18
* 2651260a1ccab6d7b30e065de05992818acdb65b chore: update translations
* 4470288ba1828a14453a99348fd22c62aa0b9460 fix: deduplicate PT language
* 58d22578e8d7517420feda161fcb9d4749518690 chore: update dependencies
* dfc2e887e1a19d54984a0d7e39a2a63caf73ef19 fix: avoid recursive conflict checks for copy and move (#6009)
* aac25166378422135e624e305c410c54a39374fb fix(preview): keep the EPUB table-of-contents button clear of the header (#6010)
* c05ead7e8e23b6d6c9c9e11271bf8d5e74169f4a docs: warning about hook executor

[Full release notes](https://github.com/filebrowser/filebrowser/releases/tag/v2.63.18)

## 2.63.17 (2026-06-28)

Updated to upstream File Browser **2.63.17**:

### Changelog
* d76b7d161099853f17e71b1327ce4545a30c27a2 chore(release): 2.63.17
* f30fca636c1af9ef401e9a82ff60391cb3db97e1 fix(share): delete exact directory share on trailing-slash delete (GHSA-pp88-jhwj-5qh5)
* ec130546713c44cd24556907552ac554c7f809c9 fix(share): stop exposing password hash and bypass token in share API (GHSA-833g-cqhp-h72j)
* 883a36f02fcb69566a8628cb47f18fdc73348387 fix(auth): reject signup when normalized home dir collides (GHSA-7rc3-g7h6-22m7)
* 8503ba61ff51d48a7313896483d130eb6a5abfe0 fix(raw): neutralize backslashes in archive entry names (GHSA-83xp-526h-j3ww)
* 1fb05d65de98f8dc341409f40d382297ca75bcf0 docs,cmd: warn about broad scope for self-signup users (GHSA-6759-996p-gpj6)
* 2472fbcd30502606feb11fbc8b8dc4f3803e6641 fix: normalize recursive listing paths to forward slashes (#6003)
* 43a404ca69bf25553bfbbb2b446f0f53077c6302 fix: match admin share paths by owner scope (#5992)
* d9cf2f0100d2c4892cad8e339eacca96df1aa5b6 fix: preserve SRT subtitle line breaks (#6002)
* 6209f8fddd0f279b4d57571c0d5bb114affc1942 chore: update translations (#5990)

[Full release notes](https://github.com/filebrowser/filebrowser/releases/tag/v2.63.17)

## 2.63.16 (2026-06-24)

Updated to upstream File Browser **2.63.16**:

### Changelog
* bd1520fe095d2f373f8fbcbfc01f855ade7e90fb chore(release): 2.63.16
* 8cfa6a175f428f89ef2c349e3d43166ee0c60135 chore(docs): update CLI documentation
* a1063925e15ef27f9d5dc26aae371bbf52af608c fix: restore symlink behavior as opt-in followExternalSymlinks
* 64511ce45e3be379e965f7f4fb0929a068d5bb81 fix: dangling symlink, write, delete scope bugs

[Full release notes](https://github.com/filebrowser/filebrowser/releases/tag/v2.63.16)

## 2.63.15 (2026-06-13)

Updated to upstream File Browser **2.63.15**:

### Changelog
* be23ab3a15bf957928ecfed88de5ab67850c1b9c chore(release): 2.63.15
* ffb486e05fe0d38f09a3067d1f16a71628726d15 chore: bump minor Go dependencies
* 403d2bbd3357aa57e78745b52dcdad3490901bb3 fix: restore ScopedFs RealPath (#5986)

[Full release notes](https://github.com/filebrowser/filebrowser/releases/tag/v2.63.15)

## 2.63.14 (2026-06-08)

Updated to upstream File Browser **2.63.14**:

### Changelog
* dfe6e5b333e3211dd6ced146672657de598299c7 chore(release): 2.63.14
* d9816b153194198d717e14cdbe32f83ef57e076c chore: add symlink tests
* 7c2c0a11b31b2bb214d741005a0b02b1764208b3 refactor: ScopedFs to avoid escaping symlinks
* 3406d3d7f98dfc3c16e4ff7ff4a87e3bdfe221dd fix: recursive check

[Full release notes](https://github.com/filebrowser/filebrowser/releases/tag/v2.63.14)

## 2.63.13 (2026-06-07)

Updated to upstream File Browser **2.63.13**:

### Changelog
* 67ed670d92966e0c8b57d7b726572be6b905fe8a chore(release): 2.63.13
* a1a514dcbb216d2080412c5354eea1e1fb033050 fix: copy/move allow overwrite
* 5f7311d32437e98d7c14c7b307a4f68109275535 refactor: cleanup and simplify upload.ts

[Full release notes](https://github.com/filebrowser/filebrowser/releases/tag/v2.63.13)

## 2.63.12 (2026-06-05)

Updated to upstream File Browser **2.63.12**:

### Changelog
* 998bd95bfad1a9fbb81d214a77b168a393639718 chore(release): 2.63.12
* c1abe8f561208bf36bde70879d1a15ef9de998fa fix: await copy move conflict detection (#5978)
* 0bb2768754d11b865d68e72dcd7cebb232a6308a fix: keep mobile file sort controls visible (#5977)
* 7b7ff8ae8f97393b2e6ae6e061c1f780077c32b6 fix: skip inaccessible children when listing directories (#5958)

[Full release notes](https://github.com/filebrowser/filebrowser/releases/tag/v2.63.12)

## 2.63.10 (2026-06-04)

Updated to upstream File Browser **2.63.10**:

### Changelog
* 69c76d11cc865e1d959f715f7b35bb905c14079f chore(release): 2.63.10
* 6b04cbf5e9db1f5b9c0b1624843607ce2881cfc4 fix: allow writes when user scope resolves to filesystem root

[Full release notes](https://github.com/filebrowser/filebrowser/releases/tag/v2.63.10)

## 2.63.5 (2026-05-24)

Updated to upstream File Browser **2.63.5**:

### Changelog
* a1e442ef9e4a14719184bf02c50dbc981ecf8665 chore(release): 2.63.5
* 6ad8160aa3309314c1b471c5090b67c824464396 fix(router): handle undefined catchAll param on root redirect (#5955)

[Full release notes](https://github.com/filebrowser/filebrowser/releases/tag/v2.63.5)

## 2.63.4 (2026-05-19)

Updated to upstream File Browser **2.63.4**:

### Changelog
* 22b848f26ef8ae889eef132232dbd0de347e0efd chore(release): 2.63.4
* a418dd6bb367a609cb38835f9a76e94df995f37e chore: revert node dependencies updates
* d978d1eccae6127618681333490afa0613e7d2ec chore: sync translations (#5945)
* 9cc18a81e3e1b8bf96795bfbe3d83ced294ecfd7 fix: show item shares from all users to admins (#5941)
* e38c28273aa85329fd9d796c1dd66fa07289b1ab chore: fix typo
* da2dff0933e7f8795ba39fe2bad88d0e0dab66f4 chore: sync translations
* 261bca67bc7e0a4c188cb8d57522998ae9fdb735 chore(deps): update all non-major dependencies (#5929)

[Full release notes](https://github.com/filebrowser/filebrowser/releases/tag/v2.63.4)

## 2.63.3 (2026-05-12)

Updated to upstream File Browser **2.63.3**:

### Changelog
* ca5e249e3c0c94159c2136a0cd431a424eb18472 chore(release): 2.63.3
* f4e148523e0dc9242081831b53544396f995c611 fix: Fix conflict modal and add a resume transfert option (#5884)
* 1f22fe65ecc41ff9ca6dc3128bb914793dd5b44f chore(deps): update all non-major dependencies (#5926)
* e2bdf6f747dc90123a555ba58390aff2e34bf9dd chore: update translations
* d236f1c563eee40488ee9cea0745bda4f2b261a4 chore(deps): update dependency marked to v18 (#5897)
* 4edf425a9fae15b7e555b033f33c77ddf1302f61 chore(i18n): add a translation for disk usage (#5916)
* a1a7ac4f04706200cdd29a86951a84b7e5461520 chore: update translations (#5918)
* 74917c80370ef97e3cb973ab2a751d0aa61d4c62 chore(deps): update all non-major dependencies (#5915)
* 7bd27f5e823651420cedd87a6c6503b1a954a4dd chore: sync translations (#5901)
* 9f4288b1b4e8e197ec2ec2ca093e7bf761efd142 docs: Update documentation links in Global.vue (#5905)
* 41b801d30c736c8ca863e2be6aece7d99e92129e fix: correct environment variable in compose.yaml (#5910)
* da6b7ac26b7d2dce84131435885e144492859146 chore(deps): update all non-major dependencies (#5912)
* 7f8b920aa4c2eb22d22bad7763e7fd880b63333d chore(deps): update actions/upload-pages-artifact action to v5 (#5913)
* dd53644acbecd7b8b788396aa8dd133ae006382c chore(release): 2.63.2
* 9b80a9aa6cf87700624fa6e0ba5fe8eac71d84d7 chore(deps): update all non-major dependencies (#5870)
* 0321415a152b6c20e44c6f4afbffd0ed34919e22 chore: pull translations (#5871)
* 23e84c997422ef058dc8e348cba75e77b23aaf84 docs: update PR template
* 0fadf28b18e506ddca0027e83ebe567ac57932bf fix(preview): let arrow keys seek video instead of switching files (#5895)
* 871f33789259d644ec3ed89aa38f6bf20b72c42a chore(deps): update pnpm/action-setup action to v6 (#5898)

[Full release notes](https://github.com/filebrowser/filebrowser/releases/tag/v2.63.3)

## 2.63.2 (2026-04-25)

Updated to upstream File Browser **2.63.2**:

### Changelog
* 7970c26cbcb8c7dc8abf12f95fe2b97d6c89d577 chore(release): 2.63.2

[Full release notes](https://github.com/filebrowser/filebrowser/releases/tag/v2.63.2)

## 2.63.1 (2025-04-11)

- Initial release in rezusnet/hassio-addons
- Based on filebrowser/filebrowser v2.63.1

### Upstream File Browser 2.63.1

### Changelog
* 29c73eaca6a7b91f0de3c73536a0d0a21eeda03e chore(release): 2.63.1
* f13c7c8cffd6d58ff29c4a6763ced1385f69961e fix: restrict default permissions for proxy-auth auto-provisioned users (#5890)
* 1e03feadb550e4414b5589a6a8df57f538efba15 fix: check download permission in resource handler (#5891)
* 8adf127c7d33585333b8030869f6f318e6517179 fix: enforce directory boundary in rule path matching (#5889)
* 7dbf7a3528234b2a9ee9c4115e8ecf58d258ca51 fix: check share owner permissions on public share access (#5888)

[Full release notes](https://github.com/filebrowser/filebrowser/releases/tag/v2.63.1)
