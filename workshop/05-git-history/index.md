# 05 - Git historikk-analyse på tvers av repositories

**Varighet:** 15 minutter

## Mål

Lage verktøy for å analysere git-historikk på tvers av alle repositories og finne hvilke filer som endres oftest.

## Oppgave: Lag "hotspots" kommando

Vi skal lage et make target som finner de mest endrede filene på tvers av alle repositories.

### Steg 1: Forstå git log formatet

Først, la oss se hvordan vi kan få ut filendringer fra git:

```bash
# Se hvilke filer som er endret i hver commit
git log --name-only --oneline -10

# Telle filendringer (test i ett repo først)
git log --name-only --pretty=format: | grep -v '^$' | sort | uniq -c | sort -rn | head -10
```

### Steg 2: Lag make target i meta-repository

Vi lager et make target som kan kjøres fra hovedmappen:

```bash
# Legg til make target i meta-repo Makefile
printf '\nhotspots: ## Show most frequently changed files across all repos\n\t@meta exec "git log --name-only --pretty=format: | grep -Ev \"^$$\" | sort | uniq -c | sort -rn | head -5"\n' >> Makefile

# Verifiser at det ble lagt til
tail -5 Makefile
```

### Steg 3: Test det nye make target

```bash
# Kjør hotspots-analysen
make hotspots

```

#### Se på filhistorikken

Dersom du lurer på hvorfor en fil endres ofte, kan du se på commit-historikken for den filen:

```bash
# Bytt ut REPO of PATH/TO/FILE med filen du vil undersøke
cd REPO ; git log --oneline -- PATH/TO/FILE ; cd - 
```

### Steg 4: Commit den nye make commandoen

```bash
# Se hva som ble endret
git diff

# Legg til endringene
git add Makefile

# Commit 
git commit -m "Add hotspots analysis for git history across repos"

# Se status
git status
```

## Forventet resultat

Du skal få en oversikt som ligner:

```
todo-frontend:
   2 package.json
   1 vite.config.ts
   1 src/main.ts
   1 src/components/TodoList.vue
   1 README.md

todo-backend:
   4 Makefile
   1 src/main/resources/db/migration/V2__Insert_sample_data.sql
   1 src/main/resources/db/migration/V1__Create_todos_table.sql
   1 src/main/resources/application.yml
   1 src/main/java/com/workshop/todoapi/TodoApiApplication.java

todo-sorter:
   5 Makefile
   1 test/sortingService.test.js
   1 src/services/sortingService.js
   1 src/server.js
   1 src/routes/sortRoutes.js
```


## Refleksjon

**Diskuter:**
- Hvilke filer endres oftest? Hvorfor?
- Hva forteller dette om kodekvalitet og arkitektur?
- Hvordan kan vi bruke denne informasjonen?
- Ville dette vært vanskeligere uten meta-repository?

## Ekstra utfordringer

1. **Filtrer bort konfigfiler**: Ekskluder package.json, README.md, etc.
2. **Tidsperiode**: Legg til `--since="1 month ago"` for nyere analyse
3. **Per utvikler**: Kombiner med `--author="navn"` for å se hver persons hotspots

## Tips

- `git log --name-only` viser filnavn for hver commit
- `uniq -c` teller duplikater
- `sort -rn` sorterer numerisk, høyest først
- `head -N` begrenser output til N linjer

**[← Tilbake til oversikt](../)** | **[→ Neste oppgave: Docker & Docker Compose](../06-dockered/)**