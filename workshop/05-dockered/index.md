# Oppgave 5: Docker og Docker Compose

## 📋 Mål

I denne oppgaven skal du:
- Sette opp Docker Compose for multi-service meta-repo
- Integrere Docker kommandoer i Makefile
- Koordinere oppstart og nedtaking av services
- Få oversikt over alle service-URLs

## 📚 Bakgrunn

Docker og Docker Compose løser mange utfordringer med meta-repositories ved å gi konsistente miljøer, isolerte dependencies, og enkel service-koordinering.

## 🛠 Steg-for-steg

### Steg 1: Undersøk eksisterende Docker-oppsett

Gå inn i todo-meta mappen og se på den eksisterende docker-compose.yml:

```bash
cd todo-meta
cat docker-compose.yml
```

Du vil se noe slikt:

```yaml
version: '3.8'
services:
  meta-todo-frontend:
    build: ./todo-frontend
    ports:
      - "8081:80"
    environment:
      - VITE_API_TARGET=http://meta-todo-backend:8080
    depends_on:
      - meta-todo-backend

  meta-todo-backend:
    build: ./todo-backend
    ports:
      - "8082:8080"
    environment:
      - SORTER_SERVICE_URL=http://meta-todo-sorter:3001
    depends_on:
      - meta-todo-sorter
    volumes:
      - ./todo-backend/data:/app/data

  meta-todo-sorter:
    build: ./todo-sorter
    ports:
      - "8083:3001"
```

### Steg 2: Bygg og start services

Bygg og start alle services med Docker Compose:

```bash
# Bygg og start services i bakgrunnen
make up-build

# Alternativt, hvis du allerede har bygget:
make up
```

Dette vil:
- Bygge Docker images for hver service
- Starte alle services i riktig rekkefølge
- Vise service-URLs

### Steg 3: Utforsk kjørende services

Sjekk at alle services kjører:

```bash
# Se status på alle services
make status

# Vis service-URLs
make urls

# Følg logs fra alle services
make logs
```

### Steg 4: Test servicene

Åpne en nettleser og gå til:
- Frontend: http://localhost:8081
- Backend API: http://localhost:8082/api/todos
- Sorter service: http://localhost:8083/health

Prøv å legge til todos i frontenden og se at alt fungerer sammen.

### Steg 5: Legg til Docker-kommandoer i din Makefile

Hvis du ikke allerede har det, legg til disse Docker Compose kommandoene i din `Makefile`:

```makefile
up: ## Start alle services i bakgrunnen
	docker-compose up -d
	$(MAKE) urls

up-build: ## Bygg og start alle services
	docker-compose up --build -d
	$(MAKE) urls

down: ## Stopp alle services
	docker-compose down

restart: down up ## Restart alle services

rebuild: down up-build ## Restart alle services med rebuild

logs: ## Vis service logs
	docker-compose logs -f

status: ## Vis service status
	docker-compose ps

urls: ## Vis service URLs og porter
	@echo "Service URLs:"
	@docker-compose ps --format "table {{.Name}}\t{{.Ports}}" | grep -E "(meta-todo-|Name)" | \
	sed 's/meta-todo-frontend.*0.0.0.0:\([0-9]*\)->80.*/  Frontend: http:\/\/localhost:\1/' | \
	sed 's/meta-todo-backend.*0.0.0.0:\([0-9]*\)->8080.*/  Backend:  http:\/\/localhost:\1/' | \
	sed 's/meta-todo-sorter.*0.0.0.0:\([0-9]*\)->3001.*/  Sorter:   http:\/\/localhost:\1/' | \
	grep -v "Name\|Ports"
```

### Steg 6: Test alle kommandoene

Prøv de forskjellige Docker-kommandoene:

```bash
# Start services
make up

# Se status
make status

# Se URLs
make urls

# Følg logs (Ctrl+C for å stoppe)
make logs

# Restart services
make restart

# Stopp services
make down
```

### Steg 7: Utforsk individuell service-utvikling

Mens Docker Compose kjører, kan du fortsatt jobbe med individuelle services:

```bash
# Gå inn i en service og gjør endringer
cd todo-frontend
# Gjør endringer i koden...

# Bygg kun denne servicen på nytt
docker-compose up --build meta-todo-frontend -d

# Eller restart kun denne servicen
docker-compose restart meta-todo-frontend
```

### Steg 8: Commit Docker-integrasjonen

Commit endringene du har gjort i Makefile:

```bash
git add Makefile
git commit -m"Legg til Docker Compose kommandoer i Makefile"
```

## 🎯 Ekstra-oppgaver

1. **Health checks**: Legg til health check endpoints i alle services
2. **Environment variables**: Konfigurer forskjellige miljøer (dev, test, prod)
3. **Volume mapping**: Legg til persistent storage for databaser
4. **Networking**: Opprett custom Docker networks for service-isolering
5. **Multi-stage builds**: Optimaliser Dockerfile for mindre images

<details markdown="1">
  <summary>Løsningsforslag</summary>

<details markdown="1">
  <summary>1. Health checks</summary>

```yaml
# I docker-compose.yml
services:
  meta-todo-backend:
    # ... existing config
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8080/health"]
      interval: 30s
      timeout: 10s
      retries: 3
```

Makefile kommando:
```makefile
health: ## Sjekk health status på alle services
	@docker-compose ps --format "table {{.Name}}\t{{.Status}}" | grep -E "(Name|Status|healthy|unhealthy)"
```
</details>

<details markdown="1">
  <summary>2. Environment variables</summary>

```yaml
# docker-compose.override.yml for lokalt
version: '3.8'
services:
  meta-todo-backend:
    environment:
      - NODE_ENV=development
      - DEBUG=true
```

```bash
# Bruk forskjellige compose filer
docker-compose -f docker-compose.yml -f docker-compose.prod.yml up
```
</details>

<details markdown="1">
  <summary>3. Volume mapping</summary>

```yaml
services:
  meta-todo-backend:
    volumes:
      - ./todo-backend/data:/app/data
      - backend-logs:/app/logs

volumes:
  backend-logs:
```
</details>

<details markdown="1">
  <summary>4. Custom networking</summary>

```yaml
version: '3.8'
services:
  # ... services
networks:
  frontend:
  backend:
  
services:
  meta-todo-frontend:
    networks:
      - frontend
      - backend
  meta-todo-backend:
    networks:
      - backend
```
</details>

</details>

## 🔄 Feilsøking

### Vanlige problemer:

**Port conflicts**: 
```bash
# Se hvilke porter som er i bruk
lsof -i :8081
# Endre porter i docker-compose.yml hvis nødvendig
```

**Build feil**:
```bash
# Bygg på nytt uten cache
docker-compose build --no-cache

# Se detaljerte logs under bygging
docker-compose up --build
```

**Service kan ikke starte**:
```bash
# Se detaljerte feilmeldinger
docker-compose logs meta-todo-backend

# Debug ved å kjøre service manuelt
docker run -it meta-todo_meta-todo-backend:latest sh
```

## 💡 Tips

- Bruk `make up-build` første gang og etter større endringer
- `make logs` er nyttig for debugging
- `docker-compose ps` viser quick status
- Bruk `docker system prune` for å rydde opp disk space
- `depends_on` sikrer riktig oppstartsrekkefølge

**[← Tilbake til oversikt](../)** | **[→ Neste: IDE-integrasjon](../06-ide-integration/)**