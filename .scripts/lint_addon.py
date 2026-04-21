import json
import sys
from pathlib import Path

import yaml


def load_config(addon_dir):
    for name in ["config.yaml", "config.yml", "config.json"]:
        p = addon_dir / name
        if p.exists():
            text = p.read_text()
            if p.suffix == ".json":
                return json.loads(text)
            return yaml.safe_load(text) or {}
    return {}


def lint_addon(addon):
    addon_dir = Path(addon)
    config = load_config(addon_dir)
    errors = []

    for field in ["name", "description", "version", "slug", "arch"]:
        if field not in config:
            errors.append(f"Missing required field: {field}")

    if "arch" in config and not isinstance(config["arch"], list):
        errors.append("arch must be a list")

    if "image" in config and "{arch}" not in str(config["image"]):
        errors.append("image must contain {arch} placeholder")

    if "options" in config and "schema" not in config:
        errors.append("schema is required when options is defined")

    if not (addon_dir / "Dockerfile").exists():
        errors.append("Dockerfile is missing")

    for e in errors:
        print(f"::error::{e}")

    if errors:
        sys.exit(1)

    print(f"Lint passed for {addon}")


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: lint_addon.py <addon_directory>")
        sys.exit(1)
    lint_addon(sys.argv[1])
