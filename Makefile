.PHONY: $(shell sed -n -e '/^$$/ { n ; /^[^ .\#][^ ]*:/ { s/:.*$$// ; p ; } ; }' $(MAKEFILE_LIST))

root_dir := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
meta_project := $(notdir $(patsubst %/,%,$(root_dir)))

IMAGE_NAME=meta-repo-workshop

VOLUME_MOUNTS = -v "$(PWD)/_config.yml":/srv/jekyll/_config.yml \
	-v "$(PWD)/workshop":/srv/jekyll/workshop \
	-v "$(PWD)/slides":/srv/jekyll/slides \
	-v "$(PWD)/_includes":/srv/jekyll/_includes \
	-v "$(PWD)/_sass":/srv/jekyll/_sass \
	-v "$(PWD)/index.md":/srv/jekyll/index.md \
	-v "$(PWD)/Gemfile":/srv/jekyll/Gemfile

help: # Extracts make targets with doble-hash comments and prints them
	@grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/ : /' | while IFS=' : ' read -r cmd desc; do \
		printf "\033[36m%-20s\033[0m %s\n" "$$cmd" "$$desc"; \
	done

build: ## Build Docker image
	@echo "🐳 Building Docker image..."
	docker build -t $(IMAGE_NAME) .

serve: build ## Start Jekyll server with Docker
	@echo "🚀 Starting Jekyll server on http://localhost:4000"
	docker run --rm -p 4000:4000 $(VOLUME_MOUNTS) $(IMAGE_NAME)

serve-daemon: build ## Start Jekyll server in background with Docker
	@echo "🚀 Starting Jekyll server in background..."
	docker run --rm -d -p 4000:4000 $(VOLUME_MOUNTS) --name $(IMAGE_NAME)-server $(IMAGE_NAME)
	@echo "✅ Server running at http://localhost:4000"
	@echo "📋 Use 'make logs' to see output"
	@echo "🛑 Use 'make stop' to stop server"

rebuild: clean build ## Rebuild Docker image from scratch

logs: ## Show Jekyll server logs
	@echo "📋 Showing server logs..."
	docker logs -f $(IMAGE_NAME)-server

stop: ## Stop Jekyll server
	@echo "🛑 Stopping server..."
	docker stop $(IMAGE_NAME)-server || true

clean: ## Remove Docker image and stop any running container
	@echo "🧹 Cleaning up Docker images..."
	docker rmi -f $(IMAGE_NAME) || true
	docker stop $(IMAGE_NAME)-server 2>/dev/null || true
	docker rm $(IMAGE_NAME)-server 2>/dev/null || true

install: ## Install Jekyll dependencies locally
	@echo "💎 Installing Jekyll dependencies locally..."
	bundle install

serve-local: install ## Start Jekyll server locally
	@echo "🚀 Starting Jekyll locally..."
	bundle exec jekyll serve --livereload
