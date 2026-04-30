#!/usr/bin/env python3
import os
import json
import subprocess
from pathlib import Path
import yaml

# Icon download mappings
ICON_SOURCES = {
    # LinuxServer addons (get from upstream project)
    "nginx": "https://nginx.org/nginx.png",
    "deluge": "https://raw.githubusercontent.com/deluge-torrent/deluge/develop/deluge/ui/web/images/logo.png",
    "mariadb": "https://mariadb.com/kb/static/images/logo-2x.png",
    "phpmyadmin": "https://www.phpmyadmin.net/static/images/logo.png",
    "rabbitmq": "https://www.rabbitmq.com/img/RabbitMQ-logo-symbol.png",
    "telegram": "https://telegram.org/img/t_logo.png",
    "syncthing": "https://raw.githubusercontent.com/syncthing/syncthing/main/assets/logo-horizontal.svg",
    
    # Custom/GitHub addons
    "fail2ban": "https://raw.githubusercontent.com/fail2ban/fail2ban/master/doc/logo.png",
    "cops": "https://github.com/mikespub-org/seblucas-cops/raw/master/icon.png",
    "kimai": "https://raw.githubusercontent.com/kimai/kimai2/master/public/images/logo.png",
    "piper": "https://raw.githubusercontent.com/rhasspy/piper/master/piper.png",
    "ngircd": "https://raw.githubusercontent.com/ngircd/ngircd/master/doc/logo.png",
    "oscam": "https://raw.githubusercontent.com/E2OpenPlugins/e2openplugin-OpenCam/master/plugin/oscam.png",
    "hisshtory-server": "https://raw.githubusercontent.com/ddpom/hishtory/main/client/data/hishtory.png",
    "lightrag": "https://raw.githubusercontent.com/HKUDS/LightRAG/main/lightrag.png",
    "darktable": "https://raw.githubusercontent.com/darktable-org/darktable/master/src/dtgtk/icons/logo.svg",
}

# Default sources for LinuxServer addons (try common locations)
LSIO_PATTERNS = [
    "https://raw.githubusercontent.com/{upstream_repo}/master/icon.png",
    "https://github.com/{upstream_repo}/raw/master/icon.png",
]

def get_addon_url(addon_dir):
    """Extract URL from config.yaml"""
    config_file = Path(addon_dir) / "config.yaml"
    if not config_file.exists():
        return None
    
    try:
        with open(config_file) as f:
            config = yaml.safe_load(f)
            return config.get('url')
    except:
        return None

def download_icon(addon, url, max_retries=3):
    """Download icon with retries"""
    addon_dir = Path(addon)
    icon_path = addon_dir / "icon.png"
    
    for attempt in range(max_retries):
        try:
            result = subprocess.run(
                ["curl", "-s", "-L", "--max-time", "10", url, "-o", str(icon_path)],
                capture_output=True,
                timeout=15
            )
            
            if result.returncode == 0 and icon_path.exists():
                # Verify it's a valid image
                file_result = subprocess.run(
                    ["file", str(icon_path)],
                    capture_output=True,
                    text=True
                )
                
                content = file_result.stdout
                if "PNG image" in content or "JPEG image" in content or "SVG" in content:
                    return True
                else:
                    # Try to convert if it's SVG
                    if "SVG" in content:
                        convert_svg_to_png(str(icon_path))
                        return True
        except Exception as e:
            print(f"  Attempt {attempt+1} failed: {e}")
    
    return False

def convert_svg_to_png(svg_path):
    """Convert SVG to PNG"""
    png_path = svg_path.replace('.svg', '.png')
    try:
        subprocess.run(
            ["convert", "-background", "none", "-resize", "128x128", svg_path, png_path],
            timeout=10
        )
        if Path(png_path).exists():
            os.remove(svg_path)
            return True
    except:
        pass
    return False

def main():
    addons = sorted([d for d in os.listdir('.') 
                    if Path(d).is_dir() and (Path(d) / "config.yaml").exists() 
                    and d not in ["Stats", "Stats2"]])
    
    print("=" * 60)
    print("Icon Download Script")
    print("=" * 60)
    print(f"Found {len(addons)} addons to process\n")
    
    success = 0
    failed = 0
    
    for idx, addon in enumerate(addons, 1):
        print(f"[{idx}/{len(addons)}] {addon:30}", end=" ", flush=True)
        
        # Check if icon already exists
        icon_path = Path(addon) / "icon.png"
        if icon_path.exists():
            size = icon_path.stat().st_size
            if size > 100:  # Reasonable size for an icon
                print(f"✓ (existing, {size} bytes)")
                success += 1
                continue
        
        # Try custom mapping first
        if addon in ICON_SOURCES:
            url = ICON_SOURCES[addon]
            if download_icon(addon, url):
                print("✓")
                success += 1
            else:
                print("✗")
                failed += 1
        else:
            # For LinuxServer addons, try to extract from URL
            addon_url = get_addon_url(addon)
            if addon_url and "linuxserver" in addon_url:
                # Extract repo name
                parts = addon_url.rstrip('/').split('/')
                upstream_repo = '/'.join(parts[-2:])
                url = f"https://raw.githubusercontent.com/{upstream_repo}/master/icon.png"
                
                if download_icon(addon, url):
                    print("✓")
                    success += 1
                else:
                    print("✗")
                    failed += 1
            else:
                # Try direct GitHub download
                if addon_url:
                    # Assume it's a GitHub repo
                    url = addon_url.rstrip('/') + "/raw/master/icon.png"
                    if download_icon(addon, url):
                        print("✓")
                        success += 1
                    else:
                        print("✗")
                        failed += 1
                else:
                    print("? (no URL found)")
                    failed += 1
    
    print("\n" + "=" * 60)
    print(f"Results: {success} successful, {failed} failed")
    print("=" * 60)

if __name__ == "__main__":
    main()
