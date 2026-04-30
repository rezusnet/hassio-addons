# LDAP Auth Documentation

## Getting Started

LDAP Auth is an authentication daemon that works with nginx reverse proxy. After installing and starting the add-on:

1. Configure your LDAP server connection settings (see Configuration section)
2. Set up nginx location blocks to use LDAP Auth for protection
3. Access the login page at `http://<your-ha-ip>:9000`
4. Users authenticate against your LDAP directory

## Configuration

### Options

| Option      | Type | Default | Description                                     |
| ----------- | ---- | ------- | ----------------------------------------------- |
| `env_vars`  | list | `[]`    | Custom environment variables (name/value pairs) |
| `PGID`      | int  | `0`     | Group ID for the service                        |
| `PUID`      | int  | `0`     | User ID for the service                         |
| `TZ`        | str  | `""`    | Timezone (e.g., `America/New_York`, `UTC`)      |
| `FERNETKEY` | str  | `""`    | Custom Fernet encryption key for cookies        |
| `CERTFILE`  | str  | `""`    | Path to SSL certificate file for HTTPS          |
| `KEYFILE`   | str  | `""`    | Path to SSL private key file                    |

### Example Configuration

```yaml
PGID: 0
PUID: 0
TZ: "America/New_York"
env_vars:
  - name: LDAP_SERVER
    value: "ldapserver.example.com"
```

### Ports

- **8888/tcp**: LDAP Auth daemon (internal authentication service, used by nginx)
- **9000/tcp**: LDAP Login page (web interface where users authenticate)

## Nginx Configuration

### Basic Setup

Create an nginx configuration that protects resources using LDAP Auth:

```nginx
upstream ldap_auth {
    server ldap-auth:8888;
}

upstream ldap_login {
    server ldap-auth:9000;
}

server {
    listen 80;
    server_name example.com;

    # Protected resource location
    location /protected/ {
        auth_request /auth;
        proxy_pass http://your-backend;
    }

    # Auth endpoint (internal)
    location /auth {
        internal;
        proxy_pass http://ldap_auth;
        proxy_pass_request_body off;
        proxy_set_header Content-Length "";
        proxy_set_header X-Original-URI $request_uri;
        proxy_set_header X-Original-URL $scheme://$http_host$request_uri;
        proxy_set_header X-Remote-User $remote_user;
    }

    # Login page
    location /ldaplogin {
        proxy_pass http://ldap_login;
        proxy_set_header Host $host;
        proxy_set_header X-Original-URI $request_uri;
    }

    # Allow login page without auth
    location ~ ^/(ldaplogin|login) {
        proxy_pass http://ldap_login;
        proxy_set_header Host $host;
    }
}
```

## LDAP Configuration

The LDAP Auth container requires proper LDAP server configuration. Configuration can be passed via environment variables or configuration files.

### Key Configuration Variables

- **LDAP_SERVER**: LDAP server hostname or IP address
- **LDAP_PORT**: LDAP server port (typically 389 for LDAP, 636 for LDAPS)
- **LDAP_BIND_DN**: Distinguished name for LDAP binding (e.g., `cn=admin,dc=example,dc=com`)
- **LDAP_BIND_PASSWORD**: Password for LDAP binding
- **LDAP_BASE_DN**: Base distinguished name for user searches (e.g., `ou=users,dc=example,dc=com`)
- **LDAP_SEARCH_FILTER**: Filter for user searches (e.g., `(&(objectClass=inetOrgPerson)(uid={0}))`)

### Example LDAP Setup with Active Directory

```yaml
env_vars:
  - name: LDAP_SERVER
    value: "ad.example.com"
  - name: LDAP_PORT
    value: "389"
  - name: LDAP_BIND_DN
    value: "cn=ldap_user,cn=Users,dc=example,dc=com"
  - name: LDAP_BIND_PASSWORD
    value: "your_password"
  - name: LDAP_BASE_DN
    value: "cn=Users,dc=example,dc=com"
  - name: LDAP_SEARCH_FILTER
    value: "(&(objectClass=user)(sAMAccountName={0}))"
```

## File Access

### Addon Config Volume

The add-on uses the `addon_config` volume for:

- SSL certificates (if using HTTPS)
- Custom configuration files
- Session persistence

Files are stored at `/config/` inside the container.

### SSL/TLS Configuration

To enable HTTPS on the auth daemon:

1. Place your certificate at `/config/cert.pem`
2. Place your private key at `/config/key.pem`
3. Set environment variables:

   ```yaml
   CERTFILE: /config/cert.pem
   KEYFILE: /config/key.pem
   ```

## Troubleshooting

### Cannot Connect to LDAP Server

- Verify LDAP server hostname/IP is correct
- Ensure LDAP port is open (389 for LDAP, 636 for LDAPS)
- Check network connectivity from the add-on container
- Review container logs for connection errors

### Authentication Failures

- Verify LDAP bind credentials (DN and password)
- Check user search filter matches your LDAP schema
- Ensure base DN is correct for your directory
- Check LDAP server for authentication attempts
- Verify user exists in the directory

### Session/Cookie Issues

- Cookies are encrypted with Fernet algorithm
- If `FERNETKEY` is not set, a random key is generated on container start
- Set static `FERNETKEY` for:
  - Multi-instance deployments (shared sessions)
  - Persistent sessions across container restarts
- Custom key should be base64-encoded Fernet key

### Certificate Issues

- Verify certificate and key files exist at configured paths
- Check file permissions are readable by the container
- Verify certificate is not expired
- For self-signed certs, ensure nginx trusts them

## Performance & Security

### Performance Tips

- LDAP Auth is lightweight and suitable for most deployments
- Cache LDAP lookups in nginx when possible
- Monitor container resource usage
- For high-traffic scenarios, consider running multiple instances

### Security Best Practices

1. **Use LDAPS (port 636)** - Always encrypt LDAP connections in production
2. **Restrict port 8888** - Only allow access from nginx
3. **Use Strong Fernet Keys** - Generate secure random keys for `FERNETKEY`
4. **Secure Credentials** - Store LDAP passwords securely (e.g., use Home Assistant Secrets)
5. **Rate Limiting** - Configure nginx rate limiting to prevent brute force attacks
6. **Log Monitoring** - Review authentication logs regularly
7. **Keep Updated** - Monitor for security updates

## Advanced Configuration

### Custom Environment Variables

Pass any additional environment variables needed by LDAP Auth:

```yaml
env_vars:
  - name: CUSTOM_VAR
    value: "value"
```

### Multi-Instance Setup

For load-balanced or multi-node deployments:

1. Generate a Fernet key once (outside the container)
2. Set the same `FERNETKEY` on all instances
3. Users can authenticate through any instance and maintain sessions

## Upstream Documentation

For additional configuration options and advanced setup:

- [nginx-ldap-auth GitHub](https://github.com/nginxinc/nginx-ldap-auth)
- [LinuxServer.io LDAP Auth Documentation](https://docs.linuxserver.io/images/docker-ldap-auth/)
- [LinuxServer.io General Documentation](https://docs.linuxserver.io/)

## Support

For issues or questions:

1. Check the troubleshooting section above
2. Review container logs for detailed error messages
3. Open an issue on the [rezusnet/hassio-addons repository](https://github.com/rezusnet/hassio-addons)
4. For upstream issues, see [nginx-ldap-auth issues](https://github.com/nginxinc/nginx-ldap-auth/issues)
