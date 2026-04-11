# Contributing

Thank you for your interest in contributing to rezusnet/hassio-addons!

## Adding a New Addon

1. Create a new top-level directory with your addon slug name
2. Add the required files:
   - `config.yaml` - Addon manifest (name, description, version, arch, image, options, schema)
   - `Dockerfile` - Build instructions following the 6-section pattern
   - `build.json` - Base images per architecture
3. Optional files:
   - `updater.json` - For automatic upstream version tracking
   - `apparmor.txt` - Security profile
   - `rootfs/` - Files overlaid onto container (cont-init.d scripts, nginx configs)
   - `README.md` - Addon documentation
   - `icon.png` / `logo.png` - Visual identity
4. Update the version in `config.yaml`
5. Commit with a descriptive message (no `[nobuild]` prefix)
6. The CI will automatically lint, build, and publish your addon

## Addon Manifest (config.yaml)

Key fields:
- `name`: Display name
- `description`: What the addon does
- `version`: Semantic version
- `arch`: List of supported architectures (aarch64, amd64)
- `image`: Docker image with `{arch}` placeholder (e.g., `ghcr.io/rezusnet/addon-name-{arch}`)
- `options`: Default configuration values
- `schema`: Validation rules for options
- `ingress`: true/false for HA sidebar integration
- `map`: HA folder mappings (addon_config, media, share, ssl, etc.)

## Dockerfile Pattern

Follow the 6-section convention:
1. Build Image - `ARG BUILD_FROM; FROM ${BUILD_FROM}`
2. Modify Image - S6 env vars
3. Install Apps - Copy rootfs, download modules, install packages
4. Entrypoint - Copy ha_entrypoint.sh and bashio-standalone.sh
5. Labels - OCI + io.hass.* labels
6. Healthcheck - curl-based health check

## Shared Templates

Scripts in `.templates/` are downloaded at build time. Reference them in your Dockerfile:
```dockerfile
ARG MODULES="00-banner.sh 01-custom_script.sh"
COPY ha_automodules.sh /ha_automodules.sh
RUN chmod 744 /ha_automodules.sh && /ha_automodules.sh "$MODULES" && rm /ha_automodules.sh
```

## Testing

- PR checks automatically lint configs and test-build Docker images
- Use the devcontainer for local testing
- Run `frenck/action-addon-linter` locally if possible

## Commit Convention

- Use descriptive commit messages
- Do NOT use `[nobuild]` prefix (this is reserved for CI bots to skip builds)
- One addon per commit is preferred
