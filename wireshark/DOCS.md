# Wireshark Add-on Documentation

## Getting Started

Wireshark is now running and accessible through Home Assistant. You can access it via the Ingress link in the add-on sidebar or directly at the configured port.

### Initial Setup

1. After starting the add-on, wait 30-60 seconds for the desktop environment to initialize
2. Access Wireshark through the Home Assistant Ingress interface
3. The Wireshark application will be available on the desktop
4. You can open a terminal to capture traffic with tshark or use the GUI

## Configuration

### Options

| Option | Type | Required | Default | Description |
|--------|------|----------|---------|-------------|
| `PUID` | int | No | 0 | User ID for file permissions |
| `PGID` | int | No | 0 | Group ID for file permissions |
| `TZ` | string | No | UTC | Timezone (e.g., `Europe/Berlin`) |
| `data_location` | string | No | `/share/wireshark` | Directory to store captures and profiles |
| `env_vars` | list | No | [] | Additional environment variables |

## Network Capture Setup

### Capturing Traffic

1. **Via GUI**: Open Wireshark from the desktop, select an interface, and click capture
2. **Via Terminal**: Use tshark command-line tool for automated captures
3. **Save Captures**: Captures are stored in the configured data location

### Available Interfaces

Wireshark can capture from:
- Physical network interfaces (eth0, wlan0, etc.)
- Home Assistant network bridge
- Local traffic (lo)

## File Access

Packet captures and Wireshark profiles are stored in the configured data location (`/share/wireshark` by default):

- **captures/**: Saved PCAP files
- **profiles/**: Wireshark profiles and preferences

## Ports

- **3000/tcp**: Browser-based desktop interface (KASMVNC)

## Troubleshooting

### Interface Not Found

If no network interfaces appear:
1. Check that the add-on is running
2. Restart the add-on
3. Verify network connectivity

### Permission Denied on Capture

If you see permission errors:
1. Run Wireshark as root or with elevated privileges
2. Add your user to the appropriate groups in the startup script

### Large Capture Files

If captures are very large:
1. Use capture filters to reduce data: `tcp port 80`
2. Set a ring buffer or auto-save feature
3. Store captures on fast storage (SSD)

## Upstream Documentation

For detailed Wireshark features and usage:
- **User Guide**: https://www.wireshark.org/docs/wsug_html_chunked/
- **Display Filters**: https://www.wireshark.org/docs/wsug_html_chunked/ChWorkBuildingBlocks.html
- **Capture Filters**: https://wiki.wireshark.org/CaptureFilters
- **GitHub Issues**: https://github.com/wireshark/wireshark/issues
