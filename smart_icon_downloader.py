#!/usr/bin/env python3
import os
import subprocess
import json
from pathlib import Path
from urllib.parse import urljoin
import time

# Load icon source mappings
with open('icon_sources.json') as f:
    SOURCES = json.load(f)

def try_download(url, addon_dir, retry_count=2):
    """Try to download a URL"""
    icon_path = Path(addon_dir) / "icon.png"
    
    for attempt in range(retry_count):
        try:
            # Download with curl
            result = subprocess.run(
                ["curl", "-s", "-L", "--max-time", "8", "-H", 
                 "User-Agent: Mozilla/5.0", url, "-o", str(icon_path)],
                capture_output=True,
                timeout=12
            )
            
            if result.returncode == 0 and icon_path.exists():
                size = icon_path.stat().st_size
                if size > 100:  # Reasonable icon size
                    # Verify with file command
                    file_result = subprocess.run(
                        ["file", str(icon_path)],
                        capture_output=True,
                        text=True
                    )
                    content_type = file_result.stdout.lower()
                    
                    # Accept images and convert if needed
                    if any(x in content_type for x in ["image", "png", "jpeg", "svg", "ico"]):
                        return True
        except Exception as e:
            if attempt < retry_count - 1:
                time.sleep(0.5)
    
    # Cleanup on failure
    try:
        Path(icon_path).unlink()
    except:
        pass
    return False

def convert_image(addon_dir):
    """Convert downloaded image to PNG 128x128"""
    icon_path = Path(addon_dir) / "icon.png"
    temp_path = Path(addon_dir) / ".icon_temp"
    
    if not icon_path.exists():
        return False
    
    try:
        # Rename original
        icon_path.rename(temp_path)
        
        # Try ImageMagick convert
        result = subprocess.run(
            ["convert", str(temp_path), 
             "-resize", "128x128",
             "-background", "white", "-flatten",
             str(icon_path)],
            timeout=15,
            capture_output=True
        )
        
        # Fallback to magick if convert fails
        if result.returncode != 0:
            subprocess.run(
                ["magick", str(temp_path),
                 "-resize", "128x128",
                 "-background", "white", "-flatten",
                 str(icon_path)],
                timeout=15,
                capture_output=True
            )
        
        # Cleanup
        try:
            temp_path.unlink()
        except:
            pass
        
        return icon_path.exists() and icon_path.stat().st_size > 100
    except Exception as e:
        # Restore original
        if temp_path.exists():
            try:
                temp_path.rename(icon_path)
            except:
                pass
        return False

def find_icon_in_github_repo(owner, repo, paths):
    """Find and download icon from GitHub repo"""
    for path in paths:
        url = f"https://raw.githubusercontent.com/{owner}/{repo}/master/{path}"
        
        # Try master first, then main
        for branch in ["master", "main"]:
            test_url = f"https://raw.githubusercontent.com/{owner}/{repo}/{branch}/{path}"
            
            # Quick HEAD check
            try:
                result = subprocess.run(
                    ["curl", "-s", "-I", "-L", "--max-time", "5", test_url],
                    capture_output=True,
                    text=True,
                    timeout=8
                )
                
                if result.returncode == 0 and "200" in result.stdout:
                    return test_url
            except:
                pass
    
    return None

def main():
    print("=" * 75)
    print("Smart Icon Downloader for Home Assistant Addons")
    print("=" * 75)
    print()
    
    addons = sorted([d for d in os.listdir('.') 
                    if Path(d).is_dir() and (Path(d) / "config.yaml").exists() 
                    and d not in ["Stats", "Stats2"]])
    
    success = 0
    failed = []
    skipped = 0
    
    for idx, addon in enumerate(addons, 1):
        addon_dir = Path(addon)
        icon_path = addon_dir / "icon.png"
        
        # Check if already has large valid icon
        if icon_path.exists():
            size = icon_path.stat().st_size
            if size > 1000:
                print(f"[{idx:2d}/{len(addons)}] {addon:30} ✓ (existing, {size//1024}KB)")
                success += 1
                continue
            elif size > 100:
                print(f"[{idx:2d}/{len(addons)}] {addon:30} ✓ (exists, will resize)")
                if convert_image(addon_dir):
                    success += 1
                    continue
        
        print(f"[{idx:2d}/{len(addons)}] {addon:30} ", end="", flush=True)
        
        if addon not in SOURCES:
            print("? (no source)")
            failed.append((addon, "no mapping"))
            continue
        
        source = SOURCES[addon]
        icon_url = None
        
        if source["type"] == "github":
            repo = source["repo"]
            paths = source.get("paths", [])
            owner_repo = repo.split("/")
            if len(owner_repo) == 2:
                icon_url = find_icon_in_github_repo(owner_repo[0], owner_repo[1], paths)
        
        if not icon_url:
            print("✗ (no icon URL)")
            failed.append((addon, "URL not found"))
            continue
        
        # Download
        print(f"→ ", end="", flush=True)
        if try_download(icon_url, addon_dir):
            print("✓", end="")
            # Try to convert/resize
            if convert_image(addon_dir):
                print(" (converted)")
                success += 1
            else:
                print(" (as-is)")
                success += 1
        else:
            print("✗")
            failed.append((addon, "download failed"))
    
    print()
    print("=" * 75)
    print(f"Results: {success}/{len(addons)} successful, {len(failed)} failed")
    if failed:
        print()
        print("Failed addons:")
        for addon, reason in failed[:20]:
            print(f"  - {addon:30} ({reason})")
        if len(failed) > 20:
            print(f"  ... and {len(failed) - 20} more")
    print("=" * 75)

if __name__ == "__main__":
    main()
