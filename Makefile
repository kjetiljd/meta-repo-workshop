IMAGE_NAME=meta-repo-workshop

build:
	@echo "🐳 Building Docker image..."
	docker build -t $(IMAGE_NAME) .

serve: build
	@echo "🚀 Starting Jekyll server on http://localhost:4000"
	docker run --rm -p 4000:4000 -v "$(PWD)":/srv/jekyll $(IMAGE_NAME)

serve-daemon: build
	@echo "🚀 Starting Jekyll server in background..."
	docker run --rm -d -p 4000:4000 -v "$(PWD)":/srv/jekyll --name $(IMAGE_NAME)-server $(IMAGE_NAME)
	@echo "✅ Server running at http://localhost:4000"
	@echo "📋 Use 'make logs' to see output"
	@echo "🛑 Use 'make stop' to stop server"

rebuild: clean build

logs:
	@echo "📋 Showing server logs..."
	docker logs -f $(IMAGE_NAME)-server

stop:
	@echo "🛑 Stopping server..."
	docker stop $(IMAGE_NAME)-server || true

clean:
	@echo "🧹 Cleaning up Docker images..."
	docker rmi -f $(IMAGE_NAME) || true
	docker stop $(IMAGE_NAME)-server 2>/dev/null || true
	docker rm $(IMAGE_NAME)-server 2>/dev/null || true

install:
	@echo "💎 Installing Jekyll dependencies locally..."
	bundle install

serve-local: install
	@echo "🚀 Starting Jekyll locally..."
	bundle exec jekyll serve --livereload

help:
	@echo "📖 Available commands:"
	@echo "  make build        - Build Docker image"
	@echo "  make serve        - Start Jekyll with Docker"
	@echo "  make serve-daemon - Start Jekyll in background"
	@echo "  make serve-local  - Start Jekyll locally (no Docker)"
	@echo "  make logs         - Show server logs"
	@echo "  make stop         - Stop background server"
	@echo "  make clean        - Clean up Docker containers/images"
	@echo "  make install      - Install gems locally"
	@echo "  make help         - Show this help"

.PHONY: build serve serve-daemon logs stop rebuild clean install serve-local help
