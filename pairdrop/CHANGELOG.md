## 1.11.2-1 (2026-05-03)

- Fix EADDRINUSE crash loop by providing custom svc-pairdrop/run script
- Properly handle S6 service lifecycle with cd before exec

## 1.11.2 (2026-05-03)

- Initial release based on PairDrop 1.11.2
- Uses linuxserver/docker-pairdrop as base image
- HA ingress via sidebar (ingress_stream)
- Peer-to-peer file sharing via WebRTC
- WebSocket fallback for VPN clients
- Rate limiting support
- SMB/CIFS network share mounting
- Local disk mounting (USB, SATA, NVMe)
- Custom environment variables
- AppArmor profile
