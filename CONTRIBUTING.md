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
- non-LSIO add-ons should set `init: true` explicitly when using `ha_entrypoint.sh`
- set `homeassistant` explicitly to the minimum supported Home Assistant version

### updater.json Contract

Use a consistent updater file shape:

```json
{
  "last_update": "2026-04-26",
  "paused": false,
  "repository": "rezusnet/hassio-addons",
  "slug": "<name>",
  "source": "github",
  "upstream_repo": "owner/repo",
  "upstream_version": "v1.2.3"
}
```

Optional fields:

- `github_beta: true` for repositories where prereleases should be tracked
- `dockerhub_tag_filter` when using `source: dockerhub`
- use JSON booleans (`true` / `false`), not quoted strings

### build.json

```json
{
  "build_from": {
    "aarch64": "lscr.io/linuxserver/<name>:arm64v8-latest",
    "amd64": "lscr.io/linuxserver/<name>:amd64-latest"
  }
}
```

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

ENV PACKAGES="nginx"
COPY ha_autoapps.sh /ha_autoapps.sh
RUN chmod 744 /ha_autoapps.sh && /ha_autoapps.sh "$PACKAGES" && rm /ha_autoapps.sh

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

| Field            | Value                                           | Notes                                            |
| ---------------- | ----------------------------------------------- | ------------------------------------------------ |
| `arch`           | `[aarch64, amd64]`                              | LSIO supports both                               |
| `init`           | `false` for LSIO, `true` for standalone add-ons | Match the actual process model                   |
| `host_network`   | `true`                                          | For apps that need LAN discovery                 |
| `ingress`        | `true`                                          | Web UI apps get sidebar entry                    |
| `ingress_port`   | actual listen port                              | Must match the internal web port used by ingress |
| `ingress_stream` | `true`                                          | TCP proxy, no nginx overlay needed               |
| `image`          | `ghcr.io/rezusnet/<name>-{arch}`                | GHCR image path                                  |
| `map`            | `[addon_config:rw, media:rw, share:rw, ssl]`    | Standard HA folder mappings                      |
| `privileged`     | `[SYS_ADMIN, DAC_READ_SEARCH]`                  | For mount/device access                          |

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

```json
{
  "last_update": "2026-04-26",
  "paused": false,
  "repository": "rezusnet/hassio-addons",
  "slug": "<name>",
  "source": "github",
  "upstream_repo": "linuxserver/docker-<name>",
  "upstream_version": "<version>"
}
```

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
