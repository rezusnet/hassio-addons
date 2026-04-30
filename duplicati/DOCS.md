# Duplicati Add-on Documentation

## Getting Started

This add-on provides Duplicati integration with Home Assistant.

### Installation

Follow the standard Home Assistant add-on installation process.

### Configuration

Configure the add-on through the Home Assistant UI or by editing the configuration options:

- **PUID**: User ID for file permissions (default: 0)
- **PGID**: Group ID for file permissions (default: 0)  
- **TZ**: Timezone (optional)
- **data_location**: Where data is stored (default: /share/duplicati)

### Usage

Once started, access the application through:
- Home Assistant Ingress (if enabled)
- Direct URL: http://<your-ha-ip>:8200

### Troubleshooting

Check the add-on logs for any error messages. Most issues are resolved by:
1. Restarting the add-on
2. Ensuring proper file permissions
3. Checking network connectivity

## Support

For help with this add-on, please refer to:
- [LinuxServer.io Documentation](https://docs.linuxserver.io/images/docker-duplicati/)
- [GitHub Repository](https://github.com/rezusnet/hassio-addons)
