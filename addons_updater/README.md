# Home Assistant add-on: Addons updater

## About

Addons updater is a utility that automatically checks for new releases of upstream projects and updates the add-on version tags in this repository. It monitors GitHub releases for each add-on's upstream source and creates pull requests with version bumps when new releases are detected.

This is the automation engine that keeps the add-ons in this repository up to date. It reads each add-on's `updater.json` to determine the upstream source repository, checks for newer releases, and updates the version in `config.yaml` accordingly.

**Key features:**

- Automatically detects new upstream releases via the GitHub API
- Updates add-on version tags to match the latest upstream release
- Optionally runs on a schedule (typically weekly via CI)
- Dry-run mode for testing without making changes
- Supports date formatting in ISO 8601 format for changelogs

## Installation

1. Add this repository to your Home Assistant instance:
   [![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https://github.com/rezusnet/hassio-addons)
2. Install the "Addons updater" add-on from the add-on store.
3. Configure the add-on options (see below).
4. Start the add-on to check for updates.

**Note:** This add-on is set to `boot: manual` — it does not start automatically with Home Assistant. Run it on-demand or via the weekly CI workflow.

## Configuration

### Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `repository` | string | `rezusnet/hassio-addons` | The GitHub repository to update (in `owner/repo` format). |
| `gituser` | string | `gituser` | GitHub username used to authenticate with the GitHub API. |
| `gitapi` | string | `gitapi` | GitHub personal access token (PAT) with repo write permissions. |
| `gitmail` | string | _(empty)_ | Email address for the Git commit author. |
| `dry_run` | bool | `false` | If `true`, checks for updates but does not commit or push changes. |
| `verbose` | bool | `false` | If `true`, outputs detailed logging information. |
| `date_iso8601` | bool | `true` | Use ISO 8601 date format in changelog entries. |
| `env_vars` | list | `[]` | Custom environment variables. |

### Example configuration

```yaml
repository: rezusnet/hassio-addons
gituser: my-github-username
gitapi: ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
gitmail: me@example.com
dry_run: false
verbose: true
date_iso8601: true
env_vars: []
```

### GitHub token requirements

The `gitapi` token needs the following permissions:

- **Contents** (read/write) — to push version updates and create PRs
- **Pull requests** (read/write) — to create pull requests with the version changes

Create a fine-grained personal access token at [GitHub Settings > Developer settings > Personal access tokens](https://github.com/settings/tokens).

### How it works

1. The add-on scans each add-on directory for an `updater.json` file.
2. Each `updater.json` specifies the upstream GitHub repository to track.
3. The add-on queries the GitHub API for the latest release of each upstream repo.
4. If a newer version is found, it updates the `version` field in the add-on's `config.yaml`.
5. Changes are committed and pushed back to the repository, triggering the builder workflow.

### Dry-run mode

Set `dry_run: true` to see what updates would be applied without actually making any changes. This is useful for testing your configuration before enabling live updates.
