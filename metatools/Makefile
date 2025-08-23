.DEFAULT_GOAL := help

# Config
# Registry options:
#  - GitHub Container Registry (recommended): ghcr.io
#  - Docker Hub: docker.io
REGISTRY ?= ghcr.io
# Set to your GitHub org/user (for GHCR) or Docker Hub username/namespace
ORG ?=
# Image name and tag
NAME ?= meta-repo-workshop-metatools
TAG ?= latest

# Derived
IMAGE_LOCAL := $(NAME):$(TAG)
IMAGE_REMOTE := $(if $(ORG),$(REGISTRY)/$(ORG)/$(NAME):$(TAG),)
REPO_ROOT := $(abspath .)

help:
	@echo "Targets:"
	@echo "  make build           Build local image ($(IMAGE_LOCAL))"
	@echo "  make run             Run container with repo mounted"
	@echo "  make tag             Tag local image for remote registry"
	@echo "  make push            Push tagged image to registry (requires ORG)"
	@echo "  make buildx-push     Multi-arch build and push (amd64,arm64)"
	@echo "  make login-ghcr      Docker login to GHCR (uses GHCR_TOKEN)"
	@echo "  make login-dockerhub Docker login to Docker Hub (uses DOCKERHUB_TOKEN)"
	@echo "Variables: REGISTRY (default ghcr.io), ORG, NAME, TAG"

check-org:
	@if [ -z "$(ORG)" ]; then \
	  echo "Set ORG=... (GitHub org/user for GHCR, or Docker Hub username)"; \
	  exit 1; \
	fi

build:
	@echo "🐳 Building $(IMAGE_LOCAL) from ./Dockerfile"
	docker build -t $(IMAGE_LOCAL) .

run: build
	@echo "🔧 Starting shell with repo mounted at /work"
	docker run --rm -it -v "$(REPO_ROOT)":/work -w /work $(IMAGE_LOCAL) bash

tag: check-org
	@if [ -z "$(IMAGE_REMOTE)" ]; then \
	  echo "IMAGE_REMOTE couldn't be computed. Set ORG"; exit 1; \
	fi
	@echo "🏷️  Tagging $(IMAGE_LOCAL) -> $(IMAGE_REMOTE)"
	docker tag $(IMAGE_LOCAL) $(IMAGE_REMOTE)

push: tag
	@echo "📤 Pushing $(IMAGE_REMOTE)"
	docker push $(IMAGE_REMOTE)

# Requires Docker Buildx and QEMU setup: `docker buildx create --use` (once)
buildx-push: check-org
	@echo "📦 Multi-arch build and push to $(REGISTRY) as $(IMAGE_REMOTE)"
	docker buildx build --platform linux/amd64,linux/arm64 -t $(IMAGE_REMOTE) --push .

login-ghcr: check-org
	@echo "🔐 Logging in to ghcr.io as $(ORG) (expects GHCR_TOKEN in env)"
	echo $$GHCR_TOKEN | docker login ghcr.io -u $(ORG) --password-stdin

login-dockerhub: check-org
	@echo "🔐 Logging in to Docker Hub as $(ORG) (expects DOCKERHUB_TOKEN in env)"
	echo $$DOCKERHUB_TOKEN | docker login -u $(ORG) --password-stdin

.PHONY: help check-org build run tag push buildx-push login-ghcr login-dockerhub

