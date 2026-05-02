# Contributing

Thank you for your interest in contributing to rezusnet/hassio-addons!

## Development Workflow

### 1. Plan

Open or find an issue describing the add-on. The issue should specify:

- Upstream Docker image (e.g., `lscr.io/linuxserver/sonarr`)
- Web UI port, ingress support, required devices/permissions
- Config options and schema

### 2. Branch

Create a feature branch from master:

```bash
git checkout master
git pull
git checkout -b add-<addon-name>
```

### 3. Implement

Create the add-on directory with all required files (see file manifest below).
Follow the jellyfin add-on as the canonical LSIO reference.

### 4. Lint First (Fast Feedback)

Commit and push. The lint workflow runs on all PRs and is much faster than the build:

- **shellcheck** — bash script analysis
- **shfmt** — shell formatting (`shfmt -i 4 -ci -bn -sr`, use 4-space indentation)
- **hadolint** — Dockerfile linting
- **prettier** — JSON (2-space indent), YAML (2-space), Markdown (padded tables)
- **gitleaks** — secret detection

Fix any lint failures before proceeding.

### 5. Build Test

The PR workflow test-builds Docker images for **amd64** and **aarch64** (via QEMU).
This validates the Dockerfile builds successfully without pushing to GHCR.

### 6. Merge

Once lint + build pass, merge the PR. The builder workflow on master will:

- Build multi-arch images
- Push to `ghcr.io/rezusnet/<addon>-{arch}`
- Update the CHANGELOG

### 7. Verify

After merge, install the add-on from the HA Add-on Store and verify:

- Add-on starts without errors
- Web UI is accessible (Ingress or direct port)
- Configuration options work
- Health check passes

## Adding a New LSIO-Based Addon

Most add-ons in this repo wrap a [LinuxServer.io](https://linuxserver.io) Docker image.
The pattern is nearly identical across all LSIO add-ons — the main differences are port number,
S6 service name, health check endpoint, and config options.

### File Manifest

```text
<addon-name>/
├── config.yaml          # HA addon manifest
├── build.json           # Arch → LSIO image mapping
├── Dockerfile           # 6-section build (see below)
├── updater.json         # Upstream version tracking
├── apparmor.txt         # Security profile (when the add-on needs a custom profile)
├── icon.png             # Addon icon (from upstream)
├── banner.svg           # README hero banner (required unless a committed upstream banner asset is reused)
├── rootfs/
│   └── etc/
│       └── cont-init.d/
│           └── 99-run.sh   # Startup: dirs, env vars, data_location
├── DOCS.md              # Full documentation (Configuration tab)
├── README.md            # Badges + banner + upstream features (Info tab)
└── CHANGELOG.md         # Version history (Changelog tab)
```

### README.md Guidance

Keep `README.md` short, product-facing, and consistent across add-ons. Include:

- status badges: `Version`, `Ingress` when applicable, `Arch`, `Builder`, `Lint`
- a visual banner near the top (`banner.svg` is the default; reuse a committed upstream banner asset only when it is stable and redistributable)
- a one-paragraph description that names both the upstream project and the upstream Docker image
- a **Key features** list that leads with upstream app capabilities, then HA-specific wrapper features
- short installation/access steps plus a pointer to the **Documentation** tab for full configuration details

Avoid README feature lists that only describe the HA wrapper. Users should be able to understand what the upstream application itself does from the README alone.

### DOCS.md Guidance

Keep `DOCS.md` as the full operational reference shown in the Home Assistant **Documentation** tab. Include, when applicable:

- `## Getting Started` with first-launch steps
- `## Configuration` with a full options table and examples
- `## File Access`, `## Ports`, and app-specific setup sections
- `## Troubleshooting`
- `## Upstream Documentation`

`README.md` and `DOCS.md` should complement each other: the README explains what the app is, while `DOCS.md` explains how to run it in Home Assistant.

### icon.png

Every add-on **must** include an `icon.png` in its directory. This icon appears in the Home Assistant Add-on Store and must be:

- A valid PNG image, **128x128** pixels
- Sourced from the upstream project's official repository (e.g., `Logo/128.png` for \*arr apps)
- Committed to the repo alongside `config.yaml` (referenced as `icon: icon.png`)

Do not use placeholder or generic icons. Download the upstream branded logo at 128x128 and commit it directly.

### config.yaml Consistency

The manifest, scripts, and docs must agree:

- every option referenced by startup scripts must exist in both `options` and `schema`
- `url` should point to the upstream project or official site, not this repository
- set `ingress_port` to the actual internal port the ingress proxy should target; never use `0`
- `panel_icon` and `panel_admin` are **top-level** keys (same indent as `name`, `options`), not nested inside `options`
- non-LSIO add-ons should set `init: true` explicitly when using `ha_entrypoint.sh`
- set `homeassistant` explicitly to the minimum supported Home Assistant version

### updater.json — Autoupdate Configuration

Every add-on with an `updater.json` is checked daily by the CI updater (`.github/workflows/addons_updater.yaml`).
When a new upstream version is detected, the updater creates a PR that updates `updater.json`, `config.yaml`,
`build.json`, and `CHANGELOG.md` automatically.

#### Full schema

```json
{
  "slug": "<name>",
  "source": "github",
  "upstream_repo": "owner/repo",
  "upstream_version": "v1.2.3",
  "last_update": "2026-04-26",
  "paused": false,
  "tag_strategy": "direct",
  "tag_keep_v": false,
  "tag_suffix": "",
  "config_extract": null,
  "github_beta": false,
  "dockerhub_tag_filter": ""
}
```

#### Required fields

| Field              | Description                                                 |
| ------------------ | ----------------------------------------------------------- |
| `slug`             | Add-on directory name                                       |
| `source`           | `github`, `github_tags`, or `dockerhub`                     |
| `upstream_repo`    | Upstream `owner/repo` (GitHub) or `library/xx` (Docker Hub) |
| `upstream_version` | Currently tracked upstream version                          |
| `last_update`      | Date of last check/update (ISO format)                      |
| `paused`           | Set `true` to skip this add-on in the updater               |
| `tag_strategy`     | How the updater handles `build.json` (see below)            |

#### Optional fields

| Field                  | Default | Description                                                    |
| ---------------------- | ------- | -------------------------------------------------------------- |
| `github_beta`          | `false` | Track GitHub pre-releases instead of stable releases           |
| `dockerhub_tag_filter` | `""`    | Required suffix filter when `source: dockerhub`                |
| `tag_keep_v`           | `false` | Keep `v` prefix in the Docker image tag                        |
| `tag_suffix`           | `""`    | Suffix appended to the version in the Docker tag               |
| `config_extract`       | `null`  | Set `"semver"` to extract `X.Y.Z` from compound tags           |
| `major_version`        | `""`    | Pin to a specific major version (e.g., `"8"` for `8.x.x` only) |

#### Tag strategies

| Strategy      | `build.json` behavior                                | Use for                                      |
| ------------- | ---------------------------------------------------- | -------------------------------------------- |
| `lsio-latest` | No change (always `{arch}-latest`)                   | LSIO add-ons with floating tags              |
| `lsio-pinned` | Update to `{prefix}:{arch}-{ver}`                    | LSIO add-ons with pinned version tags        |
| `direct`      | Update to `{prefix}:{ver}` (same tag for both archs) | Non-LSIO multi-arch images                   |
| `suffix`      | Update to `{prefix}:{ver}{suffix}`                   | Images needing a tag suffix                  |
| `dockerfile`  | No change (version injected via `BUILD_VERSION` arg) | Add-ons that download binaries in Dockerfile |

#### Examples by strategy

**LSIO with latest tag** (sonarr, radarr, etc.):

```json
{
  "slug": "sonarr",
  "source": "github",
  "tag_strategy": "lsio-latest",
  "upstream_repo": "linuxserver/docker-sonarr",
  "upstream_version": "4.0.17.2952",
  "last_update": "2026-04-26",
  "paused": false
}
```

**LSIO with pinned tag** (jellyfin — needs `config_extract` to strip compound suffix):

```json
{
  "slug": "jellyfin",
  "source": "github",
  "tag_strategy": "lsio-pinned",
  "config_extract": "semver",
  "upstream_repo": "linuxserver/docker-jellyfin",
  "upstream_version": "10.11.8ubu2404-ls30",
  "last_update": "2026-04-27",
  "paused": false
}
```

**Direct multi-arch image** (audiobookshelf):

```json
{
  "slug": "audiobookshelf",
  "source": "github",
  "tag_strategy": "direct",
  "upstream_repo": "advplyr/audiobookshelf",
  "upstream_version": "v2.33.2",
  "last_update": "2026-04-25",
  "paused": false,
  "github_beta": false
}
```

**With tag suffix** (filebrowser `v2.63.2-s6`):

```json
{
  "slug": "filebrowser",
  "source": "github",
  "tag_strategy": "suffix",
  "tag_keep_v": true,
  "tag_suffix": "-s6",
  "upstream_repo": "filebrowser/filebrowser",
  "upstream_version": "v2.63.2",
  "last_update": "2026-04-25",
  "paused": false
}
```

**Dockerfile-installed binary** (opencode — version via `BUILD_VERSION`):

```json
{
  "slug": "opencode",
  "source": "github",
  "tag_strategy": "dockerfile",
  "upstream_repo": "anomalyco/opencode",
  "upstream_version": "v1.14.28",
  "last_update": "2026-04-27",
  "paused": false
}
```

**With major version pinning** (valkey8 — only update within `8.x.x`):

```json
{
  "slug": "valkey8",
  "source": "github",
  "tag_strategy": "suffix",
  "tag_suffix": "-alpine",
  "major_version": "8",
  "upstream_repo": "valkey-io/valkey",
  "upstream_version": "8.1.6",
  "last_update": "2026-05-02",
  "paused": false
}
```

#### RC versioning for local changes

When you make a local change to an add-on (not triggered by an upstream update), use an RC version:

1. Set `config.yaml` version to `{upstream_version}-rc{n}` (e.g., `2.34.0-rc1`)
2. Commit and push — the builder will build and push the RC version
3. When the next upstream version is released, the updater will overwrite the RC with the clean upstream version

Do **not** modify `upstream_version` in `updater.json` for RC releases — only change `config.yaml` version.

### build.json

Pin image tags to a specific version to avoid surprise breakages:

```json
{
  "build_from": {
    "aarch64": "lscr.io/linuxserver/<name>:arm64v8-<version>",
    "amd64": "lscr.io/linuxserver/<name>:amd64-<version>"
  }
}
```

For LSIO add-ons using `tag_strategy: lsio-latest`, the tags stay as `{arch}-latest` and are never modified by the updater.
For other strategies, the updater automatically updates the tags when a new upstream version is detected.

### Dockerfile — 6 Sections

```dockerfile
ARG BUILD_FROM
ARG BUILD_VERSION
FROM ${BUILD_FROM}

ARG BUILD_ARCH
ARG BUILD_VERSION

USER root

# --- Section 2: Modify Image ---
# S6 env vars + ha_lsio.sh patch + sed patches to svc-<name>/run

ENV S6_CMD_WAIT_FOR_SERVICES=0 \
    S6_CMD_WAIT_FOR_SERVICES_MAXTIME=0 \
    S6_SERVICES_GRACETIME=0

COPY ha_lsio.sh /ha_lsio.sh
ARG CONFIGLOCATION="/config"
RUN chmod 744 /ha_lsio.sh && if grep -qr "lsio" /etc; then /ha_lsio.sh "$CONFIGLOCATION"; fi && rm /ha_lsio.sh

RUN \
    sed -i "s|contenv bash|contenv bashio|g" /etc/s6-overlay/s6-rc.d/svc-<NAME>/run && \
    sed -i "1a if [[ \"\$LOCATION\" = \"null\" || -z \"\$LOCATION\" ]]; then LOCATION=/config; fi" /etc/s6-overlay/s6-rc.d/svc-<NAME>/run && \
    sed -i "1a LOCATION=\$(bashio::config 'data_location')" /etc/s6-overlay/s6-rc.d/svc-<NAME>/run && \
    sed -i "s|/config|\$LOCATION|g" /etc/s6-overlay/s6-rc.d/svc-<NAME>/run && \
    sed -i "1a set +u" /etc/s6-overlay/s6-rc.d/svc-<NAME>/run

# --- Section 3: Install Apps ---
COPY rootfs/ /
RUN find . -type f \( -name "*.sh" -o -name "run" -o -name "finish" \) -print -exec chmod +x {} \;

ARG MODULES="00-banner.sh 01-custom_script.sh 00-local_mounts.sh 00-smb_mounts.sh"
COPY ha_automodules.sh /ha_automodules.sh
RUN chmod 744 /ha_automodules.sh && /ha_automodules.sh "$MODULES" && rm /ha_automodules.sh

COPY ha_autoapps.sh /ha_autoapps.sh
RUN chmod 744 /ha_autoapps.sh && /ha_autoapps.sh "" && rm /ha_autoapps.sh

# --- Section 4: Entrypoint ---
ENV S6_STAGE2_HOOK=/ha_entrypoint.sh
COPY ha_entrypoint.sh /ha_entrypoint.sh
RUN chmod 777 /ha_entrypoint.sh
COPY bashio-standalone.sh /usr/local/lib/bashio-standalone.sh
RUN chmod 0755 /usr/local/lib/bashio-standalone.sh

# --- Section 5: Labels ---
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION
ENV BUILD_VERSION="${BUILD_VERSION}"
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="rezusnet (https://github.com/rezusnet)" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="Home Assistant Add-ons" \
    org.opencontainers.image.authors="rezusnet (https://github.com/rezusnet)" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://github.com/rezusnet" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version="${BUILD_VERSION}"

# --- Section 6: Healthcheck ---
ENV HEALTH_PORT="<PORT>" \
    HEALTH_URL="/"
HEALTHCHECK \
    --interval=30s \
    --retries=5 \
    --start-period=60s \
    --timeout=25s \
    CMD curl -A "HealthCheck: Docker/1.0" -s -f "http://127.0.0.1:${HEALTH_PORT}${HEALTH_URL}" &>/dev/null || exit 1
```

### config.yaml — Key Fields

| Field            | Value                                           | Notes                                               |
| ---------------- | ----------------------------------------------- | --------------------------------------------------- |
| `arch`           | `[aarch64, amd64]`                              | LSIO supports both                                  |
| `homeassistant`  | `2024.1.0` (or newer)                           | Minimum supported HA version                        |
| `init`           | `false` for LSIO, `true` for standalone add-ons | Match the actual process model                      |
| `host_network`   | `true`                                          | For apps that need LAN discovery                    |
| `ingress`        | `true`                                          | Web UI apps get sidebar entry                       |
| `ingress_port`   | actual listen port                              | Must match the internal web port used by ingress    |
| `ingress_stream` | `true` when a proxy layer needs TCP streaming   | Omit if the app handles ingress directly (no nginx) |
| `image`          | `ghcr.io/rezusnet/<name>-{arch}`                | GHCR image path                                     |
| `map`            | `[addon_config:rw, media:rw, share:rw, ssl]`    | Standard HA folder mappings                         |
| `panel_icon`     | `mdi:<icon-name>`                               | Top-level key for sidebar icon (ingress add-ons)    |
| `panel_admin`    | `true`                                          | Top-level key: restrict panel to admin users        |
| `privileged`     | `[SYS_ADMIN, DAC_READ_SEARCH]`                  | For mount/device access                             |

### 99-run.sh Template

```bash
#!/usr/bin/env bashio
set -e

bashio::log.info "Starting <Name> add-on initialization"

LOCATION="$(bashio::config 'data_location')"

if bashio::config.has_value 'TZ'; then
  TZ_VAL="$(bashio::config 'TZ')"
  export TZ="${TZ_VAL}"
  bashio::log.info "Timezone set to ${TZ}"
fi

mkdir -p "${LOCATION}/data"

bashio::log.info "Data location: ${LOCATION}"

bashio::log.info "<Name> initialization complete"
```

### updater.json Template

For an LSIO-based add-on:

```json
{
  "last_update": "2026-04-26",
  "paused": false,
  "slug": "<name>",
  "source": "github",
  "tag_strategy": "lsio-latest",
  "upstream_repo": "linuxserver/docker-<name>",
  "upstream_version": "<version>"
}
```

See the [updater.json — Autoupdate Configuration](#updaterjson--autoupdate-configuration) section above for the full schema and all strategy options.

### apparmor.txt Template

Copy from the jellyfin add-on and change the profile name on line 3.

## Adding a Non-LSIO Addon

Non-LSIO add-ons (e.g., opencode, audiobookshelf) use `ha_entrypoint.sh` as the CMD
instead of the LSIO S6 init. Key differences:

- `init: true` in config.yaml (use HA's init system)
- No `ha_lsio.sh` patch
- `CMD ["/ha_entrypoint.sh"]` in Dockerfile
- Entrypoint script manages the process lifecycle

## Lint Requirements

| Tool       | Rules                                                       |
| ---------- | ----------------------------------------------------------- |
| shellcheck | All bash scripts                                            |
| shfmt      | 4-space indentation via `shfmt -i 4 -ci -bn -sr`            |
| hadolint   | Dockerfile best practices                                   |
| prettier   | JSON: 2-space indent, Markdown: padded tables, 2-space code |
| gitleaks   | No secrets in code                                          |

## Commit Convention

- Descriptive commit messages
- `[nobuild]` prefix skips CI builds (reserved for CI bot)
- One add-on per commit preferred

## Autoupdate Pipeline

Add-ons with an `updater.json` are automatically checked for upstream version changes every day.
The pipeline detects new versions, updates all relevant files, opens a PR, and auto-merges it.
The builder then picks up the merged changes and publishes new images.

### Pipeline overview

```text
Daily cron 03:00 UTC (or manual workflow_dispatch)
  │
  ▼
addons_updater.yaml ─ runs updater.sh
  │
  ├─ For each addon with updater.json:
  │   ├─ Fetch latest upstream version (GitHub API / Docker Hub API)
  │   ├─ Compare with current upstream_version
  │   ├─ Skip if unchanged
  │   ├─ Compute config_version and tag_version from tag_strategy
  │   ├─ Verify Docker tag exists on registry (skopeo / curl fallback)
  │   ├─ Skip addon if tag not yet published
  │   └─ Update updater.json, config.yaml, build.json, CHANGELOG.md
  │
  ▼
peter-evans/create-pull-request@v7
  │
  ├─ Detects uncommitted changes from updater.sh
  ├─ Creates branch: updater/bump-YYYYMMDD
  ├─ Commits and pushes
  └─ Opens PR with markdown summary of all version changes
  │
  ▼
Auto-merge step
  │
  ├─ Enables squash auto-merge on the PR
  └─ PR merges once required CI checks pass
  │
  ▼
onpush_builder.yaml (triggered by config.* change on master)
  │
  ├─ Builds amd64 + aarch64 images
  ├─ Pushes to ghcr.io/rezusnet/<addon>-{arch}
  ├─ Runs integration tests
  └─ Updates changelog
```

### Files updated per add-on

| File           | Fields changed                    | When                                              |
| -------------- | --------------------------------- | ------------------------------------------------- |
| `updater.json` | `upstream_version`, `last_update` | Every version change                              |
| `config.yaml`  | `version`                         | Every version change                              |
| `build.json`   | `build_from` tags                 | `lsio-pinned`, `direct`, `suffix` strategies only |
| `CHANGELOG.md` | New `## version (date)` heading   | Every version change                              |

### Tag verification

Before committing an update, the updater verifies the Docker image tag exists on the registry:

| Registry   | Method                                                  |
| ---------- | ------------------------------------------------------- |
| Any        | `skopeo inspect docker://<image>:<tag>` (preferred)     |
| GHCR       | Token-based manifest API (`/v2/<repo>/manifests/<tag>`) |
| Docker Hub | Tag list API (`/v2/repositories/<repo>/tags/<tag>`)     |

If a tag does not exist yet (upstream released source but image not published), the add-on is **skipped**
and retried the next day. This prevents build failures from missing base images.

### Pre-release filtering

The GitHub release fetcher excludes tags matching:

- Suffixes: `-rc`, `-beta`, `-alpha`, `-dev`, `-pre`
- Prefixes: `nightly-`

Override with `github_beta: true` in `updater.json` to accept the latest release regardless (used by `lightrag`).

### Version computation by strategy

For each `tag_strategy`, the updater derives two values from `upstream_version`:

| Strategy      | config.yaml version    | build.json tag                              | Example                                       |
| ------------- | ---------------------- | ------------------------------------------- | --------------------------------------------- |
| `lsio-latest` | Strip `v` prefix       | No change (`{arch}-latest`)                 | `4.0.17.2952` → config `4.0.17.2952`          |
| `lsio-pinned` | Extract semver `X.Y.Z` | `{prefix}:{arch}-{semver}`                  | `10.11.8ubu2404-ls30` → config `10.11.8`      |
| `direct`      | Strip `v` prefix       | `{prefix}:{tag_version}`                    | `v2.33.2` → config `2.33.2`, tag `2.33.2`     |
| `suffix`      | Strip `v` prefix       | `{prefix}:{tag_version}{tag_suffix}`        | `v2.63.2` → config `2.63.2`, tag `v2.63.2-s6` |
| `dockerfile`  | Strip `v` prefix       | No change (version via `BUILD_VERSION` arg) | `v1.14.28` → config `1.14.28`                 |

### RC versioning workflow

When you need to ship a fix that is not tied to an upstream version bump:

1. Edit `config.yaml` version: change `"2.34.0"` to `"2.34.0-rc1"`
2. Do **not** modify `updater.json`
3. Commit, push, and merge — the builder publishes the RC version
4. When the next upstream version lands, the updater overwrites the RC automatically

The updater only acts when `upstream_version` changes, so RC versions persist until the next upstream release.

### Troubleshooting

| Symptom                                         | Cause                                        | Fix                                                          |
| ----------------------------------------------- | -------------------------------------------- | ------------------------------------------------------------ |
| Add-on not updated despite new upstream release | Docker tag not published yet                 | Will be retried next day; verify tag on registry             |
| Add-on not updated                              | `paused: true` in updater.json               | Set `paused: false`                                          |
| Add-on not updated                              | Missing `tag_strategy` in updater.json       | Add the required field (see schema above)                    |
| PR not created                                  | No version changes detected (all up to date) | Check `upstream_version` matches the latest upstream tag     |
| PR not created                                  | Workflow ran with `dry_run: true`            | Re-run without dry run                                       |
| Build not triggered after PR merge              | Commit message contains `[nobuild]`          | Remove `[nobuild]` prefix                                    |
| Build not triggered after PR merge              | Only non-config files changed                | Builder triggers on `config.*` path changes only             |
| Audiobookshelf update skipped                   | GHCR image tag not available yet             | Upstream publishes source before Docker image; retried daily |
| Nightly/RC build picked up for LSIO add-on      | Upstream repo tagged a pre-release           | Filter already excludes nightly/rc/beta/alpha/dev/pre        |

### Manual invocation

Trigger the updater manually with verbose logging and no changes pushed:

```bash
gh workflow run addons_updater.yaml -f dry_run=true -f verbose=true
```

Run for real (creates PR if changes found):

```bash
gh workflow run addons_updater.yaml -f dry_run=false -f verbose=true
```

Run the updater script locally (no GitHub Actions required):

```bash
DRY_RUN=true VERBOSE=true GITHUB_WORKSPACE=. GITHUB_OUTPUT=/dev/null \
    bash .github/scripts/updater.sh
```
