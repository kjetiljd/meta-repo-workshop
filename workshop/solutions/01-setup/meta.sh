#!/bin/bash

# meta.sh - Komplett løsning for oppgave 1
# Meta-Repository Management Tool

set -e  # Avslutt ved feil

# Farger for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Konfigurasjon
CONFIG_FILE="config/repositories.yaml"
BASE_DIR=$(pwd)

# Hjelpefunksjon
function show_help() {
    echo -e "${BLUE}Meta-Repository Management Tool${NC}"
    echo ""
    echo "Bruk: ./meta.sh [KOMMANDO] [OPSJONER]"
    echo ""
    echo "Kommandoer:"
    echo "  list              - List alle repositories"
    echo "  clone [navn]      - Klon et repository (eller alle med --all)"
    echo "  status            - Vis status for alle repositories"
    echo "  exec [cmd]        - Kjør kommando i alle repos"
    echo "  help              - Vis denne hjelpemeldingen"
    echo ""
    echo "Filter-opsjoner for list:"
    echo "  --type [type]     - Filtrer på type (backend/frontend/mobile)"
    echo "  --team [team]     - Filtrer på team"
    echo "  --language [lang] - Filtrer på språk"
    echo ""
    echo "Eksempler:"
    echo "  ./meta.sh list"
    echo "  ./meta.sh list --type backend"
    echo "  ./meta.sh clone payment-service"
    echo "  ./meta.sh clone --all"
    echo "  ./meta.sh exec 'git status'"
}

# Parse YAML med Python (enkel løsning)
function get_repo_info() {
    local repo_name=$1
    python3 -c "
import yaml
with open('$CONFIG_FILE') as f:
    data = yaml.safe_load(f)
    for repo in data['repositories']:
        if repo['name'] == '$repo_name':
            print(f\"{repo['url']}|{repo['path']}|{repo.get('type', 'unknown')}|{repo.get('team', 'unknown')}\")
            break
    "
}

# Hent alle repos med valgfri filtrering
function get_all_repos() {
    local filter_type=$1
    local filter_value=$2
    
    python3 -c "
import yaml
with open('$CONFIG_FILE') as f:
    data = yaml.safe_load(f)
    for repo in data['repositories']:
        if '$filter_type' and '$filter_value':
            if repo.get('$filter_type', '') != '$filter_value':
                continue
        print(f\"{repo['name']}|{repo.get('type', 'unknown')}|{repo.get('language', 'unknown')}|{repo.get('team', 'unknown')}|{repo.get('path', '')}\")
    "
}

# List repositories
function list_repos() {
    local filter_type=""
    local filter_value=""
    
    # Parse filter arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            --type)
                filter_type="type"
                filter_value="$2"
                shift 2
                ;;
            --team)
                filter_type="team"
                filter_value="$2"
                shift 2
                ;;
            --language)
                filter_type="language"
                filter_value="$2"
                shift 2
                ;;
            *)
                shift
                ;;
        esac
    done
    
    echo -e "${GREEN}📦 Repositories i meta-repo:${NC}"
    
    if [ "$filter_type" ]; then
        echo -e "${YELLOW}Filter: $filter_type=$filter_value${NC}"
    fi
    
    echo ""
    printf "%-20s %-10s %-12s %-10s\n" "NAVN" "TYPE" "SPRÅK" "TEAM"
    echo "------------------------------------------------------------"
    
    get_all_repos "$filter_type" "$filter_value" | while IFS='|' read -r name type language team path; do
        printf "%-20s %-10s %-12s %-10s\n" "$name" "$type" "$language" "$team"
    done
}

# Klon repository
function clone_repo() {
    local repo_name=$1
    
    if [ "$repo_name" == "--all" ]; then
        echo -e "${YELLOW}Kloner alle repositories...${NC}"
        echo ""
        
        get_all_repos "" "" | while IFS='|' read -r name type language team path; do
            clone_single_repo "$name"
        done
        
        echo ""
        echo -e "${GREEN}✅ Ferdig med kloning av alle repositories!${NC}"
    else
        clone_single_repo "$repo_name"
    fi
}

# Klon enkelt repository
function clone_single_repo() {
    local repo_name=$1
    local repo_info=$(get_repo_info "$repo_name")
    
    if [ -z "$repo_info" ]; then
        echo -e "${RED}❌ Repository '$repo_name' ikke funnet i konfigurasjon${NC}"
        return 1
    fi
    
    IFS='|' read -r url path type team <<< "$repo_info"
    
    # Opprett parent directory hvis nødvendig
    local parent_dir=$(dirname "$path")
    mkdir -p "$parent_dir"
    
    if [ -d "$path" ]; then
        echo -e "${BLUE}ℹ️  $repo_name allerede klonet i $path${NC}"
    else
        echo -e "${YELLOW}📥 Kloner $repo_name...${NC}"
        git clone "$url" "$path"
        echo -e "${GREEN}✅ $repo_name klonet til $path${NC}"
    fi
}

# Status for alle repos
function show_status() {
    echo -e "${GREEN}📊 Status for repositories:${NC}"
    echo ""
    
    get_all_repos "" "" | while IFS='|' read -r name type language team path; do
        if [ -d "$path" ]; then
            echo -e "${BLUE}$name:${NC}"
            cd "$path"
            
            # Hent branch
            branch=$(git branch --show-current 2>/dev/null || echo "unknown")
            echo "  Branch: $branch"
            
            # Sjekk for endringer
            if [ -n "$(git status --porcelain 2>/dev/null)" ]; then
                echo -e "  Status: ${YELLOW}Har ucommittede endringer${NC}"
            else
                echo -e "  Status: ${GREEN}Clean${NC}"
            fi
            
            # Sjekk for unpushed commits
            ahead=$(git rev-list --count @{u}..HEAD 2>/dev/null || echo "0")
            if [ "$ahead" -gt 0 ]; then
                echo -e "  Unpushed: ${YELLOW}$ahead commit(s)${NC}"
            fi
            
            cd "$BASE_DIR"
        else
            echo -e "${BLUE}$name:${NC} ${RED}Ikke klonet${NC}"
        fi
        echo ""
    done
}

# Kjør kommando i alle repos
function exec_in_repos() {
    local command=$1
    
    if [ -z "$command" ]; then
        echo -e "${RED}❌ Ingen kommando spesifisert${NC}"
        echo "Bruk: ./meta.sh exec 'kommando'"
        return 1
    fi
    
    echo -e "${GREEN}🚀 Kjører '$command' i alle repositories:${NC}"
    echo ""
    
    get_all_repos "" "" | while IFS='|' read -r name type language team path; do
        if [ -d "$path" ]; then
            echo -e "${BLUE}$name:${NC}"
            cd "$path"
            eval "$command"
            cd "$BASE_DIR"
            echo ""
        else
            echo -e "${BLUE}$name:${NC} ${YELLOW}Skippet (ikke klonet)${NC}"
            echo ""
        fi
    done
}

# Sjekk for dependencies
function check_dependencies() {
    local missing=0
    
    # Sjekk for Python 3
    if ! command -v python3 &> /dev/null; then
        echo -e "${RED}❌ Python 3 er ikke installert${NC}"
        missing=1
    fi
    
    # Sjekk for PyYAML
    if ! python3 -c "import yaml" 2>/dev/null; then
        echo -e "${RED}❌ PyYAML er ikke installert${NC}"
        echo "   Installer med: pip3 install pyyaml"
        missing=1
    fi
    
    # Sjekk for Git
    if ! command -v git &> /dev/null; then
        echo -e "${RED}❌ Git er ikke installert${NC}"
        missing=1
    fi
    
    if [ $missing -eq 1 ]; then
        echo ""
        echo "Installer manglende dependencies og prøv igjen."
        exit 1
    fi
}

# Sjekk dependencies ved oppstart
check_dependencies

# Hovedlogikk
case "$1" in
    list)
        shift
        list_repos "$@"
        ;;
    clone)
        clone_repo "$2"
        ;;
    status)
        show_status
        ;;
    exec)
        exec_in_repos "$2"
        ;;
    help|--help|-h)
        show_help
        ;;
    "")
        echo -e "${YELLOW}Ingen kommando spesifisert${NC}"
        echo ""
        show_help
        ;;
    *)
        echo -e "${RED}Ukjent kommando: $1${NC}"
        echo ""
        show_help
        exit 1
        ;;
esac
