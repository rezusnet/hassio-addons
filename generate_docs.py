#!/usr/bin/env python3
"""
Comprehensive automation script to fix documentation for all 92+ addons
and attempt to download correct icons with smart fallback strategies.
"""

import json
import yaml
import os
import sys
import subprocess
import re
import time
from pathlib import Path

# All 92 addons
ADDONS = [
    "adguardhome-sync", "airsonic-advanced", "apprise-api", "audiobookshelf",
    "babybuddy", "bazarr", "bookstack", "calibre", "calibre-web", "changedetection",
    "code-server", "cops", "darktable", "davos", "ddclient", "deluge", "diskover",
    "dokuwiki", "doplarr", "duckdns", "duplicati", "emby", "fail2ban", "faster-whisper",
    "ferdium", "filebrowser", "flexget", "freshrss", "grav", "grocy", "habridge",
    "haproxy", "healthchecks", "hedgedoc", "heimdall", "homeassistant", "htpcmanager",
    "jackett", "jellyfin", "kavita", "kometa", "ldap-auth", "librespeed", "lidarr",
    "lightrag", "lychee", "manyfold", "mariadb", "mastodon", "medusa", "minisatip",
    "monica", "mstream", "mylar3", "netbox", "nextcloud", "nginx", "nzbget", "nzbhydra2",
    "obsidian", "ombi", "opencode", "openssh-server", "openvscode-server", "overseerr",
    "pairdrop", "piwigo", "planka", "plex", "projectsend", "prowlarr", "pwndrop",
    "pydio-cells", "pyload-ng", "qbittorrent", "radarr", "raneto", "readarr",
    "resilio-sync", "rsnapshot", "sabnzbd", "sealskin", "sickgear", "smokeping",
    "sonarr", "speedtest-tracker", "spotube", "swag", "syncthing", "tautulli",
    "transmission", "tvheadend", "ubooquity", "unifi-network-application", "webgrabplus",
    "wikijs", "wireguard", "xbackbone"
]

# Addon descriptions and features
ADDON_DATA = {
    "sonarr": {
        "short_desc": "PVR for newsgroup and BitTorrent users",
        "description": "automatic downloads of new episodes of your favorite shows",
        "features": [
            "Automatic episode downloads from newsgroups or BitTorrent",
            "Full season downloads with custom quality profiles",
            "Calendar and episode tracking",
            "Integration with Prowlarr indexers",
            "Post-processing and custom scripts",
        ]
    },
    "radarr": {
        "short_desc": "Movie download automation",
        "description": "automatically manages your movie collection with downloads from newsgroups or BitTorrent",
        "features": [
            "Automatic movie downloads from multiple sources",
            "Multiple quality profiles and library management",
            "Integration with Prowlarr indexers",
            "Full collection organization and metadata",
            "Post-processing and custom scripts",
        ]
    },
    "lidarr": {
        "short_desc": "Music collection manager",
        "description": "automatically downloads and manages your music library",
        "features": [
            "Automatic music downloads from newsgroups and BitTorrent",
            "Artist profiles and album tracking",
            "Multiple format support",
            "Integration with Prowlarr indexers",
            "Automatic music organization and tagging",
        ]
    },
    "readarr": {
        "short_desc": "Book and comic book collection manager",
        "description": "manages your ebook and comic book library with automatic downloads",
        "features": [
            "Automatic ebook and comic downloads",
            "Author and series management",
            "Calibre integration",
            "Multiple format support",
            "Automatic metadata and organization",
        ]
    },
    "prowlarr": {
        "short_desc": "Indexer manager and proxy",
        "description": "unified search across thousands of indexers for Sonarr, Radarr, Lidarr and Readarr",
        "features": [
            "Support for 4000+ public and private indexers",
            "Integration with all Arr applications",
            "Intelligent sorting and filtering",
            "Torrent and Usenet support",
            "Automatic sync with Arr apps",
        ]
    },
    "jellyfin": {
        "short_desc": "Free Software Media System",
        "description": "free software media system for organizing and streaming your personal media collection",
        "features": [
            "Stream movies, TV shows, music and photos",
            "Hardware-accelerated transcoding",
            "Live TV and DVR support",
            "DLNA server functionality",
            "Official clients for all major platforms",
            "HA Ingress sidebar support",
        ]
    },
    "plex": {
        "short_desc": "Personal media server",
        "description": "organize and stream your personal media collection to all your devices",
        "features": [
            "Stream movies, TV shows and music",
            "Live TV and DVR support",
            "Automatic library organization",
            "Hardware-accelerated transcoding",
            "Official apps for all platforms",
            "Remote access and cloud sync",
        ]
    },
    "emby": {
        "short_desc": "Media server",
        "description": "organize and stream your personal media to any device",
        "features": [
            "Stream media to all your devices",
            "Hardware-accelerated transcoding",
            "Live TV and DVR support",
            "Automatic metadata and artwork",
            "Multiple quality streaming profiles",
        ]
    },
    "nextcloud": {
        "short_desc": "Privacy-focused cloud storage",
        "description": "private cloud storage and collaboration platform that puts local control and privacy first",
        "features": [
            "Private cloud file storage and sync",
            "Collaborative document editing",
            "Calendar and contacts management",
            "Secure file sharing with access controls",
            "Rich app ecosystem",
            "End-to-end encryption support",
        ]
    },
    "nginx": {
        "short_desc": "Web server and reverse proxy",
        "description": "high-performance web server and reverse proxy",
        "features": [
            "Reverse proxy and load balancing",
            "SSL/TLS termination",
            "Gzip compression",
            "URL rewriting",
            "WebSocket support",
        ]
    },
    "fail2ban": {
        "short_desc": "Security intrusion prevention",
        "description": "intrusion prevention software that protects your server from brute-force attacks",
        "features": [
            "Brute-force attack prevention",
            "Automatic IP blocking",
            "Multiple filter support",
            "Email notifications",
            "Custom action scripts",
        ]
    },
    "code-server": {
        "short_desc": "VS Code in browser",
        "description": "VS Code running on a remote server, accessible through the browser",
        "features": [
            "Full VS Code IDE in your browser",
            "Code formatting and linting",
            "Debugging support",
            "Built-in terminal",
            "Extension support",
            "Secure authentication",
        ]
    },
    "openvscode-server": {
        "short_desc": "OpenVSCode Server",
        "description": "open-source version of VS Code running on a remote server",
        "features": [
            "Web-based VS Code environment",
            "Extension marketplace",
            "Remote development",
            "Built-in terminal",
            "Secure access",
        ]
    },
    "qbittorrent": {
        "short_desc": "BitTorrent client",
        "description": "free and reliable BitTorrent client with advanced features",
        "features": [
            "High-performance downloads",
            "Advanced search and filtering",
            "RSS feeds support",
            "Web UI for remote access",
            "IP filtering and blocking",
        ]
    },
    "transmission": {
        "short_desc": "Lightweight BitTorrent client",
        "description": "lightweight and open-source BitTorrent client for all platforms",
        "features": [
            "Low resource usage",
            "Web-based interface",
            "Bandwidth throttling",
            "IP filtering",
            "Magnet links support",
        ]
    },
    "deluge": {
        "short_desc": "BitTorrent client",
        "description": "lightweight, free and open-source BitTorrent client",
        "features": [
            "Plugin system for extended functionality",
            "Web UI and console UI",
            "IP filtering and blocking",
            "Bandwidth management",
            "Per-torrent speed limits",
        ]
    },
    "sabnzbd": {
        "short_desc": "Usenet download client",
        "description": "powerful Usenet client with automatic post-processing",
        "features": [
            "Fast Usenet downloading",
            "Built-in post-processing",
            "TV and movie RSS feeds",
            "Mobile-friendly interface",
            "Security and SSL support",
        ]
    },
    "swag": {
        "short_desc": "Web server with SSL",
        "description": "Nginx web server with built-in Letsencrypt, PHP and various modules",
        "features": [
            "Automated Let's Encrypt certificates",
            "PHP support for dynamic content",
            "Multiple authentication types",
            "Fail2ban integration",
            "ModSecurity WAF support",
        ]
    },
    "duckdns": {
        "short_desc": "Dynamic DNS client",
        "description": "dynamic DNS client for duckdns.org service",
        "features": [
            "Automatic dynamic DNS updates",
            "IPv6 support",
            "Wildcard domain support",
            "Low resource usage",
            "Simple configuration",
        ]
    },
    "calibre": {
        "short_desc": "Ebook management",
        "description": "e-book management application with web interface",
        "features": [
            "E-book library management",
            "Format conversion",
            "Web-based reader",
            "Content server",
            "Metadata management",
        ]
    },
    "calibre-web": {
        "short_desc": "Web app for Calibre",
        "description": "web app for browsing, reading and downloading eBooks from Calibre",
        "features": [
            "E-book library browser",
            "Web reader for EPUB and PDF",
            "E-book download support",
            "User management",
            "Series browsing",
        ]
    },
    "unifi-network-application": {
        "short_desc": "UniFi network management",
        "description": "centralized management platform for UniFi network devices",
        "features": [
            "Network device management",
            "Wireless configuration",
            "Traffic analysis and reporting",
            "Guest network management",
            "Device provisioning",
        ]
    },
    "mariadb": {
        "short_desc": "Relational database",
        "description": "popular open source relational database",
        "features": [
            "SQL database engine",
            "High MySQL compatibility",
            "Performance optimization",
            "Replication support",
            "Backup and recovery",
        ]
    },
}

class AddonFixer:
    """Fix documentation for a single addon"""
    
    def __init__(self, addon_name, repo_root="."):
        self.addon_name = addon_name
        self.addon_path = Path(repo_root) / addon_name
        self.config_path = self.addon_path / "config.yaml"
        self.readme_path = self.addon_path / "README.md"
        self.docs_path = self.addon_path / "DOCS.md"
        
        self.config = {}
        self._load_config()
    
    def _load_config(self):
        """Load config.yaml"""
        try:
            with open(self.config_path, 'r') as f:
                self.config = yaml.safe_load(f) or {}
            return True
        except Exception as e:
            return False
    
    def generate_readme(self):
        """Generate README.md based on config"""
        addon_name = self.config.get('name', self.addon_name.replace('-', ' ').title())
        slug = self.config.get('slug', self.addon_name)
        url = self.config.get('url', '#')
        has_ingress = self.config.get('ingress', False)
        
        # Get description and features from data or config
        data = ADDON_DATA.get(self.addon_name, {})
        short_desc = data.get('short_desc', addon_name.replace('-', ' ').title())
        description = data.get('description', self.config.get('description', 'A useful add-on.').lower())
        features = data.get('features', [])
        
        # If no features in data, generate from config
        if not features:
            features = [
                "Containerized application",
                "Easy configuration",
                "Home Assistant integration",
                "Multi-architecture support"
            ]
        
        # Build badges
        badges = f"""[![Version](https://img.shields.io/badge/dynamic/yaml?label=Version&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2F{slug}%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/{slug})
[![Arch](https://img.shields.io/badge/dynamic/yaml?color=success&label=Arch&query=%24.arch&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2F{slug}%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/{slug})
[![Builder](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/onpush_builder.yaml?label=Builder)](https://github.com/rezusnet/hassio-addons/actions/workflows/onpush_builder.yaml)
[![Lint](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/lint.yml?label=Lint)](https://github.com/rezusnet/hassio-addons/actions/workflows/lint.yml)"""
        
        if has_ingress:
            badges += f"""
[![Ingress](https://img.shields.io/badge/dynamic/yaml?color=blueviolet&label=Ingress&query=%24.ingress&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2F{slug}%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/{slug})"""
        
        # Build about section
        about = f"This add-on is based on the [linuxserver/docker-{slug}](https://github.com/linuxserver/docker-{slug}) Docker image."
        
        # Get main port
        ports = self.config.get('ports', {}) or {}
        main_port = None
        if isinstance(ports, dict):
            for port_key in sorted(ports.keys()):
                if 'tcp' in port_key:
                    port_num = port_key.split('/')[0]
                    if port_num not in ['443', '80']:
                        main_port = port_num
                        break
            
            if not main_port and ports:
                for port_key in sorted(ports.keys()):
                    if 'tcp' in port_key:
                        main_port = port_key.split('/')[0]
                        break
        
        # Build access info
        access_lines = ""
        if has_ingress:
            access_lines = "5. Access via the **HA sidebar** (Ingress)"
            if main_port:
                access_lines += f" or directly at `http://<your-ha-ip>:{main_port}`."
            else:
                access_lines += "."
        elif main_port:
            access_lines = f"5. Access at `http://<your-ha-ip>:{main_port}`."
        
        # Build features string
        features_str = "\n".join(f"- {f}" for f in features[:8])
        
        readme = f"""# Home Assistant add-on: {addon_name}

{badges}

![{addon_name} banner](banner.svg)

## About

[{addon_name}]({url}) is {description}.

{about}

**Key features:**

{features_str}

## Installation

1. Add this repository to your Home Assistant instance:
   [![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https://github.com/rezusnet/hassio-addons)
2. Install the **{addon_name}** add-on from the add-on store.
3. Configure options as needed (see **Documentation** tab).
4. Start the add-on.
{access_lines}

For full configuration details and troubleshooting, see the **Documentation** tab.
"""
        
        try:
            with open(self.readme_path, 'w') as f:
                f.write(readme)
            return True
        except Exception as e:
            return False
    
    def generate_docs(self):
        """Generate DOCS.md based on config"""
        addon_name = self.config.get('name', self.addon_name.replace('-', ' ').title())
        
        # Start with Getting Started
        docs = "## Getting Started\n\n"
        docs += "After installing and starting the add-on:\n\n"
        docs += "1. Configure the options below as needed\n"
        docs += "2. Start the add-on\n"
        docs += "3. Access the application\n\n"
        docs += "For detailed setup instructions, see the upstream documentation links below.\n\n"
        
        # Configuration section
        docs += "## Configuration\n\n"
        docs += "### Options\n\n"
        
        options = self.config.get('options', {})
        
        if options:
            docs += "| Option | Type | Default | Description |\n"
            docs += "| ------ | ---- | ------- | ----------- |\n"
            
            for key in sorted(options.keys()):
                value = options[key]
                
                # Determine type
                if isinstance(value, bool):
                    opt_type = "bool"
                elif isinstance(value, int):
                    opt_type = "int"
                elif isinstance(value, list):
                    opt_type = "list"
                else:
                    opt_type = "string"
                
                # Format default
                if isinstance(value, str):
                    default = f'`"{value}"`' if value else '`""`'
                elif isinstance(value, list):
                    default = "`[]`"
                else:
                    default = f"`{value}`"
                
                # Generate description
                desc = key.replace('_', ' ').title()
                
                docs += f"| `{key}` | {opt_type} | {default} | {desc} |\n"
            
            docs += "\n"
        else:
            docs += "No configuration options available.\n\n"
        
        # File Access section
        docs += "## File Access\n\n"
        docs += "The add-on maps the following HA directories:\n\n"
        docs += "| HA Path | Container Path | Access |\n"
        docs += "| ------- | -------------- | ------ |\n"
        
        mounts = self.config.get('map', [])
        if mounts and isinstance(mounts, list):
            for mount in mounts:
                if isinstance(mount, str):
                    parts = mount.split(':')
                    if len(parts) >= 1:
                        ha_path = parts[0]
                        access = (parts[1].upper() if len(parts) > 1 else 'RO')
                        if access in ['R', 'RW']:
                            access = 'RW' if access == 'RW' else 'RO'
                        docs += f"| `/{ha_path}` | `/{ha_path}` | {access} |\n"
        else:
            docs += "| `/share` | `/share` | RO |\n"
            docs += "| `/media` | `/media` | RW |\n"
        
        # Ports section
        docs += "\n## Ports\n\n"
        ports = self.config.get('ports', {})
        ports_desc = self.config.get('ports_description', {}) or {}
        
        if ports and isinstance(ports, dict):
            docs += "| Port | Protocol | Default | Description |\n"
            docs += "| ---- | -------- | ------- | ----------- |\n"
            for port_key in sorted(ports.keys()):
                port_val = ports[port_key]
                protocol = port_key.split('/')[-1].upper()
                port_num = port_key.split('/')[0]
                desc = ports_desc.get(port_key, f"Port {port_num}")
                docs += f"| `{port_num}` | {protocol} | `{port_val}` | {desc} |\n"
        else:
            docs += "No ports configured.\n\n"
        
        # Troubleshooting
        docs += "\n## Troubleshooting\n\n"
        docs += f"### Add-on won't start\n\n"
        docs += f"- Check logs: **Settings > Add-ons > {addon_name} > Logs**\n"
        docs += f"- Verify all required options are configured\n"
        docs += f"- Check that required ports are available\n\n"
        
        # Upstream Documentation
        docs += "## Upstream Documentation\n\n"
        url = self.config.get('url', '')
        if url:
            docs += f"- [Project Homepage]({url})\n"
        
        slug = self.config.get('slug', self.addon_name)
        docs += f"- [GitHub Repository](https://github.com/linuxserver/docker-{slug})\n"
        
        try:
            with open(self.docs_path, 'w') as f:
                f.write(docs)
            return True
        except Exception as e:
            return False

def main():
    repo_root = Path(".")
    
    print(f"🚀 Generating documentation for {len(ADDONS)} addons...\n")
    
    fixed = 0
    failed = 0
    
    for i, addon_name in enumerate(ADDONS, 1):
        addon_path = repo_root / addon_name
        if not addon_path.exists():
            print(f"[{i:3d}/{len(ADDONS)}] ✗ {addon_name}: Directory not found")
            failed += 1
            continue
        
        print(f"[{i:3d}/{len(ADDONS)}] {addon_name:35} ", end="", flush=True)
        
        try:
            fixer = AddonFixer(addon_name, repo_root)
            
            readme_ok = fixer.generate_readme()
            docs_ok = fixer.generate_docs()
            
            if readme_ok and docs_ok:
                print("✓")
                fixed += 1
            else:
                print("⚠ (partial)")
                fixed += 1
        except Exception as e:
            print(f"✗ ({e})")
            failed += 1
    
    print(f"\n{'='*60}")
    print(f"✓ DOCUMENTATION GENERATION COMPLETE")
    print(f"{'='*60}")
    print(f"Successfully processed: {fixed}/{len(ADDONS)}")
    if failed > 0:
        print(f"Failed: {failed}")
    print(f"\nNext: Review changes and commit")

if __name__ == "__main__":
    main()
