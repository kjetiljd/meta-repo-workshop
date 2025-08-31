# 08 - Kodeendring på tvers av repositories


## Mål

Lære å gjøre koordinerte kodeendringer på tvers av flere repositories.


## Oppgave: Lag en "recent-activity" kommando

Lag et make target som viser hva som har skjedd siste 7 dager på tvers av alle repositories.

### Steg 1: Se hva som har skjedd siste uke

Først, la oss se aktiviteten på tvers av alle repos:

```bash
# Se commits siste 7 dager med dato og tid
meta exec "git log origin/main --since='7 days ago' --reverse --oneline --pretty=format:'%ad %h %s' --date=format:'%Y-%m-%d %H:%M'"
```

### Steg 2: Lag make target i hver repo

Vi lager et make target som kan kjøres på tvers av alle repos:

```bash
# Legg til make target i alle repositories  
meta exec "printf '\n\nrecent-activity:\n\t@git log origin/main --since=\"7 days ago\" --reverse --oneline --pretty=format:\"%%ad %%h %%s\" --date=format:\"%%Y-%%m-%%d %%H:%%M\"\n' >> Makefile"

# Verifiser at det ble lagt til
meta exec "tail -3 Makefile"
```

### Steg 3: Test det nye make target

```bash
# Kjør den nye kommandoen på alle repos
meta exec "make recent-activity"
```

### Steg 4: Commit endringen

```bash

# Legg til endringene
meta git add -p

# Commit med samme melding i alle repos  
meta exec "git commit -m 'Add recent-activity make target'"

# Se status
meta git status
```

Nå kan man i hvert uavhengig repo enkelt se hva som har skjedd siste uke med `make recent-activity`.

---

## Ekstraoppgave: Legg til nytt priority-nivå "urgent"

Vi skal legge til et nytt priority-nivå "urgent" som skal være høyere enn "high". Dette krever koordinerte endringer i alle tre repositories.

### Steg 1: Analyser dagens tilstand

Først, la oss se hvor priority er definert på tvers av alle repos:

```bash

# Finn priority-definisjoner i ett søk
meta exec "grep -Ern 'high|HIGH' src/" --exclude todo-meta
```


### Steg 2: Identifiser nødvendige endringer

Basert på søkeresultatet ser vi at "urgent" priority må legges til i:

**Frontend (todo-frontend):**
- `src/types/todo.ts` - TypeScript interfaces (3 steder)
- `src/components/TodoForm.vue` - Dropdown med priority-valg
- `src/components/TodoItem.vue` - Styling basert på priority

**Backend (todo-backend):**
- `src/main/java/.../Todo.java` - Java enum
- `src/main/resources/db/migration/` - Database schema og test data
- `src/main/java/.../TodoRepository.java` - Sortering query

**Sorter (todo-sorter):**
- `src/services/sortingService.js` - Priority mapping og kommentarer


### Steg 3: Start en feature branch pg gjør endringene

```bash
meta exec "git checkout -b add-urgent-priority" --exclude todo-meta
```
-> Gjør endringene som skal til i hvert repo

### Steg 4: Forstå endringene


```bash
# Se forskjellen 
meta exec "git diff"

# Bygg alle prosjektene for å se at endringene er kompatible
meta exec "make build" --parallel

# Test at systemet fortsatt fungerer
meta exec "make test" --parallel
```

### Steg 5: Commit med kontroll


```bash
# Gjennomgå endringene interaktivt før commit
meta exec "git add -p" --exclude todo-meta

# Commit med samme melding i alle repos
meta exec "git commit -m 'Add URGENT priority level - coordinated change'"

# Se status på tvers av repos
meta git status
```

### Om du ikke blir ferdig før vi må videre

Bruk `git stash save`:

```bash
meta exec "git stash save 'WIP: adding urgent priority'" --exclude todo-meta
```

```bash
meta exec "git checkout main"
```

---

## 💡 Flere cross-repo muligheter

Meta-repo åpner for mange koordinerte endringer på tvers av repositories:

### Build & CI/CD
- `timeout-minutes:` og andre endringer i byggeskript
- Oppdatere gradle-wrapper og andre verktøy (Docker, Node, Python)
- Bytte Docker baseimage

### Kode-modernisering  
- Oppdatere mange steder pga deprekert API
- Trekke ut bibliotek fra flere app'er
- Konsolidere/redusere variasjon (Kent Beck: "Normalize Symmetries")

### Infrastruktur
- Endringer i oppstartsscript for Docker-containere  
- Oppsett av regler og sjekker for brancher/PR'er på GitHub
- Sette opp formatteringsregler (.editorconfig)
- Minor/patch/major-oppgraderinger av avhengigheter

Dette er bare noen eksempler på hva som er mulig med meta-repo koordinering!

**[← Tilbake til oversikt](../)** | **[→ Workshop ferdig! Se slides for oppsummering](../../slides/)**