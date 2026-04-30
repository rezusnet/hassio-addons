#!/usr/bin/env python3
import os
import subprocess
from pathlib import Path
import yaml
import re

def get_addon_config(addon_dir):
    """Extract config from config.yaml"""
    config_file = Path(addon_dir) / "config.yaml"
    if not config_file.exists():
        return None, None
    
    try:
        with open(config_file) as f:
            config = yaml.safe_load(f)
            url = config.get('url', '')
            desc = config.get('description', '')
            return url, desc
    except:
        return None, None

def find_github_repo_icon(github_url):
    """Find icon in a GitHub repository"""
    if not github_url or 'github.com' not in github_url:
        return None
    
    # Normalize the URL
    github_url = github_url.rstrip('/')
    parts = github_url.replace('https://github.com/', '').split('/')
    if len(parts) < 2:
        return None
    
    owner, repo = parts[0], parts[1]
    
    # Try common icon locations
    icon_urls = [
        f"https://raw.githubusercontent.com/{owner}/{repo}/master/icon.png",
        f"https://raw.githubusercontent.com/{owner}/{repo}/master/logo.png",
        f"https://raw.githubusercontent.com/{owner}/{repo}/main/icon.png",
        f"https://raw.githubusercontent.com/{owner}/{repo}/main/logo.png",
        f"https://raw.githubusercontent.com/{owner}/{repo}/main/assets/icon.png",
        f"https://raw.githubusercontent.com/{owner}/{repo}/master/assets/icon.png",
        f"https://raw.githubusercontent.com/{owner}/{repo}/master/public/images/logo.png",
        f"https://raw.githubusercontent.com/{owner}/{repo}/main/public/images/logo.png",
        f"https://raw.githubusercontent.com/{owner}/{repo}/master/src/dtgtk/icons/logo.svg",
        f"https://raw.githubusercontent.com/{owner}/{repo}/master/res/icons/appicon-128.png",
        f"https://raw.githubusercontent.com/{owner}/{repo}/main/piper.png",
    ]
    
    # Try each URL
    for url in icon_urls:
        try:
            result = subprocess.run(
                ["curl", "-s", "-I", "-L", "--max-time", "5", url],
                capture_output=True,
                text=True,
                timeout=10
            )
            
            # Check if it's accessible and likely an image
            if result.returncode == 0 and ("image" in result.stdout.lower() or "png" in url.lower()):
                return url
        except:
            pass
    
    return None

def download_and_convert(addon, url):
    """Download and convert icon to 128x128 PNG"""
    addon_dir = Path(addon)
    icon_path = addon_dir / "icon.png"
    temp_path = addon_dir / "temp_icon"
    
    try:
        # Download
        result = subprocess.run(
            ["curl", "-s", "-L", "--max-time", "10", url, "-o", str(temp_path)],
            capture_output=True,
            timeout=15
        )
        
        if result.returncode != 0 or not temp_path.exists():
            return False
        
        # Check file type
        file_result = subprocess.run(
            ["file", str(temp_path)],
            capture_output=True,
            text=True
        )
        
        content = file_result.stdout.lower()
        
        # Convert if needed
        if "svg" in content:
            # Convert SVG to PNG
            subprocess.run(
                ["convert", "-background", "none", "-resize", "128x128", 
                 str(temp_path), str(icon_path)],
                timeout=15
            )
            temp_path.unlink(missing_ok=True)
        elif "png" in content or "jpeg" in content or "jpg" in content:
            # Resize to 128x128 if not already
            subprocess.run(
                ["convert", str(temp_path), "-resize", "128x128",  
                 "-background", "white", "-flatten", str(icon_path)],
                timeout=15
            )
            temp_path.unlink(missing_ok=True)
        else:
            # Try generic conversion
            subprocess.run(
                ["convert", str(temp_path), "-resize", "128x128", str(icon_path)],
                timeout=15
            )
            temp_path.unlink(missing_ok=True)
        
        # Verify result
        if icon_path.exists() and icon_path.stat().st_size > 100:
            return True
    except Exception as e:
        print(f"    Error: {e}")
    
    # Cleanup
    temp_path.unlink(missing_ok=True)
    icon_path.unlink(missing_ok=True)
    return False

def main():
    addons = sorted([d for d in os.listdir('.') 
                    if Path(d).is_dir() and (Path(d) / "config.yaml").exists() 
                    and d not in ["Stats", "Stats2"]])
    
    print("=" * 70)
    print("Detailed Icon Finder & Downloader")
    print("=" * 70)
    print()
    
    success = 0
    failed = []
    
    for idx, addon in enumerate(addons, 1):
        addon_dir = Path(addon)
        icon_path = addon_dir / "icon.png"
        
        # Skip if already has valid icon
        if icon_path.exists() and icon_path.stat().st_size > 500:
            print(f"[{idx:2d}/{len(addons)}] {addon:30} ✓ (existing)")
            success += 1
            continue
        
        print(f"[{idx:2d}/{len(addons)}] {addon:30} ", end="", flush=True)
        
        # Get config
        url, desc = get_addon_config(addon)
        
        if not url:
            print("✗ (no URL)")
            failed.append((addon, "no URL"))
            continue
        
        print(f"→ {url[:50]:50} ", end="", flush=True)
        
        # Find icon
        icon_url = find_github_repo_icon(url)
        
        if not icon_url:
            print("✗ (icon not found)")
            failed.append((addon, "icon not found"))
            continue
        
        # Download and convert
        if download_and_convert(addon, icon_url):
            print("✓")
            success += 1
        else:
            print("✗ (download failed)")
            failed.append((addon, "download failed"))
    
    print()
    print("=" * 70)
    print(f"Results: {success}/{len(addons)} successful")
    print()
    if failed:
        print(f"Failed ({len(failed)}):")
        for addon, reason in failed:
            print(f"  - {addon:30} ({reason})")
    print("=" * 70)

if __name__ == "__main__":
    main()
