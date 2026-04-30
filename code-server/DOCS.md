## Getting Started

After installing and starting the add-on:

1. Open Code Server via the **HA sidebar** (Ingress) or at `https://<your-ha-ip>:8443`
2. If a password is configured, authenticate with it
3. You're ready to code! The workspace is stored in your configured `data_location`

## Configuration

### Options

| Option               | Type | Default              | Description                                               |
| -------------------- | ---- | -------------------- | --------------------------------------------------------- |
| `env_vars`           | list | `[]`                 | Custom environment variables (name/value pairs)           |
| `PGID`               | int  | `0`                  | Group ID for file permissions                             |
| `PUID`               | int  | `0`                  | User ID for file permissions                              |
| `data_location`      | str  | `/share/code-server` | Path where Code Server stores configuration and workspace |
| `TZ`                 | str  | `""`                 | Timezone (e.g., `Europe/Bucharest`)                       |
| `PASSWORD`           | str  | `""`                 | Plain text password (optional, not recommended)           |
| `HASHED_PASSWORD`    | str  | `""`                 | Hashed password (preferred method for security)           |
| `SUDO_PASSWORD`      | str  | `""`                 | Plain text sudo password (optional)                       |
| `SUDO_PASSWORD_HASH` | str  | `""`                 | Hashed sudo password (preferred method for security)      |
| `DOCKER_MODS`        | list | `[]`                 | LinuxServer Docker mods for additional features           |

### Example Configuration

```yaml
PGID: 0
PUID: 0
TZ: "Europe/Bucharest"
data_location: "/share/code-server"
PASSWORD: "mypassword123"
env_vars:
  - name: DEFAULT_WORKSPACE
    value: "/config"
  - name: EXTENSION_IDS
    value: "ms-python.python ms-vscode.cpptools"
```

### Custom Environment Variables

Use the `env_vars` option to pass any environment variable to Code Server. Each entry has a `name` and optional `value`:

```yaml
env_vars:
  - name: CODE_SERVER_AUTH
    value: "password"
  - name: PROXY_DOMAIN
    value: "code.example.com"
```

### Password Authentication

#### Using Plain Text Password

```yaml
PASSWORD: "your-secure-password"
```

#### Using Hashed Password (Recommended)

To generate a hashed password, run this command in the Code Server terminal or locally:

```bash
echo -n "your-password" | sha256sum | cut -d' ' -f1
```

Then use the hash:

```yaml
HASHED_PASSWORD: "<your-sha256-hash>"
```

## File Access

Your home directory is `/root`, but you typically want to work in `/config` (your Home Assistant configuration directory) or `/share` (shared files). You can navigate to these in the Code Server UI.

## Ports

| Port | Type | Description        |
| ---- | ---- | ------------------ |
| 8443 | TCP  | Code Server web UI |

## Troubleshooting

### Can't access Code Server

- Ensure the add-on is running (check add-ons page in Home Assistant)
- Check if port 8443 is not blocked by firewall
- If using Ingress, ensure it's enabled in the add-on config

### Password authentication not working

- Verify `PASSWORD` or `HASHED_PASSWORD` is set correctly
- Check add-on logs for authentication errors
- Ensure special characters in passwords are properly escaped

### Extensions not installing

- Check network connectivity from within the container
- Some extensions may require additional system packages
- See DOCKER_MODS for available extensions and tools

### SSH/Git not working

- Generate SSH keys in Code Server's integrated terminal
- Store them in `/root/.ssh` (mapped to your data_location)
- Set up git config:
  ```bash
  git config --global user.name "Your Name"
  git config --global user.email "your@email.com"
  ```

## Upstream Documentation

For more information about Code Server, visit [https://coder.com](https://coder.com) or the [GitHub repository](https://github.com/cdr/code-server).
