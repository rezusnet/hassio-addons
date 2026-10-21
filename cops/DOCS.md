## Getting Started

After installing and starting the add-on:

1. Open COPS via the **HA sidebar** (Ingress) or at `http://<your-ha-ip>:80`
2. Configure the path to your Calibre library in the COPS interface
3. Access the OPDS feed at `http://<your-ha-ip>:80/feed` for e-readers and mobile apps

Your Calibre library must be accessible to the add-on. Use the `share:rw` mapping (pre-configured) to access files under `/share/`, or mount additional drives using the **localdisks** or **networkdisks** options.

## Configuration

### Options

| Option          | Type | Default       | Description                                  |
| --------------- | ---- | ------------- | -------------------------------------------- |
| `env_vars`      | list | `[]`          | Custom environment variables                 |
| `PGID`          | int  | `0`           | Group ID for file permissions                |
| `PUID`          | int  | `0`           | User ID for file permissions                 |
| `data_location` | str  | `/share/cops` | Path where COPS stores config                |
| `TZ`            | str  | `""`          | Timezone (e.g., `Europe/Bucharest`)          |
| `localdisks`    | str  | `""`          | Local drives to mount (e.g., `sda1`)         |
| `networkdisks`  | str  | `""`          | SMB shares to mount (e.g., `//SERVER/SHARE`) |
| `cifsusername`  | str  | `""`          | SMB username for network shares              |
| `cifspassword`  | str  | `""`          | SMB password for network shares              |
| `cifsdomain`    | str  | `""`          | SMB domain for network shares                |

### Example Configuration

```yaml
PGID: 0
PUID: 0
TZ: "Europe/Bucharest"
data_location: "/share/cops"
networkdisks: "//192.168.1.100/books"
cifsusername: "mediauser"
cifspassword: "mypassword"
env_vars:
  - name: COPS_TITLE
    value: "My Book Library"
```

## File Access

The add-on maps the following HA directories:

| HA Path       | Container Path                   | Access     |
| ------------- | -------------------------------- | ---------- |
| `/share/cops` | Configurable via `data_location` | Read/Write |
| `/share/`     | `/share/`                        | Read/Write |
| Add-on config | `/addon_configs/*/`              | Read/Write |

Your Calibre database should be placed under `/share/` or mounted as a network share for COPS to access it.

## Mounting Drives

### Local Drives

Use the `localdisks` option to mount local USB, SATA, or NVMe drives:

```yaml
localdisks: "sda1,sdb1,MYUSB"
```

Drives are mounted under `/mnt/` in the container (e.g., `/mnt/sda1`, `/mnt/MYUSB`).

### Network Shares (SMB/CIFS)

Use the `networkdisks` option to mount remote SMB/CIFS shares:

```yaml
networkdisks: "//192.168.1.100/books"
cifsusername: "myuser"
cifspassword: "mypassword"
cifsdomain: "workgroup"
```

Multiple shares can be separated by commas. Shares are mounted under `/mnt/`.

## Ports

| Port | Protocol | Default | Description        |
| ---- | -------- | ------- | ------------------ |
| `80` | TCP      | `80`    | HTTP web interface |

The HTTP port (80) is enabled by default and provides access to both the HTML web interface and OPDS feed.

## Adding to HA Sidebar

COPS is available via HA Ingress (sidebar). If it doesn't appear:

1. Go to **Settings > Add-ons > COPS**
2. Ensure **Show in sidebar** is enabled
3. Reload the HA page

You can also access COPS directly at `http://<your-ha-ip>:80` without the sidebar.

## Configuration via COPS Web Interface

COPS configuration is done through its web interface at `http://<your-ha-ip>:80/config.php` (if accessible) or via `local.php`:

1. The add-on provides `local.php` in the config directory
2. Set your Calibre database path (e.g., `/share/calibre/metadata.db`)
3. Adjust language, timezone, and other settings as needed

For detailed configuration options, refer to the [COPS Wiki](https://github.com/mikespub-org/seblucas-cops/wiki).

## OPDS Feed

The OPDS feed is available at `http://<your-ha-ip>:80/feed` or `http://<your-ha-ip>:80/index.php/feed`.

Connect e-readers and mobile apps by adding this URL as an OPDS catalog:

- **Kobo**: Settings → Add custom catalog
- **FBReader**: Catalogs → Add → OPDS
- **Moon+ Reader**: Catalogs → Add → Custom (OPDS)
- **Libby**: Manual addition varies by app

## Troubleshooting

### Add-on won't start

- Check logs in **Settings > Add-ons > COPS > Log**
- Ensure `data_location` is a valid, writable path
- If using network shares, verify credentials and connectivity

### Calibre library not found

- Ensure your Calibre database (metadata.db) is accessible at the path you configured
- Check file permissions (PGID/PUID)
- Verify the path in COPS configuration: `http://<your-ha-ip>:80/config.php`

### OPDS feed not accessible

- Ensure port 80 is properly mapped and accessible
- Try direct access to `http://<your-ha-ip>:80/index.php/feed`
- Check that your Calibre database path is correctly configured

### Performance issues

- Move `data_location` to a faster storage device if currently on SD card
- Ensure adequate free disk space
- Check network connectivity for network-mounted libraries

## Upstream Documentation

- [COPS on GitHub](https://github.com/mikespub-org/seblucas-cops)
- [COPS Wiki](https://github.com/mikespub-org/seblucas-cops/wiki)
- [LinuxServer Docker Image](https://github.com/linuxserver/docker-cops)
- [Calibre](https://calibre-ebook.com/)
