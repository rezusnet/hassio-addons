# Semaphore UI

[![Release][release-shield]][release] ![License][license-shield]

Modern UI and powerful API for [Ansible](https://www.ansible.com) — run
playbooks on demand or on schedules from a web interface, with project,
inventory, environment, key-store and repository management. MIT-licensed
([Semaphore UI CE](https://semaphoreui.com)); the add-on bundles the complete
upstream runner image (ansible, terraform, opentofu, terragrunt, ssh stack).

## Features

- **Web UI & full REST API** for Ansible automation
- **Schedules** (cron) and manual task runs with live output
- **Key store** for SSH keys and vault passwords, **environment** secrets
- Git repository integration (public and SSH-key-authenticated)
- Bundled **ansible 13.x**, terraform, opentofu, terragrunt, boto3, pywinrm,
  paramiko — extra pip requirements installable via option
- Single-file SQLite database under `/data` — covered by Home Assistant
  backups; sessions and encrypted credentials persist across restarts

## Quick start

1. Start the add-on and open the web UI (port `3000` by default).
2. First-run admin credentials: set `admin_password` before first start, or
   leave it empty and read the auto-generated password from
   `data/semaphore/admin_credentials.txt` (see DOCS).
3. Log in, change the password, add a project, an SSH key, and your first
   template.

See [DOCS.md](DOCS.md) for configuration options, remote access (Nginx
Proxy Manager + optional sidebar link), and operations.

## License

Add-on packaging: MIT. Upstream application: [MIT](https://github.com/semaphoreui/semaphore/blob/develop/LICENSE)
© Denis Gukov.

[release-shield]: https://img.shields.io/badge/dynamic/yaml.svg?url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fsemaphore%2Fconfig.yaml&query=%24.version&label=release
[license-shield]: https://img.shields.io/badge/license-MIT-blue.svg
[release]: https://github.com/rezusnet/hassio-addons/releases
