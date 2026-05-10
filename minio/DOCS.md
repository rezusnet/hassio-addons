# MinIO Add-on Documentation

## Getting Started

After installing the add-on:

1. Change the default `access_key` and `secret_key` in configuration.
2. Start the add-on.
3. Access the web console via the HA sidebar (ingress) or directly at `http://HA-IP:9001`.

## S3 API Access

The S3 API is available on port 9000. Configure your S3 clients with:

- **Endpoint**: `http://YOUR-HA-IP:9000`
- **Access Key ID**: value of `access_key` config option
- **Secret Access Key**: value of `secret_key` config option
- **Region**: leave empty or use `us-east-1`

### Using with mc (MinIO Client)

```bash
mc alias set myha http://YOUR-HA-IP:9000 myaccesskey mysecretkey
mc ls myha/
mc mb myha/mybucket
mc cp file.txt myha/mybucket/
```

### Using with aws cli

```bash
aws --endpoint-url http://YOUR-HA-IP:9000 s3 mb s3://mybucket
aws --endpoint-url http://YOUR-HA-IP:9000 s3 cp file.txt s3://mybucket/
```

## Storage

Objects are stored in the configured `data_location` path (default: `/share/minio`). This path is mapped to the HA `share` storage, which persists across add-on restarts.

For larger deployments, consider changing `data_location` to a mounted network drive.

## Environment Variables

Custom environment variables can be set via `env_vars`. Useful MinIO environment variables:

- `MINIO_BROWSER` — enable/disable console (`on`/`off`)
- `MINIO_SERVER_URL` — external URL for the S3 API (for TLS/reverse proxy)
- `MINIO_BROWSER_REDIRECT_URL` — external URL for console redirect

## Health Check

The add-on includes a built-in health check at `http://localhost:9000/minio/health/live`.
