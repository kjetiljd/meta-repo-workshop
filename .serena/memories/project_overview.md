# Meta-Repository Workshop Project Overview

## Purpose
This is a GitHub Pages workshop project for JavaZone 2025 about meta-repository patterns. The project teaches developers how to manage multiple repositories using the `meta` NPM tool.

## Current Status
- **Current setup**: Static HTML site with `.nojekyll` file (disabling Jekyll)
- **User preference**: Wants to convert to Jekyll
- **Backup available**: `_config.yml.backup` exists with previous Jekyll configuration

## Tech Stack
- **Frontend**: Static HTML, CSS, JavaScript
- **Presentation**: Reveal.js for slides
- **Workshop**: 8 hands-on exercises in `workshop/` directory
- **Deployment**: GitHub Pages
- **Development**: Python HTTP server for local testing
- **Containerization**: Docker support available

## Main Components
1. **Landing Page**: `index.html` - Beautiful hero page with workshop info
2. **Slides**: `slides/` directory with Reveal.js presentation
3. **Workshop**: `workshop/` with 8 practical exercises
4. **Resources**: Supporting materials and troubleshooting guides

## Structure
```
meta-repo-workshop/
├── index.html              # Main landing page
├── slides/                 # Reveal.js presentation
├── workshop/               # 8 hands-on exercises
│   ├── 01-setup/
│   ├── 02-commands/
│   ├── 03-automation/
│   └── solutions/
├── resources/              # Extra materials
├── docker/                 # Docker configuration
├── _config.yml.backup      # Previous Jekyll config
└── .nojekyll              # Currently disables Jekyll
```