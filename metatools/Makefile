.DEFAULT_GOAL := help

# Config
# Registry options:
#  - GitHub Container Registry (recommended): ghcr.io
#  - Docker Hub: docker.io
REGISTRY ?= ghcr.io
# Set to your GitHub org/user (for GHCR) or Docker Hub username/namespace
ORG ?= kjetiljd
# Image name and tag
NAME ?= meta-repo-workshop-tools
TAG ?= latest

# Derived
IMAGE_LOCAL := $(NAME):$(TAG)
IMAGE_REMOTE := $(if $(ORG),$(REGISTRY)/$(ORG)/$(NAME):$(TAG),)
REPO_ROOT := $(abspath ..)

help:
	@echo "Targets:"
	@echo "  make build           Build local image ($(IMAGE_LOCAL))"
	@echo "  make run             Run GHCR image with repo mounted (uses ghcr-run.*)"
	@echo "  make build-run       Build local image then run it with repo mounted"
	@echo "  make tag             Tag local image for remote registry"
	@echo "  make push            Push tagged image to registry (requires ORG)"
	@echo "  make build-push      Build (single-arch) + tag + push"
	@echo "  make buildx-setup    Create and use a Buildx builder (docker-container)"
	@echo "  make buildx-push     Multi-arch build and push (amd64,arm64)"
	@echo "  make login-ghcr      Docker login to GHCR (uses GHCR_TOKEN)"
	@echo "  make login-dockerhub Docker login to Docker Hub (uses DOCKERHUB_TOKEN)"
	@echo "  make doctor          Environment check and tips"
	@echo "Variables: REGISTRY (default ghcr.io), ORG, NAME, TAG"

check-org:
	@if [ -z "$(ORG)" ]; then \
	  echo "Set ORG=... (GitHub org/user for GHCR, or Docker Hub username)"; \
	  exit 1; \
	fi

build:
	@echo "🐳 Building $(IMAGE_LOCAL) from ./Dockerfile"
	docker build -t $(IMAGE_LOCAL) .

run:
	@echo "🔧 Starting GHCR tools image with repo mounted at /work"
	@if [ "$$OS" = "Windows_NT" ]; then \
	  powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-Location ..; ./metatools/ghcr-run.ps1"; \
	else \
	  (cd .. && bash ./metatools/ghcr-run.sh); \
	fi

build-run: build
	@echo "🔧 Starting local tools image with repo mounted at /work"
	docker run --rm -it -v "$(REPO_ROOT)":/work -w /work $(IMAGE_LOCAL) bash

build-push: build tag push

tag: check-org
	@if [ -z "$(IMAGE_REMOTE)" ]; then \
	  echo "IMAGE_REMOTE couldn't be computed. Set ORG"; exit 1; \
	fi
	@echo "🏷️  Tagging $(IMAGE_LOCAL) -> $(IMAGE_REMOTE)"
	docker tag $(IMAGE_LOCAL) $(IMAGE_REMOTE)

push: tag
	@echo "📤 Pushing $(IMAGE_REMOTE)"
	docker push $(IMAGE_REMOTE)

# Buildx helpers
buildx-setup:
	@echo "🧰 Ensuring Docker Buildx builder is ready (driver=docker-container)"
	@if ! docker buildx version >/dev/null 2>&1; then \
	  echo "❌ Docker Buildx not available in your Docker CLI."; \
	  echo "👉 Use 'make build-push' for single-arch, or install/enable Buildx:"; \
	  echo "   - Docker Desktop (Win/Mac) includes Buildx by default"; \
	  echo "   - Linux: install docker buildx plugin and enable experimental CLI"; \
	  echo "   - Docs: https://docs.docker.com/build/buildx/"; \
	  exit 1; \
	fi
	@export DOCKER_CLI_EXPERIMENTAL=enabled; \
	if ! docker buildx ls | grep -q "mrw-builder"; then \
	  docker buildx create --name mrw-builder --driver docker-container --use; \
	else \
	  docker buildx use mrw-builder; \
	fi; \
	docker buildx inspect --bootstrap >/dev/null

# Requires Docker Buildx and QEMU; use 'make buildx-setup' first.
buildx-push: check-org buildx-setup
	@echo "📦 Multi-arch build and push to $(REGISTRY) as $(IMAGE_REMOTE)"
	@export DOCKER_CLI_EXPERIMENTAL=enabled; \
	docker buildx build --platform linux/amd64,linux/arm64 -t $(IMAGE_REMOTE) --push .

login-ghcr: check-org
	@echo "🔐 Logging in to ghcr.io as $(ORG) (expects GHCR_TOKEN or GITHUB_TOKEN in env)"
	@if [ -z "$$GHCR_TOKEN" ] && [ -n "$$GITHUB_TOKEN" ]; then export GHCR_TOKEN="$$GITHUB_TOKEN"; fi; \
	if [ -z "$$GHCR_TOKEN" ]; then \
	  echo "❌ Missing GHCR_TOKEN (or GITHUB_TOKEN)."; \
	  echo "   Create a GitHub PAT with 'write:packages' (classic) or 'Packages: Read and write' (fine-grained)."; \
	  echo "   If pushing to an org with SSO: authorize the PAT for that org."; \
	  exit 1; \
	fi; \
	echo $$GHCR_TOKEN | docker login ghcr.io -u $(ORG) --password-stdin

login-dockerhub: check-org
	@echo "🔐 Logging in to Docker Hub as $(ORG) (expects DOCKERHUB_TOKEN in env)"
	echo $$DOCKERHUB_TOKEN | docker login -u $(ORG) --password-stdin

# Simple environment doctor
doctor:
	@echo "🔎 Docker version:" && docker --version || true
	@echo "🔎 Buildx version:" && docker buildx version || echo "(buildx not found)"
	@echo "🔎 Active builder:" && docker buildx ls 2>/dev/null | sed -n '1,20p' || echo "(no builders)"

.PHONY: help check-org build run tag push build-push buildx-setup buildx-push login-ghcr login-dockerhub doctor build-run
