## Getting Started

After installing and starting the add-on:

1. Open the add-on from the Home Assistant sidebar.
2. The ingress landing page opens and redirects you to the full OpenCode UI on port `8230`.
3. Connect your preferred LLM provider in the OpenCode web UI or supply credentials through `env_vars`.
4. Start working in the configured `workspace` directory.

## Configuration

### Options

| Option            | Type     | Default          | Description                                    |
| ----------------- | -------- | ---------------- | ---------------------------------------------- |
| `workspace`       | str      | `/homeassistant` | Working directory for OpenCode                 |
| `server_password` | password | `""`             | Optional password protecting the web UI        |
| `dev_profile`     | list     | `minimal`        | Development tools to install at startup        |
| `repositories`    | list     | `[]`             | Git repositories to clone or update at startup |
| `git_ssh_key`     | password | `""`             | SSH private key for git authentication         |
| `git_token`       | password | `""`             | GitHub token for HTTPS authentication          |
| `custom_packages` | str      | `""`             | Extra apt packages to install                  |
| `TZ`              | str      | `""`             | Timezone                                       |
| `env_vars`        | list     | `[]`             | Custom environment variables                   |

### Repository Entries

Each item in `repositories` supports:

| Field    | Type | Description                  |
| -------- | ---- | ---------------------------- |
| `url`    | str  | Repository URL               |
| `branch` | str? | Optional branch to check out |
| `path`   | str  | Local clone destination      |

### Dev Profiles

| Profile   | Installs                                                       |
| --------- | -------------------------------------------------------------- |
| `minimal` | Base tools only                                                |
| `python`  | Python, pip, and venv                                          |
| `node`    | Node.js and npm                                                |
| `full`    | Python, Node.js, build tools, and common development libraries |

Profiles can be combined.

### Example Configuration

#### Basic Home Assistant workspace

```yaml
workspace: /homeassistant
dev_profile:
  - minimal
repositories: []
```

#### Add-on development workspace

```yaml
workspace: /homeassistant/repos/hassio-addons
dev_profile:
  - full
git_ssh_key: |
  <paste your OpenSSH private key here>
repositories:
  - url: git@github.com:rezusnet/hassio-addons.git
    branch: master
    path: /homeassistant/repos/hassio-addons
```

## Git Authentication

### SSH

1. Generate a deploy key.
2. Add the public key to your Git host.
3. Paste the private key into `git_ssh_key`.
4. Use SSH clone URLs such as `git@github.com:user/repo.git`.

### HTTPS token

1. Create a GitHub token with repository access.
2. Paste it into `git_token`.
3. Use HTTPS URLs such as `https://github.com/user/repo.git`.

## LLM Providers

OpenCode can be configured through its own web UI or via `env_vars`.
Typical examples include:

```yaml
env_vars:
  - name: OPENAI_API_KEY
    value: sk-...
  - name: ANTHROPIC_API_KEY
    value: sk-ant-...
```

## File Access

The add-on maps the following Home Assistant directories with read/write access:

| Path             | Purpose                      |
| ---------------- | ---------------------------- |
| `/homeassistant` | Home Assistant configuration |
| `/addon_configs` | Add-on configuration data    |
| `/addons`        | Add-on source and data       |
| `/media`         | Media files                  |
| `/share`         | Shared files                 |
| `/backup`        | Backups                      |
| `/ssl`           | SSL certificates             |

## Troubleshooting

### OpenCode UI does not load

- Check that the add-on log shows both the landing page and OpenCode server starting
- Try the direct port at `http://<your-ha-ip>:8230`
- If a password is configured, confirm it matches `server_password`

### Repository clone fails

- Verify the repository URL and credentials
- Confirm the destination `path` is writable
- Check whether the selected branch exists

### Missing tools in the workspace

- Add the appropriate `dev_profile`
- Use `custom_packages` for extra system dependencies
- Restart the add-on after changing package configuration

## Upstream Documentation

- [OpenCode GitHub repository](https://github.com/anomalyco/opencode)
- [OpenCode website](https://opencode.ai/)
