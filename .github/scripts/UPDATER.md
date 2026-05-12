# Updater System

The autoupdate system is a **universal, config-driven pipeline**. The CI script (`updater.sh`) contains **zero add-on-specific logic**. Every add-on customizes its behavior exclusively through its local `updater.json` file.

## How It Works

1. **Daily at 03:00 UTC**, the `addons_updater.yaml` workflow runs `updater.sh`.
2. The script iterates every `*/updater.json`, fetches the latest upstream version, compares with the current version, and writes changes to `updater.json`, `build.json`, `config.yaml`, and optionally `CHANGELOG.md`.
3. A PR is created and auto-merged via `gh pr merge --squash --admin`.
4. The `onpush_builder.yaml` workflow detects changed `config.*` files, builds new images, and pushes to GHCR.

## `updater.json` Schema Reference

All fields are optional unless marked **required**.

### Identity

| Field | Type | Default | Description |
|---|---|---|---|
| `slug` | string | *(dir name)* | Add-on directory name. Used in log messages and PR body. |
| `repository` | string | `""` | This repo (e.g. `rezusnet/hassio-addons`). Cosmetic only — not read by the script. |

### Source Configuration

| Field | Type | Default | Description |
|---|---|---|---|
| `source` **(required)** | string | `"github"` | Where to fetch the latest version. One of: `github`, `github_tags`, `dockerhub`. |
| `upstream_repo` **(required)** | string | `""` | Upstream repository in `owner/repo` format (GitHub) or `org/name` format (Docker Hub). |
| `paused` | bool | `false` | Set to `true` to skip this add-on entirely. |

### Source-Specific Options

| Field | Type | Source | Description |
|---|---|---|---|
| `github_beta` | bool | `github` | When `true`, fetches the single most recent release including pre-releases. When `false` (default), filters out tags containing `rc`, `beta`, `alpha`, `dev`, `pre`, or starting with `nightly`. |
| `dockerhub_tag_filter` | string | `dockerhub` | Required substring in Docker Hub tag name (e.g. `"-alpine"`). Tags not containing this string are skipped. |

### Tag Strategy

| Field | Type | Default | Description |
|---|---|---|---|
| `tag_strategy` **(required)** | string | `""` | How the Docker image tag is constructed. See **Tag Strategies** below. |
| `tag_keep_v` | bool | `false` | Keep the `v` prefix from the upstream tag (e.g. `v2.0.0` stays `v2.0.0`). |
| `tag_suffix` | string | `""` | Suffix appended to the tag (e.g. `"-alpine"`, `"-s6"`). Used by `suffix` strategy. |
| `major_version` | string | `""` | Pin to a specific major version line (e.g. `"9"` for valkey 9.x). Tags with a different major version are skipped. |

### Version Computation

| Field | Type | Default | Description |
|---|---|---|---|
| `config_extract` | string | `""` | Set to `"semver"` to extract only `MAJOR.MINOR.PATCH` from the upstream tag (e.g. `10.11.8ubu2404-ls30` → `10.11.8`). |
| `build_suffix` | string | `""` | Appended to the config version **without affecting upstream tracking**. See **Local Build Versioning** below. |

### Metadata

| Field | Type | Description |
|---|---|---|
| `upstream_version` | string | Last known upstream version. Written by the updater. Used for comparison on next run. |
| `last_update` | string | ISO date of last update check. Written by the updater. |

## Tag Strategies

| Strategy | `build.json` updated? | Tag format | Use case |
|---|---|---|---|
| `lsio-latest` | No (uses `:latest`) | `lscr.io/<repo>:latest` | LSIO add-ons that always pull latest image |
| `lsio-pinned` | Yes | `lscr.io/<repo>:arm64v8-<ver>` / `amd64-<ver>` | LSIO add-ons with pinned version tags |
| `direct` | Yes | `<repo>:<ver>` | Direct image reference, both archs share same tag |
| `suffix` | Yes | `<repo>:<ver><suffix>` | Tags with a suffix like `-alpine`, `-s6` |
| `dockerfile` | No | N/A | Version is embedded in the Dockerfile itself (e.g. via build-arg) |

## Local Build Versioning

When you make a **local change** to an add-on (nginx config fix, startup script change, etc.) that requires HAOS to pull a new image, you need to bump the version in `config.yaml`. However, you **must not** change the upstream version string, because the updater compares `upstream_version` in `updater.json` with the latest upstream release.

### The Problem

If the upstream is at `1.2.3` and you locally change `config.yaml` to `1.2.4` to force a pull, the updater will see:
- Upstream latest: `1.2.3`
- Your config: `1.2.4`
- It won't update because `1.2.4 > 1.2.3`, and when upstream releases `1.2.4` for real, you're already on it — the update is silently skipped.

### The Solution: `build_suffix`

Use the `build_suffix` field in `updater.json` to append a local build counter:

```json
{
  "build_suffix": ".1",
  "upstream_version": "1.2.3",
  ...
}
```

This produces a config version of `1.2.3.1` — a **4-part semver** that:
- Is **greater than** `1.2.3`, so HAOS sees it as a new version and pulls the image
- Does **not conflict** with upstream `1.2.4` when it's released (the updater will correctly detect `1.2.4 > 1.2.3` and update)
- Preserves the upstream version in `upstream_version` for accurate comparison

### Versioning Rules

1. **Standard upstream versions** use standard 3-part semver: `MAJOR.MINOR.PATCH` (e.g. `1.2.3`)
2. **Local builds** append an integer counter: `MAJOR.MINOR.PATCH.N` (e.g. `1.2.3.1`, `1.2.3.2`)
3. **Pre-release tags** like `rc1` are handled naturally: `v1.5.0rc1` stays as-is
4. **Non-semver tags** like MinIO's `RELEASE.2026-04-17T00-00-00Z` append the suffix directly: `RELEASE.2026-04-17T00-00-00Z.1`
5. When the **upstream** releases a new version, the updater resets the config version to the new upstream version (without suffix). Set `build_suffix` back to `""` or increment if further local changes are needed.

### Workflow

1. Make local change to add-on
2. Increment `build_suffix` in `updater.json` (e.g. `""` → `".1"`, `".1"` → `".2"`)
3. Commit and push — the builder will build the image with the new version
4. HAOS sees the new version and pulls the image
5. When upstream releases a new version, the updater auto-updates and the suffix is preserved until you reset it

## Adding a New Add-on

1. Create the add-on directory with `config.yaml`, `Dockerfile`, `build.json`, etc.
2. Create `updater.json` with the appropriate fields (see schema above).
3. The next daily updater run (or manual `workflow_dispatch`) will pick it up automatically.

No changes to `updater.sh` or `addons_updater.yaml` are needed — the system is fully config-driven.
