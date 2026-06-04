## 0.0.1 (2026-05-31)

- Initial release based on RezusCloud v0.0.1-22
- Non-LSIO add-on with multi-stage build from upstream GHCR image
- WebUI via HA ingress sidebar on port 3000
- MachineLink gRPC on port 50180
- Provider gRPC on port 50190
- SQLite state stored in /data/rezuscloud
- Configurable join token, ingress type, and S3 backup
- Host network + Docker API for Talos container management
- Watchdog via /healthz endpoint
