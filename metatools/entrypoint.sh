#!/usr/bin/env bash
set -euo pipefail

# Make git accept mounted work directories (useful on Windows/WSL/host volumes)
# Accept /work explicitly and any other mounted paths as safe.
if command -v git >/dev/null 2>&1; then
  git config --global --add safe.directory /work || true
  git config --global --add safe.directory "*" || true

  # Optionally set git identity from env vars
  if [ -n "${GIT_USER_NAME:-}" ]; then
    git config --global user.name "$GIT_USER_NAME" || true
  fi
  if [ -n "${GIT_USER_EMAIL:-}" ]; then
    git config --global user.email "$GIT_USER_EMAIL" || true
  fi
fi

exec "$@"

