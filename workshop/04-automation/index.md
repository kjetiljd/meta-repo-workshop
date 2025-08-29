# Oppgave 4: Automatisering med make og scripts

## 📋 Mål

I denne oppgaven skal du:
- Lage en `Makefile` for vanlige meta-repo operasjoner
- Bruke `.PHONY` og help-target
- Automatisere git-operasjoner på tvers av repos
- Lage nyttige shortcuts for teamet

## 🛠 Steg-for-steg

### Steg 1: Lag din første Makefile

Gå til rot-mappen til ditt meta-repo og opprett en `Makefile`:

```bash
# Gå til meta-repo mappen (todo-meta eller hva den heter)
cd todo-meta

# Lag en Makefile
touch Makefile
```

Åpne `Makefile` i din editor og legg til:

```makefile
help:
	@echo "Tilgjengelige kommandoer:"
	@echo "  help    - Vis denne hjelpeteksten"
	@echo "  status  - Git status på alle repos"
	@echo "  pull    - Git pull på alle repos"

status:
	@echo "🔍 Sjekker git status..."
	meta git status

pull:
	@echo "⬇️  Oppdaterer alle repos..."
	meta exec "git pull"
```

Test det:

```bash
make
make status
```

### Steg 2: Legg til .PHONY

Legg til `.PHONY` øverst i filen:

```makefile
.PHONY: help status pull

help:
	@echo "Tilgjengelige kommandoer:"
	@echo "  help    - Vis denne hjelpeteksten"
	@echo "  status  - Git status på alle repos"
	@echo "  pull    - Git pull på alle repos"

status:
	@echo "🔍 Sjekker git status..."
	meta git status

pull:
	@echo "⬇️  Oppdaterer alle repos..."
	meta exec "git pull"
```

### Steg 3: Smart .PHONY automatisering

Erstatt den manuelle `.PHONY`-listen med denne smarte løsningen:

```makefile
.PHONY: $(shell sed -n -e '/^$$/ { n ; /^[^ .\#][^ ]*:/ { s/:.*$$// ; p ; } ; }' $(MAKEFILE_LIST))
```

### Steg 4: Automatisk help med dokumentasjon

Oppgrader til et help-system som bruker `##` kommentarer:

```makefile
help: ## Vis denne hjelpeteksten
	@grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/ : /' | \
	while IFS=' : ' read -r cmd desc; do \
		printf "\033[36m%-20s\033[0m %s\n" "$$cmd" "$$desc"; \
	done

status: ## Git status på alle repos
	@echo "🔍 Sjekker git status..."
	meta git status

pull: ## Git pull på alle repos med rebase
	@echo "⬇️  Oppdaterer alle repos..."
	meta exec "git pull --rebase --autostash" --parallel
```
Test det nye help-systemet:

```bash
make help
```

Legg merket til at dersom du tar bort en `#` på en linje, så forsvinner den fra helpen:

```makefile
help: # Vis denne hjelpeteksten
```

Prøv `make help` igjen for å se at "help" ikke lenger vises.

### Steg 5: Legg til meta-repo kommandoer

Utvid `Makefile` med de viktigste meta-repo operasjonene:

```makefile

root_dir := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
meta_project := $(notdir $(patsubst %/,%,$(root_dir)))

build: ## Build all sub-projects with make build
	@meta exec "make build" --exclude "$(meta_project)"

test: ## Test all sub-projects with make test
	@meta exec "make test" --exclude "$(meta_project)"

list-local-commits: ## Shows local, unpushed, commits
	@meta exec "git log --oneline origin/HEAD..HEAD | cat"
```

### Steg 6: Test meta-repo kommandoene

Prøv ut de forskjellige kommandoene:

```bash
make help

make meta-update

make pull

make list-local-commits

make build

make test
```

### Steg 7: Commit endringene

Commit den nye Makefile til meta-repoet:

```bash
git add Makefile
git commit -m"Legg til Makefile for meta-repo automatisering"
```


## 🎯 Ekstra-oppgaver

Legg til disse kommandoene i din `Makefile`:

1. **Kodestatistikk**: Vis cloc-statistikk for alle repos
2. **Branch info**: Vis hvilken branch hvert repo er på
3. **Clean**: Rydd opp git working directories
4**Health check**: Sjekk at alle services kan starte

<details markdown="1">
  <summary>Løsningsforslag</summary>

```makefile
stats: ## Vis kodestatistikk med cloc
	@echo "📊 Genererer kodestatistikk..."
	meta exec "cloc . --vcs=git --quiet" --exclude "$(meta_project)"

branch-info: ## Vis hvilken branch hvert repo er på
	@echo "🌳 Viser branch-informasjon..."
	meta exec "echo \"\$$(basename \$$(pwd)): \$$(git branch --show-current)\"" --exclude "$(meta_project)"

clean: ## Rydd opp git working directories
	@echo "🧹 Rydder opp..."
	meta exec "git clean -fd" --exclude "$(meta_project)"

health: ## Kjør health check på alle services
	@echo "💚 Kjører health check..."
	meta exec "if [ -f docker-compose.yml ]; then docker-compose config -q && echo 'Docker compose OK'; fi" --exclude "$(meta_project)"
```

</details>

## 💡 Tips

- Bruk `@echo` for beskrivende meldinger
- `--parallel` gjør kommandoer raskere
- Bruk `--exclude "$(meta_project)"` for å unngå meta-repoet selv
- Test kommandoer først med `meta exec` før du legger dem i Makefile
- `$(MAKE)` er bedre enn `make` i Makefiles

**[← Tilbake til oversikt](../)** | **[→ Neste oppgave: Docker](../05-dockered/)**