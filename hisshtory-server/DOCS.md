# Hishtory Server Add-on Documentation

## Getting Started

Hishtory Server is now running. You can connect shell clients to sync and manage your command history.

### Initial Setup

1. After starting the add-on, wait for initialization (10-20 seconds)
2. Configure PostgreSQL database connection (required)
3. Note the server address and port
4. Install and configure hishtory clients on your machines

## Configuration

### Options

| Option | Type | Required | Default | Description |
|--------|------|----------|---------|-------------|
| `PUID` | int | No | 0 | User ID for file permissions |
| `PGID` | int | No | 0 | Group ID for file permissions |
| `TZ` | string | No | UTC | Timezone |
| `data_location` | string | No | `/share/hisshtory` | Directory for data |
| `server_port` | int | No | 8000 | Server port |
| `db_host` | string | **Yes** | - | PostgreSQL hostname/IP |
| `db_port` | int | No | 5432 | PostgreSQL port |
| `db_name` | string | No | `hishtory` | Database name |
| `db_user` | string | No | `hishtory` | Database user |
| `db_password` | string | **Yes** | - | Database password |

### Database Setup

Hishtory requires a PostgreSQL database. You can:

1. **Use an external PostgreSQL server**:
   - Set `db_host` to your database server IP
   - Configure `db_user` and `db_password`

2. **Use MariaDB add-on from Home Assistant**:
   - Install MariaDB add-on (PostgreSQL is recommended but MariaDB may work)
   - Note the connection details
   - Configure in Hishtory settings

## Client Installation

### Install Client

```bash
# Download and run installation script
curl https://hishtory.dev/install.py | python3 -
```

### Point Client to Your Server

```bash
# Configure to use your private server
hishtory config-server http://<your-host>:8000

# Or with authentication (if required)
hishtory config-server http://user:pass@<your-host>:8000
```

### Verify Sync

```bash
# Check sync status
hishtory status

# Force sync
hishtory sync
```

## Supported Shells

- **bash**: Full support
- **zsh**: Full support
- **fish**: Full support
- **sh**: Partial support

## API Reference

### Health Check

```bash
GET /health
```

Returns server status.

### Server Endpoint

```
http://<your-host>:8000
```

Clients connect to this endpoint to sync history.

## Data Storage

- **History Data**: PostgreSQL database
- **Server Data**: Stored in `/share/hisshtory/`

## Troubleshooting

### Database Connection Failed

1. Verify PostgreSQL is running and accessible
2. Check `db_host` is correct
3. Verify `db_user` and `db_password`
4. Test connectivity:
   ```bash
   psql -h <db_host> -U <db_user> -d <db_name>
   ```

### Client Won't Sync

1. Verify server is running: `curl http://<your-host>:8000/health`
2. Check firewall allows port 8000
3. Verify client has correct server address
4. Check add-on logs for errors

### High Memory Usage

1. Limit history size per user
2. Archive old history entries
3. Optimize database queries

## Performance Optimization

1. **Database**: Use SSD for PostgreSQL storage
2. **Network**: Ensure low-latency connection to database
3. **Clients**: Limit number of concurrent syncs
4. **Pruning**: Regularly prune old history entries

## Security Considerations

1. **Network**: Use VPN or reverse proxy with TLS
2. **Authentication**: Consider adding authentication layer
3. **Database**: Use strong PostgreSQL password
4. **Firewall**: Restrict access to port 8000

## Upstream Documentation

For Hishtory features and advanced configuration:
- **GitHub**: https://github.com/ddpom/hishtory
- **Installation**: https://hishtory.dev/
- **Client Setup**: https://github.com/ddpom/hishtory#getting-started
- **FAQ**: https://github.com/ddpom/hishtory/discussions
