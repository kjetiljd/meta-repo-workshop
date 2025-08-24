$env:GHCR_TOKEN | docker login ghcr.io -u $args[0] --password-stdin

