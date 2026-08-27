## Getting Started

After installing and starting the add-on:

1. Open Raneto via the **HA sidebar** (Ingress) or at `http://<your-ha-ip>:3000`
2. Log in with the default admin credentials or configure your first admin account
3. Create categories and knowledge base articles using markdown
4. Organize documents by category for easy navigation

## Configuration

### Options

| Option          | Type | Default         | Description                                 |
| --------------- | ---- | --------------- | ------------------------------------------- |
| `PGID`          | int  | `0`             | Group ID for file permissions               |
| `PUID`          | int  | `0`             | User ID for file permissions                |
| `data_location` | str  | `/share/raneto` | Path where Raneto stores config and content |
| `TZ`            | str  | `""`            | Timezone (e.g., `Europe/Bucharest`)         |

### Example Configuration

```yaml
PGID: 0
PUID: 0
TZ: "Europe/Bucharest"
data_location: "/share/raneto"
```

## File Access

The add-on maps the following HA directories:

| HA Path         | Container Path                   | Access     |
| --------------- | -------------------------------- | ---------- |
| `/share/raneto` | Configurable via `data_location` | Read/Write |
| `/share/`       | `/share/`                        | Read/Write |
| Add-on config   | `/addon_configs/*/`              | Read/Write |

Content and configuration are stored in the `data_location` directory.

## Ports

| Port   | Protocol | Default | Description        |
| ------ | -------- | ------- | ------------------ |
| `3000` | TCP      | `3000`  | HTTP web interface |

The HTTP port (3000) is enabled by default and accessible via HA Ingress.

## Adding to HA Sidebar

Raneto is available via HA Ingress (sidebar). If it doesn't appear:

1. Go to **Settings > Add-ons > Raneto**
2. Ensure **Show in sidebar** is enabled
3. Reload the HA page

You can also access Raneto directly at `http://<your-ha-ip>:3000` without the sidebar.

## Troubleshooting

### Add-on won't start

- Check logs in **Settings > Add-ons > Raneto > Log**
- Ensure `data_location` is a valid, writable path
- Verify file permissions (PGID/PUID)

### Cannot access the web interface

- Verify the add-on is running and healthy
- Check that port 3000 is mapped correctly
- Try accessing directly at `http://<your-ha-ip>:3000` instead of via Ingress
- Check HA logs for network or container errors

### Data not persisting

- Ensure `data_location` is configured to a persistent location (not a temporary path)
- Verify that the add-on has read/write permissions to the directory
- Check disk space availability at the configured location

## Upstream Documentation

- [Raneto Documentation](https://docs.raneto.com/)
- [Raneto GitHub Repository](https://github.com/gilbitron/Raneto)
- [LinuxServer Raneto Docker Image](https://github.com/linuxserver/docker-raneto)
