# Oppgave 1: Oppsett og grunnleggende struktur

## 📋 Mål

I denne oppgaven skal du:
- Sette opp strukturen for et meta-repository
- Definere hvilke repositories som skal orkestreres
- Lage din første meta-kommando

## 📚 Bakgrunn

Et meta-repository fungerer som et kontrollsenter for flere Git-repositories. Det inneholder ingen applikasjonskode, men scripts og konfigurasjon for å administrere andre repos.

## 🛠 Steg-for-steg

### Steg 1: Opprett meta-repository struktur

Opprett følgende mappestruktur i en ny mappe `my-meta-repo`:

```bash
mkdir -p my-meta-repo/{scripts,config,templates,docs}
cd my-meta-repo
```

### Steg 2: Definer repository manifest

Opprett filen `config/repositories.yaml`:

```yaml
# config/repositories.yaml
meta:
  version: "1.0.0"
  organization: "mitt-firma"
  
repositories:
  - name: payment-service
    url: https://github.com/example/payment-service.git
    type: backend
    language: java
    team: payments
    path: ../services/payment-service
    
  - name: user-service
    url: https://github.com/example/user-service.git
    type: backend
    language: python
    team: platform
    path: ../services/user-service
    
  - name: web-frontend
    url: https://github.com/example/web-frontend.git
    type: frontend
    language: typescript
    team: web
    path: ../frontends/web-frontend
    
  - name: mobile-app
    url: https://github.com/example/mobile-app.git
    type: mobile
    language: kotlin
    team: mobile
    path: ../frontends/mobile-app
```

### Steg 3: Lag ditt første script

Opprett `scripts/meta.sh`:

```bash
#!/bin/bash

# meta.sh - Hovedscript for meta-repository operasjoner

set -e  # Avslutt ved feil

# Farger for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Konfigurasjon
CONFIG_FILE="config/repositories.yaml"
BASE_DIR=$(pwd)

# Hjelpefunksjon
function show_help() {
    echo "Meta-Repository Management Tool"
    echo ""
    echo "Bruk: ./meta.sh [KOMMANDO] [OPSJONER]"
    echo ""
    echo "Kommandoer:"
    echo "  list              - List alle repositories"
    echo "  clone [navn]      - Klon et repository (eller alle med --all)"
    echo "  status            - Vis status for alle repositories"
    echo "  help              - Vis denne hjelpemeldingen"
    echo ""
    echo "Eksempler:"
    echo "  ./meta.sh list"
    echo "  ./meta.sh clone payment-service"
    echo "  ./meta.sh clone --all"
}

# List repositories
function list_repos() {
    echo -e "${GREEN}📦 Repositories i meta-repo:${NC}"
    echo ""
    
    # Enkel parsing av YAML (for workshop - bruk yq eller lignende i produksjon)
    grep "name:" $CONFIG_FILE | sed 's/.*name: /  - /'
}

# Klon repository
function clone_repo() {
    local repo_name=$1
    
    if [ "$repo_name" == "--all" ]; then
        echo -e "${YELLOW}Kloner alle repositories...${NC}"
        # Implementer clone --all
        echo "TODO: Implementer clone --all"
    else
        echo -e "${YELLOW}Kloner $repo_name...${NC}"
        # Implementer enkel kloning
        echo "TODO: Implementer kloning av $repo_name"
    fi
}

# Status for alle repos
function show_status() {
    echo -e "${GREEN}📊 Status for repositories:${NC}"
    echo ""
    echo "TODO: Implementer status-sjekk"
}

# Hovedlogikk
case "$1" in
    list)
        list_repos
        ;;
    clone)
        clone_repo "$2"
        ;;
    status)
        show_status
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        echo -e "${RED}Ukjent kommando: $1${NC}"
        echo ""
        show_help
        exit 1
        ;;
esac
```

Gjør scriptet kjørbart:

```bash
chmod +x scripts/meta.sh
```

### Steg 4: Test ditt oppsett

```bash
# Test list-kommandoen
./scripts/meta.sh list

# Test help
./scripts/meta.sh help
```

## 🎯 Oppgaver

### Oppgave 1.1: Utvid repository manifest

Legg til minst 2 flere repositories i `config/repositories.yaml`. Tenk på:
- Hvilke typer tjenester trenger du?
- Hvilke metadata er nyttige?

### Oppgave 1.2: Implementer clone-funksjonen

Fullfør implementasjonen av `clone_repo` funksjonen. Den skal:
1. Lese repository-info fra YAML
2. Sjekke om mappen allerede eksisterer
3. Kjøre `git clone` til riktig path

**Hint:** Du kan bruke Python eller annet språk for å parse YAML:

```python
# parse_repo.py
import yaml
import sys

with open('config/repositories.yaml') as f:
    data = yaml.safe_load(f)
    repo_name = sys.argv[1] if len(sys.argv) > 1 else None
    
    for repo in data['repositories']:
        if repo['name'] == repo_name:
            print(f"{repo['url']} {repo['path']}")
            break
```

### Oppgave 1.3: Legg til filtrering

Utvid `list` kommandoen til å støtte filtrering:
- `./meta.sh list --type backend`
- `./meta.sh list --team platform`

## ✅ Suksesskriterier

Du er ferdig med oppgave 1 når du kan:
- [ ] Kjøre `./scripts/meta.sh list` og se dine repositories
- [ ] Kjøre `./scripts/meta.sh clone <navn>` og klone et repository
- [ ] Ha minst 5 repositories definert i manifest

## 💡 Tips

- Start enkelt, bygg gradvis
- Bruk `set -x` i bash for debugging
- Test hver endring før du går videre
- Se `solutions/01-setup/` for løsningsforslag hvis du står fast

## 📖 Videre lesning

- [YAML syntax guide](https://yaml.org/start.html)
- [Bash scripting best practices](https://google.github.io/styleguide/shellguide.html)

---

**[← Tilbake til oversikt](../)** | **[→ Neste oppgave: Basic Commands](../02-basic-commands/)**
