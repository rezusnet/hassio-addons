## Getting Started

After installing and starting the add-on:

1. Open Manyfold via the **HA sidebar** (Ingress) or at `http://<your-ha-ip>:3214`
2. Complete the initial setup and create your admin account
3. Configure storage paths and add your 3D model collections

Your 3D models must be accessible to the add-on. Use the `share:rw` mapping to access files, or mount additional drives using the **localdisks** or **networkdisks** options.

## Configuration

### Options

| Option          | Type | Default           | Description                                     |
| --------------- | ---- | ----------------- | ----------------------------------------------- |
| `env_vars`      | list | `[]`              | Custom environment variables (name/value pairs) |
| `PGID`          | int  | `0`               | Group ID for file permissions                   |
| `PUID`          | int  | `0`               | User ID for file permissions                    |
| `data_location` | str  | `/share/manyfold` | Path where Manyfold stores config and database  |
| `TZ`            | str  | `""`              | Timezone (e.g., `Europe/Bucharest`)             |
| `localdisks`    | str  | `""`              | Local drives to mount (e.g., `sda1,sdb1,MYUSB`) |
| `networkdisks`  | str  | `""`              | SMB shares to mount (e.g., `//SERVER/SHARE`)    |
| `cifsusername`  | str  | `""`              | SMB username for network shares                 |
| `cifspassword`  | str  | `""`              | SMB password for network shares                 |
| `cifsdomain`    | str  | `""`              | SMB domain for network shares                   |
| `DOCKER_MODS`   | list | `[]`              | LinuxServer Docker mods for additional features |

### Example Configuration

```yaml
PGID: 0
PUID: 0
TZ: "Europe/Bucharest"
data_location: "/share/manyfold"
networkdisks: "//192.168.1.100/models"
cifsusername: "mediauser"
cifspassword: "mypassword"
env_vars:
  - name: MANYFOLD_URL
    value: "https://manyfold.example.com"
```

### Custom Environment Variables

Use the `env_vars` option to pass any environment variable to Manyfold. Each entry has a `name` and optional `value`:

```yaml
env_vars:
  - name: MANYFOLD_URL
    value: "http://192.168.1.10:3214"
  - name: MANYFOLD_SIDEKIQ_CONCURRENCY
    value: "1"
```

## File Access

The add-on maps the following HA directories:

| HA Path           | Container Path                   | Access     |
| ----------------- | -------------------------------- | ---------- |
| `/share/manyfold` | Configurable via `data_location` | Read/Write |
| `/share/`         | `/share/`                        | Read/Write |
| Add-on config     | `/addon_configs/*/`              | Read/Write |

Model files placed under `/share/` (e.g., via the HA Files add-on or Samba add-on) are directly accessible.

## Mounting Drives

### Local Drives

Use the `localdisks` option to mount local USB, SATA, or NVMe drives. Specify device names, UUIDs, or labels separated by commas:

```yaml
localdisks: "sda1,sdb1,MYUSB"
```

Mounted drives appear under `/mnt/` in the container:

```
/mnt/sda1
/mnt/sdb1
/mnt/MYUSB
```

Configure Manyfold to index files from these paths.

### Network Shares (SMB/CIFS)

Mount SMB/CIFS shares for network-attached model storage:

```yaml
networkdisks: "//192.168.1.100/models"
cifsusername: "user"
cifspassword: "password"
```

Mounted shares appear under `/mnt/smb/` in the container. Restart the add-on after changing network disk settings.

## Ports

| Port | Purpose       |
| ---- | ------------- |
| 3214 | Web interface |

## Troubleshooting

### Models not appearing

- Verify the storage path is accessible: check logs during initialization
- Ensure PUID/PGID match the user who owns the model files
- Restart the add-on after adding paths

### Web interface not loading

- Check that port 3214 is not in use by another service
- Review add-on logs for startup errors
- Ensure the ingress port matches the configured port

### Permission denied errors

- Adjust PUID and PGID to match your user: `id` command shows current user IDs
- Run `chown -R PUID:PGID /path/to/models` on the host

## Upstream Documentation

For more information about Manyfold, visit:

- [Manyfold GitHub](https://github.com/manyfold3d/manyfold)
- [LinuxServer.io Manyfold](https://github.com/linuxserver/docker-manyfold)
