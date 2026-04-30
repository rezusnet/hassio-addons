#!/usr/bin/env python3
import os
import subprocess
import json
from pathlib import Path
import time

# Load icon source mappings
with open('icon_sources.json') as f:
    SOURCES = json.load(f)

# Additional common image patterns to try
COMMON_PATHS = [
    "icon.png", "icon.svg", "logo.png", "logo.svg",
    "assets/icon.png", "assets/logo.png",
    "public/images/logo.png", "public/img/logo.png",
    "src/assets/logo.svg", "src/assets/logo.png",
    ".github/logo.png", ".github/assets/logo.png",
    "docs/images/logo.png", "img/logo.png",
    "images/logo.png", "static/images/logo.png",
    "README.png", "screenshot.png",
]

def find_repo_files(owner, repo, pattern_keywords):
    """Search for files matching keywords in repo"""
    try:
        result = subprocess.run(
            ["curl", "-s",
             f"https://api.github.com/repos/{owner}/{repo}/git/trees/master?recursive=1"],
            capture_output=True,
            text=True,
            timeout=8
        )
        
        if result.returncode == 0:
            try:
                data = json.loads(result.stdout)
                files = data.get('tree', [])
                
                # Look for matching files
                for f in files:
                    if f.get('type') == 'blob':
                        path = f.get('path', '').lower()
                        if any(kw in path for kw in pattern_keywords):
                            if any(ext in path for ext in ['.png', '.svg', '.ico', '.jpg', '.jpeg']):
                                return f.get('path')
            except:
                pass
    except:
        pass
    
    return None

def try_direct_urls(addon, owner, repo):
    """Try common direct URLs in order"""
    urls_to_try = []
    
    # Add common paths
    for path in COMMON_PATHS:
        for branch in ["master", "main"]:
            urls_to_try.append(
                f"https://raw.githubusercontent.com/{owner}/{repo}/{branch}/{path}"
            )
    
    # Add addon-specific patterns
    for branch in ["master", "main"]:
        urls_to_try.extend([
            f"https://raw.githubusercontent.com/{owner}/{repo}/{branch}/{addon}.png",
            f"https://raw.githubusercontent.com/{owner}/{repo}/{branch}/{addon}.svg",
        ])
    
    icon_path = Path(addon) / "icon.png"
    
    for url in urls_to_try:
        try:
            result = subprocess.run(
                ["curl", "-s", "-L", "--max-time", "5", 
                 "-H", "User-Agent: Mozilla/5.0", url, "-o", str(icon_path)],
                capture_output=True,
                timeout=8
            )
            
            if result.returncode == 0 and icon_path.exists():
                size = icon_path.stat().st_size
                if size > 200:  # Reasonable size
                    return True
        except:
            pass
        
        # Cleanup failed attempt
        try:
            icon_path.unlink()
        except:
            pass
    
    return False

def convert_to_png(addon_dir):
    """Convert image to PNG 128x128"""
    icon_path = Path(addon_dir) / "icon.png"
    
    if not icon_path.exists():
        return False
    
    temp_path = Path(addon_dir) / ".temp_icon"
    icon_path.rename(temp_path)
    
    try:
        # Try convert command
        subprocess.run(
            ["convert", str(temp_path), 
             "-resize", "128x128",
             "-background", "white", "-flatten",
             str(icon_path)],
            timeout=10,
            capture_output=True
        )
        
        if not icon_path.exists():
            # Try magick as fallback
            subprocess.run(
                ["magick", str(temp_path),
                 "-resize", "128x128",
                 "-background", "white", "-flatten",
                 str(icon_path)],
                timeout=10,
                capture_output=True
            )
        
        if icon_path.exists():
            try:
                temp_path.unlink()
            except:
                pass
            return True
    except:
        pass
    
    # Restore if conversion failed
    try:
        if temp_path.exists():
            temp_path.rename(icon_path)
    except:
        pass
    
    return False

def main():
    print("=" * 75)
    print("Comprehensive Icon Getter v2")
    print("=" * 75)
    print()
    
    addons = sorted([d for d in os.listdir('.') 
                    if Path(d).is_dir() and (Path(d) / "config.yaml").exists() 
                    and d not in ["Stats", "Stats2"]])
    
    success = 0
    failed = []
    
    for idx, addon in enumerate(addons, 1):
        addon_dir = Path(addon)
        icon_path = addon_dir / "icon.png"
        
        # Check existing icon
        if icon_path.exists():
            size = icon_path.stat().st_size
            if size > 1000:
                print(f"[{idx:2d}] {addon:30} ✓ (existing)")
                success += 1
                continue
            elif size > 200:
                print(f"[{idx:2d}] {addon:30} ", end="", flush=True)
                if convert_to_png(addon_dir):
                    print("✓ (resized)")
                    success += 1
                    continue
                else:
                    print("(kept as-is)")
                    success += 1
                    continue
        
        print(f"[{idx:2d}] {addon:30} ", end="", flush=True)
        
        if addon not in SOURCES:
            print("? (no source)")
            failed.append(addon)
            continue
        
        source = SOURCES[addon]
        
        if source.get("type") == "github":
            repo = source["repo"]
            parts = repo.split("/")
            if len(parts) == 2:
                owner, repo_name = parts
                paths = source.get("paths", [])
                
                print("↓", end="", flush=True)
                if try_direct_urls(addon, owner, repo_name):
                    print("✓", end="", flush=True)
                    if convert_to_png(addon_dir):
                        print(" (converted)")
                    else:
                        print(" (as-is)")
                    success += 1
                    continue
        
        print("✗")
        failed.append(addon)
    
    print()
    print("=" * 75)
    print(f"Results: {success}/{len(addons)} successful")
    if failed:
        print(f"Failed: {len(failed)}")
        print()
        for addon in failed[:15]:
            print(f"  - {addon}")
        if len(failed) > 15:
            print(f"  ... and {len(failed)-15} more")
    print("=" * 75)

if __name__ == "__main__":
    main()
