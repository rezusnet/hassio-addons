## Getting Started

After installing and starting the add-on:

1. Open Pwndrop via the **HA sidebar** (Ingress) or at `http://<your-ha-ip>:8080`
2. Start sharing files securely with others using generated links
3. Configure data storage location if needed (see Configuration section)

## Configuration

### Options

| Option          | Type | Default          | Description                            |
| --------------- | ---- | ---------------- | -------------------------------------- |
| `PGID`          | int  | `0`              | Group ID for file permissions          |
| `PUID`          | int  | `0`              | User ID for file permissions           |
| `data_location` | str  | `/share/pwndrop` | Path where Pwndrop stores shared files |
| `TZ`            | str  | `""`             | Timezone (e.g., `Europe/Bucharest`)    |

### Example Configuration

```yaml
PGID: 0
PUID: 0
TZ: "Europe/Bucharest"
data_location: "/share/pwndrop"
```

## File Access

The add-on maps the following HA directories:

| HA Path          | Container Path                   | Access     |
| ---------------- | -------------------------------- | ---------- |
| `/share/pwndrop` | Configurable via `data_location` | Read/Write |
| `/share/`        | `/share/`                        | Read/Write |
| Add-on config    | `/addon_configs/*/`              | Read/Write |

Files placed under the configured `data_location` are accessible via Pwndrop.

## Ports

| Port   | Protocol | Default | Description        |
| ------ | -------- | ------- | ------------------ |
| `8080` | TCP      | `8080`  | HTTP web interface |

The HTTP port (8080) is enabled by default. You can access Pwndrop through the HA Ingress sidebar or directly at the mapped port.

## Adding to HA Sidebar

Pwndrop is available via HA Ingress (sidebar). If it doesn't appear:

1. Go to **Settings > Add-ons > Pwndrop**
2. Ensure **Show in sidebar** is enabled
3. Reload the HA page

You can also access Pwndrop directly at `http://<your-ha-ip>:8080` without the sidebar.

## Troubleshooting

### Add-on won't start

- Check logs in **Settings > Add-ons > Pwndrop > Log**
- Ensure `data_location` is a valid, writable path
- Verify sufficient disk space is available

### Files not accessible

- Ensure files are placed in the configured `data_location`
- Check file permissions match PGID/PUID settings
- Verify the path exists and has read/write permissions

### Cannot access web interface

- Check that port 8080 is not in use by another service
- Verify network connectivity and firewall rules
- Check add-on logs for startup errors

## Upstream Documentation

- [Pwndrop GitHub Repository](https://github.com/kiwix/pwndrop)
- [LinuxServer Pwndrop Image](https://github.com/linuxserver/docker-pwndrop)
