# Meta-repo workshop tools image for Windows (and others)
# Includes: node/npm, meta, meta-git, git, make, cloc

FROM node:20-bookworm-slim

LABEL org.opencontainers.image.title="meta-repo-workshop tools"
LABEL org.opencontainers.image.description="Tools image for the workshop: meta, git, make, cloc, Node.js"
LABEL org.opencontainers.image.source="https://github.com/kjetiljd/meta-repo-workshop"

# System tools needed by the workshop
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       git \
       make \
       cloc \
       ca-certificates \
       openssh-client \
       bash \
    && rm -rf /var/lib/apt/lists/*

# Install meta CLI and useful plugins globally
RUN npm install -g meta meta-git

# Default working directory will be the project mount
WORKDIR /work

# Provide an entrypoint that makes git happy with mounted volumes
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["bash"]

