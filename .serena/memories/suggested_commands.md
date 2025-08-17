# Suggested Commands

## Development Commands
```bash
# Start local Jekyll server
bundle exec jekyll serve

# Build Jekyll site
bundle exec jekyll build

# Start Python server (fallback)
python3 -m http.server 8000

# Docker commands
docker-compose up -d        # Start with Docker
docker-compose down         # Stop Docker containers

# Make commands
make serve                  # Start local server
make test                   # Run tests
make clean                  # Clean build artifacts
```

## Jekyll-specific Commands
```bash
# Install Jekyll and dependencies
bundle install

# Update Jekyll gems
bundle update

# Create new Jekyll post
bundle exec jekyll post "Post Title"

# Check Jekyll configuration
bundle exec jekyll doctor
```

## Git Commands
```bash
# Standard workflow
git add .
git commit -m "Message"
git push origin main

# Deploy to GitHub Pages
git push origin main        # Automatic deployment
```

## Testing Commands
```bash
# Test workshop locally
python3 test-local.py

# Test specific workshop section
python3 test-workshop.sh

# Preflight check
python3 preflight-check.py
```

## System Utilities (Linux)
```bash
# File operations
ls -la                      # List files with details
find . -name "*.md"         # Find markdown files
grep -r "text" .            # Search in files
tree                        # Show directory structure

# Process management
ps aux | grep jekyll        # Check Jekyll processes
kill -9 PID                 # Kill process by PID

# Network
netstat -tulpn              # Show open ports
curl -I http://localhost:4000  # Test local Jekyll server
```