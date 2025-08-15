#!/bin/bash

# test-workshop.sh - Test workshop setup lokalt

set -e

# Farger
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}🚀 Meta-Repository Workshop - Lokal Test${NC}"
echo ""

# Sjekk Docker
if ! command -v docker &> /dev/null; then
    echo -e "${RED}❌ Docker er ikke installert${NC}"
    echo "Installer Docker Desktop fra https://docker.com"
    exit 1
fi

# Sjekk Docker Compose
if ! command -v docker-compose &> /dev/null && ! docker compose version &> /dev/null; then
    echo -e "${RED}❌ Docker Compose er ikke installert${NC}"
    exit 1
fi

# Funksjon for å kjøre docker-compose
run_compose() {
    if command -v docker-compose &> /dev/null; then
        docker-compose "$@"
    else
        docker compose "$@"
    fi
}

# Parse argumenter
ACTION=${1:-start}

case $ACTION in
    start)
        echo -e "${YELLOW}📦 Bygger Docker image...${NC}"
        run_compose build
        
        echo -e "${YELLOW}🔧 Starter workshop-server...${NC}"
        run_compose up -d workshop
        
        echo ""
        echo -e "${GREEN}✅ Workshop kjører!${NC}"
        echo ""
        echo -e "${BLUE}📚 Tilgjengelige URLer:${NC}"
        echo "  • Hovedside:    http://localhost:8080"
        echo "  • Presentasjon: http://localhost:8080/slides/"
        echo "  • Workshop:     http://localhost:8080/workshop/"
        echo "  • Ressurser:    http://localhost:8080/resources/"
        echo ""
        echo -e "${YELLOW}💡 Tips:${NC}"
        echo "  • Åpne http://localhost:8080 i nettleseren"
        echo "  • Trykk 'S' i presentasjonen for speaker notes"
        echo "  • Trykk 'F' for fullskjerm"
        echo "  • Bruk './test-workshop.sh logs' for å se logger"
        echo "  • Bruk './test-workshop.sh stop' for å stoppe"
        ;;
        
    stop)
        echo -e "${YELLOW}🛑 Stopper workshop-server...${NC}"
        run_compose down
        echo -e "${GREEN}✅ Stoppet${NC}"
        ;;
        
    restart)
        echo -e "${YELLOW}🔄 Restarter workshop-server...${NC}"
        run_compose restart workshop
        echo -e "${GREEN}✅ Restartet${NC}"
        ;;
        
    logs)
        echo -e "${BLUE}📋 Logger:${NC}"
        run_compose logs -f workshop
        ;;
        
    shell)
        echo -e "${BLUE}🐚 Åpner shell i dev-container...${NC}"
        run_compose run --rm dev bash
        ;;
        
    test)
        echo -e "${YELLOW}🧪 Kjører tester...${NC}"
        
        # Test at serveren svarer
        echo -n "  Testing hovedside... "
        if curl -s -o /dev/null -w "%{http_code}" http://localhost:8080 | grep -q "200"; then
            echo -e "${GREEN}✓${NC}"
        else
            echo -e "${RED}✗${NC}"
        fi
        
        echo -n "  Testing slides... "
        if curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/slides/ | grep -q "200"; then
            echo -e "${GREEN}✓${NC}"
        else
            echo -e "${RED}✗${NC}"
        fi
        
        echo -n "  Testing workshop... "
        if curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/workshop/ | grep -q "200"; then
            echo -e "${GREEN}✓${NC}"
        else
            echo -e "${RED}✗${NC}"
        fi
        
        echo ""
        echo -e "${GREEN}✅ Tester fullført${NC}"
        ;;
        
    clean)
        echo -e "${YELLOW}🧹 Rydder opp...${NC}"
        run_compose down -v
        docker rmi meta-repo-workshop_workshop 2>/dev/null || true
        echo -e "${GREEN}✅ Ryddet${NC}"
        ;;
        
    *)
        echo "Bruk: $0 {start|stop|restart|logs|shell|test|clean}"
        echo ""
        echo "Kommandoer:"
        echo "  start   - Start workshop-server"
        echo "  stop    - Stopp workshop-server"
        echo "  restart - Restart workshop-server"
        echo "  logs    - Vis logger"
        echo "  shell   - Åpne shell i dev-container"
        echo "  test    - Kjør enkle tester"
        echo "  clean   - Rydd opp Docker images/volumes"
        exit 1
        ;;
esac
