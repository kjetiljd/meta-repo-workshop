# Oppgave 6: Docker og Docker Compose

> **Denne delen krever Docker og Docker Compose installert på maskinen din.** Hvis du ikke har Docker installert, kan du enten:
> - Installere Docker, f eks fra [docker.com/get-started](https://www.docker.com/get-started/) 
> - Hoppe over denne oppgaven og gå direkte til [Oppgave 7: IDE-integrasjon](../07-ide-integration/) men les gjerne igjennom stegene for å forstå hvordan dette fungerer.

## 📋 Mål

I denne oppgaven skal du:
- Sette opp Docker Compose for multi-service meta-repo
- Integrere Docker kommandoer i Makefile
- Koordinere oppstart og nedtaking av services
- Få oversikt over alle service-URLs

## 📚 Bakgrunn

Å plassere verktøy for å kjøre opp en løsning sammensatt av flere tjenester passer veldig fint i et meta-repo.

docker-compose er et verktøy for å definere og kjøre multi-container Docker applikasjoner. 
Med en YAML-fil kan du konfigurere hver docker-container og kople dem sammen, og starte dem med en enkel kommando.

I vårt prosjekt finnes det allerede Dockerfiles i hver service-mappe, så vi trenger bare å lage en `docker-compose.yml` fil i meta-repo mappen.


## 🛠 Steg-for-steg

### Steg 1: Opprett docker-compose.yml

Opprett en `docker-compose.yml` fil i meta-repo mappen:

```bash
# Klipp og lim hele denne kommandoen:
cat > docker-compose.yml << 'EOF'
services:
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
      
  meta-todo-frontend:
    build: ./todo-frontend
    ports:
      - "8081:80"
    environment:
      - API_URL=http://meta-todo-backend:8080
    depends_on:
      - meta-todo-backend

EOF
```

### Steg 2: Bygg og start services

**⚠️ Viktig**: Hvis du kjører workshop-en i Docker, må du først avslutte Docker-containeren og gå tilbake til host-maskinen for å kunne kjøre Docker Compose.

```bash
# Hvis du er i Docker-container, skriv:
exit
```

Bygg og start alle services:
```
docker-compose up --build -d
```

Dette vil:
- Bygge Docker images for hver service
- Starte alle services i riktig rekkefølge
- Kjøre i bakgrunnen (-d flag)

### Steg 3: Utforsk kjørende services

Sjekk at alle services kjører med vanlige docker-compose kommandoer:

```bash
# Se status på alle services
docker-compose ps

# Følg logs fra alle services
docker-compose logs -f

# Se service-URLs
echo "Service URLs:"
echo "Frontend: http://localhost:8081"
echo "Backend:  http://localhost:8082/api/todos/count" 
echo "Sorter:   http://localhost:8083/health"
```

### Steg 4: Test servicene

Åpne en nettleser og gå til:
- Frontend: http://localhost:8081
- Backend API: http://localhost:8082/api/todos/count
- Sorter service: http://localhost:8083/health

Prøv å legge til todos i frontenden og se at alt fungerer sammen.

### Steg 5: Legg til Docker-kommandoer i din Makefile

Nå som Docker Compose fungerer, kan vi legge til praktiske make-kommandoer. Legg til disse kommandoene i din `Makefile`:

```makefile
up: ## Start alle services i bakgrunnen
	docker-compose up -d
	$(MAKE) urls

up-build: ## Bygg og start alle services
	docker-compose up --build -d
    (MAKE) urls

down: ## Stopp alle services
	docker-compose down

restart: down up ## Restart alle services

rebuild: down up-build ## Restart alle services med rebuild

logs: ## Vis service logs
	docker-compose logs -f

status: ## Vis service status
	docker-compose ps

urls: ## Vis service URLs
	@echo "Service URLs:"
	@echo "Frontend: http://localhost:8081"
	@echo "Backend:  http://localhost:8082/api/todos/count" 
	@echo "Sorter:   http://localhost:8083/health"
```

### Steg 6: Test make-kommandoene

Nå kan du teste make-kommandoene:

Stopp servicene først
```bash
make down
```
Start på nytt med make
```bash
make up
```
Se status
```bash
make status
```
Se URLs
```bash
make urls
```
Følg logs (Ctrl+C for å stoppe)
```bash
make logs
```
Restart services
```bash
make restart
```

### Steg 7: Commit Docker-integrasjonen

Commit Docker Compose-filen og Makefile-endringene:

```bash
git add docker-compose.yml Makefile
git commit -m"Legg til Docker Compose oppsett og make-kommandoer"
```

## 🎯 Ekstra-oppgaver: Health checks for bedre oppstart

Backend'en bruker noen sekunder mer enn frontenden på å bli klar, og det kan føre til at frontend ikke virker i starten.

Hvis du vil sikre at servicene faktisk er klare før avhengige tjenester starter, kan du legge til health checks i `docker-compose.yml`.


<details markdown="1">
  <summary>Klikk for å se health check oppsett</summary>

Erstatt din `docker-compose.yml` med denne versjonen:

```yaml
services:
  meta-todo-sorter:
    build: ./todo-sorter
    container_name: meta-todo-sorter
    ports:
      - "8083:3001"
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:3001/health"]
      interval: 10s
      timeout: 5s
      retries: 5

  meta-todo-backend:
    build: ./todo-backend
    container_name: meta-todo-backend
    ports:
      - "8082:8080"
    environment:
      - SORTER_SERVICE_URL=http://meta-todo-sorter:3001
    depends_on:
      meta-todo-sorter:
        condition: service_healthy
    volumes:
      - ./todo-backend/data:/app/data
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8080/actuator/health"]
      interval: 10s
      timeout: 5s
      retries: 5
      
  meta-todo-frontend:
    build: ./todo-frontend
    container_name: meta-todo-frontend
    ports:
      - "8081:80"
    environment:
      - API_URL=http://meta-todo-backend:8080
    depends_on:
      meta-todo-backend:
        condition: service_healthy
```

Dette sikrer at:
- `meta-todo-sorter` må være "healthy" før `meta-todo-backend` starter
- `meta-todo-backend` må være "healthy" før `meta-todo-frontend` starter
- Health checks kjører hver 10. sekund

Test det nye oppsettet:
```bash
make rebuild
# Observer at servicene starter i riktig rekkefølge og venter på hverandre
```

</details>

## 🔄 Feilsøking

### Vanlige problemer:

**Port conflicts**: 

Se hvilke porter som er i bruk
```bash
lsof -i :8081 # På Linux/Mac
```
Endre porter i docker-compose.yml hvis nødvendig

**Build feil**:

Bygg på nytt uten cache

```bash
docker-compose build --no-cache
```
Se detaljert logg under bygging
```bash
docker-compose up --build
```

**Service kan ikke starte**:

Se detaljerte feilmeldinger

```bash
docker-compose logs meta-todo-backend
```
Debug ved å kjøre service manuelt
```bash
docker run -it meta-todo_meta-todo-backend:latest sh
```

## 💡 Tips

- Bruk `make up-build` første gang og etter større endringer
- `make logs` er nyttig for debugging
- `docker-compose ps` viser quick status
- Bruk `docker system prune` for å rydde opp disk space
- `depends_on` sikrer riktig oppstartsrekkefølge

**[← Tilbake til oversikt](../)** | **[→ Neste oppgave: IDE-integrasjon](../07-ide-integration/)**