echo "$GHCR_TOKEN" | docker login ghcr.io -u "$1" --password-stdin

