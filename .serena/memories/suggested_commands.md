# Suggested Commands
## Core Dev / Preview
- make serve            # Build Docker image & serve Jekyll at http://localhost:4000
- make serve-daemon     # Background container; pair with `make logs` / `make stop`
- make serve-local      # Run Jekyll directly via Bundler (no Docker)
- make rebuild          # Clean + build fresh image
- make clean            # Remove image & stop/remove container
- python3 -m http.server 8000  # Fallback static serve (no Jekyll processing)

## Ruby / Jekyll
- bundle install        # Install gem dependencies
- bundle exec jekyll serve --livereload
- bundle exec jekyll build

## Meta Tool (global npm)
- npm install -g meta           # Install meta CLI
- meta git status               # Show git status across repos
- meta git pull                 # Pull all
- meta git branch               # List branches per repo
- meta exec "<cmd>"             # Run arbitrary command in each repo
- meta git clone                # Clone all defined repos
- meta project add <name> <url> # Add a new repo mapping

## Housekeeping / Analysis
- cloc .                        # Line count (ensure cloc installed)
- git log --oneline --graph --decorate --all  # Visual history (root repo)

## Docker
- docker build -t meta-repo-workshop .
- docker run --rm -p 4000:4000 -v "$PWD":/srv/jekyll meta-repo-workshop

## Deployment
- git push origin main          # Triggers GitHub Actions build & Pages deploy (ensure Pages source = Actions)

## Troubleshooting Snippets
- chmod +x <script>             # Fix permission denied on scripts
- git config --global url."https://github.com/".insteadOf git@github.com:  # Switch SSH->HTTPS
- npm install -g meta            # Reinstall meta if command missing

## Verification / Quick Checks
- curl -I http://localhost:4000  # Confirm local server up (Docker/Jekyll)
- open http://localhost:4000     # macOS convenience (or xdg-open on Linux)
- ls workshop/solutions          # Inspect available solution scripts
