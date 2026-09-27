<!-- markdownlint-disable -->
<!-- Changelog entries mirror upstream release notes verbatim; upstream formatting is intentionally preserved, so style rules are disabled for this file. -->

## 2.19.12-r1 (2026-09-28)

Add-on-side revision (upstream stays **2.19.12**):

- Fix first-run bootstrap under a real Supervisor: the bashio standalone shim is now sourced explicitly (it is a sourcing library, not a script interpreter), and the init script aborts on errors. Previously `semaphore users add` could run with an empty password when the interpreter-mode shim did not define the bashio functions.

## 2.19.12 (2026-09-28)

Initial add-on release, packaging upstream Semaphore UI **2.19.12** (MIT).

Updated to upstream Semaphore UI **2.19.12**:

### Bogfixes

- Fixed bug with runner configuration on registration step.

[Full release notes](https://github.com/semaphoreui/semaphore/releases/tag/v2.19.12)

### Add-on packaging

- Wraps the official multi-arch image (ansible 13.x venv, terraform, opentofu, terragrunt, ssh stack) running unprivileged under tini
- Single-file SQLite database under `/data/semaphore` — Home Assistant backups cover everything; sessions and encrypted credentials persist across restarts
- First-run admin bootstrap: `admin_password` option or auto-generated credentials in `data/semaphore/admin_credentials.txt`
- Managed option surface: port, `max_parallel_tasks`, SMTP alerting, `non_admin_can_create_project`, `password_login_disable`, extra pip `requirements`, `env_vars` passthrough
- Daily upstream auto-update via the repo updater (version = upstream release, no local suffix)
