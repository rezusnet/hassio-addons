# Darktable Add-on Documentation

## About

Darktable is an open-source photography workflow application and raw developer. It provides a virtual lighttable and darkroom for photographers, managing digital negatives in a database and enabling the development of raw images.

## Getting Started

### First Launch

1. Install the add-on from the Home Assistant Add-ons store
2. Configure any optional settings (see Configuration section)
3. Start the add-on
4. The web interface will be available at `https://your-home-assistant-ip:3001/`

**Note:** Darktable uses HTTPS with a self-signed certificate by default. Your browser may show a security warning - this is normal.

### Initial Setup

On first launch, Darktable will:

- Create necessary database files in the configured data location
- Initialize the library structure
- Prepare the web interface

## Configuration

### Options

| Option            | Type   | Default            | Description                                                 |
| ----------------- | ------ | ------------------ | ----------------------------------------------------------- |
| **data_location** | string | `/share/darktable` | Location to store Darktable configuration and library files |
| **TZ**            | string | `(empty)`          | Timezone (e.g., `America/New_York`, `Europe/London`)        |
| **PUID**          | int    | `0`                | User ID for file permissions                                |
| **PGID**          | int    | `0`                | Group ID for file permissions                               |
| **localdisks**    | string | `(empty)`          | Local disk/path mappings                                    |
| **networkdisks**  | string | `(empty)`          | Network disk mount points                                   |
| **cifsusername**  | string | `(empty)`          | Username for CIFS/SMB shares                                |
| **cifspassword**  | string | `(empty)`          | Password for CIFS/SMB shares                                |
| **cifsdomain**    | string | `(empty)`          | Domain for CIFS/SMB authentication                          |

### Example Configuration

```yaml
data_location: /share/darktable
TZ: America/New_York
PUID: 1000
PGID: 1000
```

## File Access

The add-on provides access to:

- **addon_config** (`/addon_config`): Add-on configuration files
- **share** (`/share`): Home Assistant share directory (for media access)
- **ssl** (`/ssl`): Home Assistant SSL certificates (read-only)

Configure additional mounts in the add-on settings if needed.

## Network Ports

- **3000/tcp**: Desktop GUI interface (optional, for VNC access)
- **3001/tcp**: HTTPS web interface (main interface)

## Reverse Proxy Setup

If you're using a reverse proxy (SWAG, Traefik, etc.):

1. Configure the reverse proxy to pass HTTPS traffic to `http://darktable:3001`
2. Ensure the proxy handles SSL termination
3. May need to configure additional headers depending on your proxy

**Note:** Some proxy configurations may require disabling certificate validation for the backend if you don't want to use the self-signed certificate.

## Troubleshooting

### Cannot Access Web Interface

1. Verify the add-on is running: Check the add-on logs
2. Try accessing via `https://your-ip:3001/` directly (not through ingress if experiencing issues)
3. Check for browser console errors (F12)
4. Clear browser cache and try again

### HTTPS Certificate Warning

This is normal! Darktable uses a self-signed certificate by default:

- Click "Advanced" and proceed (varies by browser)
- Or configure a trusted certificate through a reverse proxy

### Database Issues

If you experience database corruption:

1. Stop the add-on
2. Backup your `/share/darktable` directory
3. Delete the database file (usually `library.db`)
4. Restart the add-on to regenerate

### Memory/Performance Issues

On resource-constrained systems (Raspberry Pi):

- Reduce the number of concurrent operations
- Consider limiting library size initially
- Use local storage when possible (faster than network storage)

## Upstream Documentation

For detailed usage information, visit:

- [Darktable Official Documentation](https://docs.darktable.org/)
- [Darktable Website](https://www.darktable.org/)
- [LinuxServer.io Darktable Documentation](https://docs.linuxserver.io/images/docker-darktable/)

## Support and Issues

For add-on specific issues, please report on the [GitHub repository](https://github.com/rezusnet/hassio-addons/issues).

For Darktable application issues, visit the [Darktable project](https://www.darktable.org/).
