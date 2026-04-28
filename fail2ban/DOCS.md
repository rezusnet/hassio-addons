## Getting Started

After installing and starting the add-on:

1. Open the add-on **Log** tab and confirm Fail2ban started successfully.
2. Add one or more log directories under `log_paths` so Fail2ban can inspect them.
3. Edit the jail files under `/config/fail2ban` to enable the protections you want.
4. Restart the add-on after changing jail configuration.

## Configuration

### Options

| Option         | Type | Default | Description                                        |
| -------------- | ---- | ------- | -------------------------------------------------- |
| `PUID`         | int  | `0`     | User ID used by the container                      |
| `PGID`         | int  | `0`     | Group ID used by the container                     |
| `TZ`           | str  | `""`    | Timezone (e.g. `Europe/Berlin`)                    |
| `VERBOSITY`    | list | `-vv`   | Container log verbosity                            |
| `env_vars`     | list | `[]`    | Custom environment variables                       |
| `localdisks`   | str  | `""`    | Optional local disks to mount                      |
| `networkdisks` | str  | `""`    | Optional SMB shares to mount                       |
| `cifsusername` | str  | `""`    | SMB username                                       |
| `cifspassword` | str  | `""`    | SMB password                                       |
| `cifsdomain`   | str  | `""`    | SMB domain                                         |
| `log_paths`    | list | `[]`    | Named log directories to mount under `/remotelogs` |

### Example Configuration

```yaml
VERBOSITY: -vv
log_paths:
  - name: nginx
    path: /share/logs/nginx
  - name: sonarr
    path: /share/logs/sonarr
```

## File Access

The add-on maps the following paths:

| Path                        | Purpose                                                  |
| --------------------------- | -------------------------------------------------------- |
| `/config`                   | Fail2ban configuration and jail files                    |
| `/remotelogs/<name>`        | Read-only mounted log directories from `log_paths`       |
| `/remotelogs/homeassistant` | Auto-mounted Home Assistant log directory when available |

The LinuxServer base image creates the default configuration under `/config/fail2ban` on first boot.

## Jails and Logs

Fail2ban only protects services whose logs it can read.

- Add directories, not single files, to `log_paths`
- Each configured mount appears under `/remotelogs/<name>`
- Enable or customize jails inside `/config/fail2ban/jail.d`
- If you protect host-level services, use the `INPUT` chain where appropriate

Refer to the generated `/config/fail2ban/README.md` from the upstream image for the full list of shipped jail templates.

## Networking and Capabilities

- `host_network: true` is required so bans apply to the real host interfaces
- `NET_ADMIN` is required to modify iptables/nftables rules
- `NET_RAW` is required for raw socket and interface operations

## Troubleshooting

### Add-on won't start

- Check the add-on log for syntax errors in custom jail files
- Verify any configured log path exists on the Home Assistant host
- Confirm no mount failures are reported for `/remotelogs/*`

### A jail never triggers

- Confirm the jail is enabled in `/config/fail2ban/jail.d`
- Confirm the jail's `logpath` points to the mounted path inside the container
- Check that the target application is actually writing matching log lines

### Bans do not take effect

- Confirm the add-on has `NET_ADMIN` and `NET_RAW`
- Confirm the add-on is running with host networking
- Inspect the host firewall backend and Fail2ban action definitions

## Upstream Documentation

- [Fail2ban website](https://www.fail2ban.org/)
- [LinuxServer Docker Image](https://github.com/linuxserver/docker-fail2ban)
- [LinuxServer fail2ban configs](https://github.com/linuxserver/fail2ban-confs)
