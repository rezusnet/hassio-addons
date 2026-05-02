## Prerequisites

Mastodon requires two external services that must be running before the add-on starts:

1. **PostgreSQL** (version 14+) — for all persistent data
2. **Redis** (version 6+) — for caching, queues, and real-time features

You can use any compatible add-on or external server. Recommended:
- PostgreSQL: `plesník/postgresql` or `musl/mariadb` community add-ons, or an external managed database
- Redis: `eguenodi/redis` community add-on, or an external Redis instance

## Getting Started

### 1. Prepare the database

Create a PostgreSQL database and user for Mastodon:

```sql
CREATE USER mastodon WITH PASSWORD 'your_password';
CREATE DATABASE mastodon OWNER mastodon;
```

### 2. Configure required fields

Open the add-on Configuration tab and set:

| Field | Description |
|-------|-------------|
| `LOCAL_DOMAIN` | Your Mastodon server domain (e.g., `social.example.com`). **Cannot be changed later.** |
| `DB_HOST` | PostgreSQL hostname (e.g., `core-postgres` or an IP) |
| `DB_PASS` | PostgreSQL password |
| `REDIS_HOST` | Redis hostname |
| `SMTP_SERVER` | SMTP server for email delivery (required for sign-ups and notifications) |
| `SMTP_LOGIN` | SMTP username |
| `SMTP_PASSWORD` | SMTP password |
| `SMTP_FROM_ADDRESS` | Sender email address (e.g., `mastodon@example.com`) |

### 3. Secrets (auto-generated)

The following secrets are **auto-generated on first run** and persisted to `<data_location>/secrets/`. You only need to provide them if you want to use specific values:

- `SECRET_KEY_BASE`
- `OTP_SECRET`
- `VAPID_PRIVATE_KEY` / `VAPID_PUBLIC_KEY`
- `ACTIVE_RECORD_ENCRYPTION_PRIMARY_KEY`
- `ACTIVE_RECORD_ENCRYPTION_DETERMINISTIC_KEY`
- `ACTIVE_RECORD_ENCRYPTION_KEY_DERIVATION_SALT`

To manually generate secrets:

```bash
openssl rand -hex 64
```

For VAPID keys, run inside a Mastodon environment:

```bash
RAILS_ENV=production bundle exec rake mastodon:webpush
```

### 4. Start the add-on

On first start, Mastodon will:
1. Run database migrations (`db:prepare`)
2. Generate secrets if not provided
3. Start Rails (Puma), Streaming API, Sidekiq, and nginx

### 5. Create an admin account

After the add-on starts successfully, open the HA sidebar (Ingress) or go to `https://<your-domain>/` and create your account. Then promote it to admin via the add-on CLI:

```bash
RAILS_ENV=production tootctl accounts modify <username> --role Owner
```

## Configuration

### Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `env_vars` | list | `[]` | Custom environment variables |
| `PGID` | int | `0` | Group ID for file permissions |
| `PUID` | int | `0` | User ID for file permissions |
| `data_location` | str | `/share/mastodon` | Persistent data path |
| `TZ` | str | `""` | Timezone (e.g., `Europe/Bucharest`) |
| `LOCAL_DOMAIN` | str | | Your server's public domain |
| `DB_HOST` | str | | PostgreSQL hostname |
| `DB_PORT` | port | `5432` | PostgreSQL port |
| `DB_USER` | str | `mastodon` | PostgreSQL username |
| `DB_NAME` | str | `mastodon` | PostgreSQL database name |
| `DB_PASS` | password | | PostgreSQL password |
| `REDIS_HOST` | str | | Redis hostname |
| `REDIS_PORT` | port | `6379` | Redis port |
| `SECRET_KEY_BASE` | password | | Browser session secret (auto-generated) |
| `OTP_SECRET` | password | | MFA/2FA secret (auto-generated) |
| `VAPID_PRIVATE_KEY` | password | | Push notification private key (auto-generated) |
| `VAPID_PUBLIC_KEY` | str | | Push notification public key (auto-generated) |
| `ACTIVE_RECORD_ENCRYPTION_PRIMARY_KEY` | password | | AR encryption key (auto-generated) |
| `ACTIVE_RECORD_ENCRYPTION_DETERMINISTIC_KEY` | password | | AR deterministic key (auto-generated) |
| `ACTIVE_RECORD_ENCRYPTION_KEY_DERIVATION_SALT` | password | | AR derivation salt (auto-generated) |
| `SMTP_SERVER` | str | | SMTP server hostname |
| `SMTP_PORT` | port | `587` | SMTP port |
| `SMTP_LOGIN` | str | | SMTP username |
| `SMTP_PASSWORD` | password | | SMTP password |
| `SMTP_FROM_ADDRESS` | str | `notifications@example.com` | Sender email |
| `ES_ENABLED` | bool | `false` | Enable Elasticsearch full-text search |

### Custom Environment Variables

Use `env_vars` to pass additional Mastodon environment variables:

```yaml
env_vars:
  - name: WEB_DOMAIN
    value: "mastodon.example.com"
  - name: S3_ENABLED
    value: "true"
  - name: S3_BUCKET
    value: "my-mastodon-media"
```

See [Mastodon environment variables](https://github.com/mastodon/mastodon/blob/main/.env.production.sample) for the full list.

## Federation Setup

For your Mastodon instance to federate with other servers:

1. **Domain DNS**: Point your `LOCAL_DOMAIN` DNS record to your HA host's public IP
2. **Reverse proxy**: Set up a reverse proxy (nginx, Caddy, Traefik) on your network that forwards HTTPS (443) to the add-on's port 443
3. **SSL certificate**: Obtain a valid SSL certificate (e.g., via Let's Encrypt)
4. **Enable port 443**: In the add-on Configuration tab, set the `443/tcp` port to a host port (e.g., `4433`) and configure your reverse proxy accordingly

The HA Ingress provides **admin and web UI access only**. Federation requires proper DNS, SSL, and external access configured separately.

## Ports

| Port | Protocol | Default | Description |
|------|----------|---------|-------------|
| `443` | TCP | Disabled | HTTPS interface (enable for federation) |

## File Structure

```
<data_location>/
  mastodon/          # Mastodon config and user uploads
  nginx/             # nginx site configuration
  secrets/           # Auto-generated secret keys
```

## Troubleshooting

### Add-on won't start

- Verify PostgreSQL is running and accessible at `DB_HOST:DB_PORT`
- Verify Redis is running and accessible at `REDIS_HOST:REDIS_PORT`
- Check that the database `DB_NAME` exists and `DB_USER` has full access
- Check add-on logs for specific error messages

### Database connection refused

- Ensure the PostgreSQL add-on or server is running
- Check that `DB_HOST` uses the correct hostname (e.g., `core-postgres` for HA add-ons, or an IP address)
- Verify firewall rules allow connections on `DB_PORT`

### Redis connection refused

- Ensure Redis is running
- Check `REDIS_HOST` and `REDIS_PORT` are correct
- Verify no password is set on Redis (or use `env_vars` to set `REDIS_PASSWORD`)

### Cannot create account / no email

- Verify `SMTP_SERVER`, `SMTP_LOGIN`, and `SMTP_PASSWORD` are correct
- Check your SMTP provider allows sending from `SMTP_FROM_ADDRESS`
- Test SMTP connectivity from the HA host

### Ingress shows blank page or redirect

- The add-on automatically disables nginx HTTPS redirect for ingress
- If issues persist, check the add-on logs for nginx errors
- Ensure `LOCAL_DOMAIN` is set (required by Mastodon's URL generation)

### Federation not working

- Verify DNS for `LOCAL_DOMAIN` points to your public IP
- Ensure port 443 is mapped and a reverse proxy forwards to it with a valid SSL certificate
- Check that your firewall allows incoming connections on port 443

## Upstream Documentation

- [Mastodon Documentation](https://docs.joinmastodon.org/)
- [Mastodon Admin Guide](https://docs.joinmastodon.org/admin/)
- [Mastodon Environment Variables](https://github.com/mastodon/mastodon/blob/main/.env.production.sample)
- [LinuxServer Docker Image](https://github.com/linuxserver/docker-mastodon)
