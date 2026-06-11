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
- Initialize the application
- Prepare the web interface for access
- Load any existing configuration

## Configuration

### Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| **TZ** | string | `(empty)` | Timezone (e.g., `America/New_York`, `Europe/London`) |

## File Access

The add-on provides access to:

- **share** (`/share`): Home Assistant share directory (for media access)
- **ssl** (`/ssl`): Home Assistant SSL certificates (read-only)

## Network Ports

- **3001/tcp**: HTTPS web interface (main interface)

The web interface is accessible at `https://your-home-assistant-ip:3001/`

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

## Upstream Documentation

For detailed usage information, visit:
- [Darktable Official Documentation](https://docs.darktable.org/)
- [Darktable Website](https://www.darktable.org/)

## Support and Issues

For add-on specific issues, please report on the [GitHub repository](https://github.com/rezusnet/hassio-addons/issues).

For Darktable application issues, visit the [Darktable project](https://www.darktable.org/).
