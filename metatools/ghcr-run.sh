docker run --rm -it \
  -v "$PWD:/work" -w /work \
  -e "GIT_USER_NAME=$(git config user.name || echo '')" \
  -e "GIT_USER_EMAIL=$(git config user.email || echo '')" \
  ghcr.io/kjetiljd/meta-repo-workshop-tools:latest bash

