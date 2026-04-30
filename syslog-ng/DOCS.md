# Syslog-ng Add-on Documentation

## Getting Started

Syslog-ng is now running and listening for incoming logs. You can configure devices to send syslog messages to this add-on using UDP, TCP, or TLS transport.

### Initial Setup

1. After starting the add-on, it will listen on ports 514 (UDP/TCP) and 601 (TLS)
2. Configure your devices to send syslog messages to this server
3. Check the add-on logs for incoming messages
4. Edit the configuration file as needed

## Configuration

### Options

| Option | Type | Required | Default | Description |
|--------|------|----------|---------|-------------|
| `PUID` | int | No | 0 | User ID for file permissions |
| `PGID` | int | No | 0 | Group ID for file permissions |
| `TZ` | string | No | UTC | Timezone |
| `data_location` | string | No | `/share/syslog-ng` | Directory for logs and config |
| `env_vars` | list | No | [] | Additional environment variables |

## Log Transport Protocols

### UDP (Port 514)
Lightweight, connectionless transport. Fast but may lose messages under high load.

```
syslog://<hostname>:514
```

### TCP (Port 514)
Connection-oriented transport. More reliable than UDP.

```
syslog-tcp://<hostname>:514
```

### TLS (Port 601)
Encrypted and authenticated transport. Best for sensitive logs.

```
syslog-tls://<hostname>:601
```

## Configuration Files

Configuration files are stored in `/share/syslog-ng/config/`:

- **syslog-ng.conf**: Main configuration file
- **logs/**: Directory containing incoming logs

## File Storage

- **Logs**: Stored in `/share/syslog-ng/logs/`
- **Configuration**: Stored in `/share/syslog-ng/config/`

## Common Configuration Examples

### Log from a Device

Send logs from a network device:

```
udp://syslog-ng-server:514
```

### Forward to Another Server

Forward all logs to a remote syslog server:

```
@192.168.1.100
```

### Filter by Source

Create filters to route logs based on source or type:

```
filter f_device { source("input1"); };
destination d_device { file("/var/log/device.log"); };
```

## Ports

| Port | Protocol | Purpose |
|------|----------|---------|
| 514/udp | Syslog UDP | Standard syslog |
| 514/tcp | Syslog TCP | Reliable syslog |
| 601/tcp | Syslog TLS | Encrypted syslog |

## Troubleshooting

### Logs Not Appearing

1. Verify the device is configured with correct hostname/IP
2. Check add-on logs for connection errors
3. Verify firewall allows traffic to ports 514/601
4. Test with `telnet <hostname> 514`

### High Load Issues

1. Use TCP or TLS instead of UDP for better reliability
2. Optimize syslog-ng.conf for performance
3. Implement log rotation to prevent disk fill

### TLS Certificate Issues

1. Place certificates in `/share/syslog-ng/config/certs/`
2. Configure cert paths in syslog-ng.conf
3. Restart the add-on after adding certs

## Upstream Documentation

For detailed syslog-ng features and configuration:
- **Admin Guide**: https://www.syslog-ng.com/technical-documents/doc/syslog-ng-open-source-edition/3.35/administration-guide/
- **Configuration**: https://www.syslog-ng.com/technical-documents/doc/syslog-ng-open-source-edition/3.35/reference-manual/index.html
- **GitHub**: https://github.com/syslog-ng/syslog-ng
- **Community**: https://lists.balabit.hu/pipermail/syslog-ng/
