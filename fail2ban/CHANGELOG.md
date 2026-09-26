<!-- markdownlint-disable -->
<!-- Changelog entries mirror upstream release notes verbatim; upstream formatting is intentionally preserved, so style rules are disabled for this file. -->

## 1.1.0-r2-ls44 (2026-09-26)

Upstream image rebuild (`1.1.0-r2-ls43` → `1.1.0-r2-ls44`) — packaging / base-image refresh, no application changes (Fail2ban **1.1.0**).


## 1.1.0-r2-ls43 (2026-09-12)

Upstream image rebuild (`1.1.0-r2-ls42` → `1.1.0-r2-ls43`) — packaging / base-image refresh, no application changes (Fail2ban **1.1.0**).

## 1.1.0-r2-ls42 (2026-09-05)

Upstream image rebuild (`1.1.0-r2-ls41` → `1.1.0-r2-ls42`) — packaging / base-image refresh, no application changes (Fail2ban **1.1.0**).

## 1.1.0-r2-ls41 (2026-08-22)

Upstream image rebuild (`1.1.0-r2-ls40` → `1.1.0-r2-ls41`) — packaging / base-image refresh, no application changes (Fail2ban **1.1.0**).

## 1.1.0-r2-ls40 (2026-07-25)

Upstream image rebuild (`1.1.0-r2-ls39` → `1.1.0-r2-ls40`) — packaging / base-image refresh, no application changes (Fail2ban **1.1.0**).

## 1.1.0-r2-ls39 (2026-07-18)

Upstream image rebuild (`1.1.0-r2-ls38` → `1.1.0-r2-ls39`) — packaging / base-image refresh, no application changes (Fail2ban **1.1.0**).

## 1.1.0-r2-ls38 (2026-07-04)

Upstream image rebuild (`1.1.0-r2-ls37` → `1.1.0-r2-ls38`) — packaging / base-image refresh, no application changes (Fail2ban **1.1.0**).

## 1.1.0-r2-ls37 (2026-06-27)

Upstream image rebuild (`1.1.0-r2-ls36` → `1.1.0-r2-ls37`) — packaging / base-image refresh, no application changes (Fail2ban **1.1.0**).

## 1.1.0-r2-ls36 (2026-05-19)

Upstream image rebuild (`1.1.0-r2-ls35` → `1.1.0-r2-ls36`) — packaging / base-image refresh, no application changes (Fail2ban **1.1.0**).

## 1.1.0-r2-ls35 (2026-05-01)

Upstream image rebuild (`1.1.0-r2-ls34` → `1.1.0-r2-ls35`) — packaging / base-image refresh, no application changes (Fail2ban **1.1.0**).

## 1.1.0-r2-ls34 (01-05-2026)

- Update to upstream 1.1.0-r2-ls34
- Fix version mismatch with upstream tracking

### Upstream Fail2ban 1.1.0

### ver. 1.1.0 (2024/04/25) - object found: norad:59479, cospar:2024-069a, altitude: 36267km

Update of major version of fail2ban with primary target to provide python 3.12/3.13 compatibility, issue #3487.
See the [ChangeLog](https://github.com/fail2ban/fail2ban/blob/1.1.0/ChangeLog) for more information.

It also includes debian package, built without a test suite (fail2ban-testcases, fail2ban.test python module).

[Full release notes](https://github.com/fail2ban/fail2ban/releases/tag/1.1.0)

## 1.0.0 (27-04-2026)

- Initial release based on linuxserver/docker-fail2ban
- Pre-configured jails for 50+ services (SSH, HA, Nginx, etc.)
- Configurable log path mounts via add-on options
- NET_ADMIN/NET_RAW capabilities for iptables/nftables
- Host network mode required for firewall manipulation
