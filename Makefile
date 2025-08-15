# Makefile for Meta-Repository Workshop

.PHONY: help test serve docker-build docker-run docker-stop clean install-deps

# Farger
GREEN := \033[0;32m
YELLOW := \033[1;33m
BLUE := \033[0;34m
NC := \033[0m

help: ## Vis denne hjelpemeldingen
	@echo "$(BLUE)Meta-Repository Workshop - Kommandoer$(NC)"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  $(GREEN)%-15s$(NC) %s\n", $$1, $$2}'
	@echo ""
	@echo "$(YELLOW)Eksempler:$(NC)"
	@echo "  make serve       # Start lokal testserver"
	@echo "  make docker-run  # Start med Docker"

serve: ## Start lokal Python webserver (uten Docker)
	@echo "$(YELLOW)🚀 Starter lokal testserver...$(NC)"
	@python3 test-server.py

serve-quiet: ## Start server uten å åpne browser
	@echo "$(YELLOW)🚀 Starter lokal testserver...$(NC)"
	@python3 test-server.py --no-browser

test: ## Test at alle filer eksisterer
	@echo "$(YELLOW)🧪 Kjører tester...$(NC)"
	@echo -n "  Sjekker index.html... "
	@test -f index.html && echo "$(GREEN)✓$(NC)" || echo "$(RED)✗$(NC)"
	@echo -n "  Sjekker slides/index.html... "
	@test -f slides/index.html && echo "$(GREEN)✓$(NC)" || echo "$(RED)✗$(NC)"
	@echo -n "  Sjekker slides/slides.md... "
	@test -f slides/slides.md && echo "$(GREEN)✓$(NC)" || echo "$(RED)✗$(NC)"
	@echo -n "  Sjekker workshop/README.md... "
	@test -f workshop/README.md && echo "$(GREEN)✓$(NC)" || echo "$(RED)✗$(NC)"
	@echo -n "  Sjekker Python... "
	@which python3 > /dev/null && echo "$(GREEN)✓$(NC)" || echo "$(RED)✗$(NC)"
	@echo ""
	@echo "$(GREEN)✅ Tester fullført$(NC)"

docker-build: ## Bygg Docker image
	@echo "$(YELLOW)🔨 Bygger Docker image...$(NC)"
	@docker build -t meta-repo-workshop .
	@echo "$(GREEN)✅ Image bygget$(NC)"

docker-run: docker-build ## Start workshop med Docker
	@echo "$(YELLOW)🚀 Starter Docker container...$(NC)"
	@docker run -d --name meta-repo-workshop -p 8080:80 meta-repo-workshop
	@echo "$(GREEN)✅ Workshop kjører på http://localhost:8080$(NC)"
	@echo "$(YELLOW)Tips: Bruk 'make docker-stop' for å stoppe$(NC)"

docker-stop: ## Stopp Docker container
	@echo "$(YELLOW)🛑 Stopper Docker container...$(NC)"
	@docker stop meta-repo-workshop 2>/dev/null || true
	@docker rm meta-repo-workshop 2>/dev/null || true
	@echo "$(GREEN)✅ Stoppet$(NC)"

docker-logs: ## Vis Docker logs
	@docker logs -f meta-repo-workshop

clean: ## Rydd opp (fjern genererte filer)
	@echo "$(YELLOW)🧹 Rydder opp...$(NC)"
	@rm -rf node_modules
	@rm -rf .pytest_cache
	@rm -rf __pycache__
	@find . -name "*.pyc" -delete
	@find . -name ".DS_Store" -delete
	@docker stop meta-repo-workshop 2>/dev/null || true
	@docker rm meta-repo-workshop 2>/dev/null || true
	@echo "$(GREEN)✅ Ryddet$(NC)"

install-deps: ## Installer dependencies
	@echo "$(YELLOW)📦 Installerer dependencies...$(NC)"
	@echo "  Sjekker Python..."
	@which python3 || (echo "$(RED)Python3 mangler!$(NC)" && exit 1)
	@echo "  Installerer PyYAML..."
	@pip3 install --user pyyaml || true
	@echo "$(GREEN)✅ Dependencies installert$(NC)"

validate-yaml: ## Valider YAML-filer
	@echo "$(YELLOW)🔍 Validerer YAML...$(NC)"
	@python3 -c "import yaml; yaml.safe_load(open('workshop/solutions/01-setup/config/repositories.yaml', 'r'))" 2>/dev/null || echo "  repositories.yaml: $(GREEN)OK$(NC)"
	@echo "$(GREEN)✅ YAML validering fullført$(NC)"

open: serve ## Alias for 'serve'

preview: ## Forhåndsvis presentasjonen
	@echo "$(YELLOW)📊 Åpner presentasjon...$(NC)"
	@python3 -m webbrowser "http://localhost:8000/slides/"
	@$(MAKE) serve-quiet

git-init: ## Initialiser git repository
	@echo "$(YELLOW)📝 Initialiserer Git...$(NC)"
	@git init
	@git add .
	@git commit -m "Initial workshop setup"
	@echo "$(GREEN)✅ Git repository klar$(NC)"
	@echo "$(YELLOW)Neste steg:$(NC)"
	@echo "  git remote add origin https://github.com/[brukernavn]/meta-repo-workshop.git"
	@echo "  git push -u origin main"

all: test serve ## Kjør tester og start server
