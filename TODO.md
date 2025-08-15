# 📋 TODO-LISTE for Workshop-utvikling

## 🔴 KRITISK - Må gjøres først

### Verktøy-oppsett
- [ ] **Bytt fra custom bash-scripts til `meta` NPM-pakke**
  - [ ] Installer meta globalt: `npm install -g meta`
  - [ ] Lag `.meta` fil for workshop
  - [ ] Oppdater alle eksempler til å bruke `meta` kommandoer
- [ ] **Sett opp demo-repositories**
  - [ ] Lag minst 5-6 demo repos på GitHub
  - [ ] Fyll dem med realistisk kode (ulike språk/frameworks)
  - [ ] Lag en "broken" repo for troubleshooting-øvelser

### Presentasjon (slides/)
- [ ] **Slide 1-3: Introduksjon (5 min)**
  - [ ] Velkommen og praktisk info
  - [ ] Agenda-oversikt
  - [ ] Forventningsavklaring
- [ ] **Slide 4-10: Motivasjon (7 min)**
  - [ ] Problem: Mange repo = kaos
  - [ ] Mono-repo vs Multi-repo trade-offs
  - [ ] Meta-repo som mellomvei
  - [ ] Real-world eksempler fra Telenor
- [ ] **Slide 11-13: Meta-verktøyet (3 min)**
  - [ ] Hva er meta (npm-pakke)
  - [ ] .meta fil-format
  - [ ] Grunnleggende kommandoer

## 🟡 VIKTIG - Workshop-oppgaver

### Oppgave 1: Oppsett (10 min)
- [ ] **workshop/01-setup/**
  - [ ] Instruksjoner for npm install -g meta
  - [ ] Klone demo-meta-repo
  - [ ] Forklare .meta fil-struktur
  - [ ] Kjøre `meta git clone`

### Oppgave 2: Kommandolinje-øvelser (10 min)
- [ ] **workshop/02-commands/**
  - [ ] `meta git status`
  - [ ] `meta git branch`
  - [ ] `meta git pull`
  - [ ] `meta exec "kommando"`

### Oppgave 3: Make/Script (15 min)
- [ ] **workshop/03-automation/**
  - [ ] Lag Makefile med vanlige operasjoner
  - [ ] Script for bulk-operasjoner
  - [ ] Eksempel: Oppdater dependencies overalt

### Oppgave 4: Kodeendring på tvers (10 min)
- [ ] **workshop/04-cross-repo/**
  - [ ] Search/replace på tvers av repos
  - [ ] Refactoring-eksempel
  - [ ] Commit og push til alle

### Oppgave 5: Kodeanalyse med cloc (10 min)
- [ ] **workshop/05-analysis/**
  - [ ] Installer cloc
  - [ ] Analyser kodebase samlet
  - [ ] Generer rapport

### Oppgave 6: Git-historikk (15 min)
- [ ] **workshop/06-git-history/**
  - [ ] Samle commit-statistikk
  - [ ] Generere release notes
  - [ ] Contributor-analyse

### Oppgave 7: Templates (10 min)
- [ ] **workshop/07-templates/**
  - [ ] Felles .gitignore
  - [ ] CI/CD templates
  - [ ] README-template

### Oppgave 8: Nytt meta-repo (10 min)
- [ ] **workshop/08-new-meta/**
  - [ ] meta init
  - [ ] meta project add
  - [ ] Konfigurere .meta

## 🟢 BRA Å HA - Ekstra materiale

### Demo-seksjoner
- [ ] **Meta-CLI demo (5 min)**
  - [ ] Avanserte meta-kommandoer
  - [ ] Plugins og extensions
- [ ] **GitHub-konfig demo (5 min)**
  - [ ] Branch protection rules
  - [ ] Webhooks på tvers
  - [ ] Team permissions

### Resources
- [ ] **resources/cheatsheet.md**
  - [ ] Alle meta-kommandoer
  - [ ] Vanlige use-cases
  - [ ] Troubleshooting
- [ ] **resources/links.md**
  - [ ] Link til meta npm-pakke
  - [ ] Link til YouTube-video
  - [ ] Relevante artikler

### Demo-repositories
- [ ] **demo-repos/**
  - [ ] backend-api (Node.js)
  - [ ] frontend-app (React)
  - [ ] mobile-app (React Native)
  - [ ] shared-library (TypeScript)
  - [ ] documentation (Markdown)
  - [ ] infrastructure (Terraform)

## 🔵 FORBEREDELSER

### Testing
- [ ] Test alle oppgaver ende-til-ende
- [ ] Test på Windows, Mac, Linux
- [ ] Test med/uten Docker
- [ ] Test nettverks-uavhengig (offline mode)

### Praktisk
- [ ] Oppdater INSTRUCTOR.md med meta-kommandoer
- [ ] Lag backup USB med alt materiale
- [ ] Forbered fallback hvis npm/internet feiler
- [ ] Test med 2-3 kollegaer først

### Tilpasninger
- [ ] Bytt alle placeholder [navn] etc
- [ ] Legg inn LinkedIn-lenke
- [ ] Oppdater bio hvis nødvendig
- [ ] Sjekk at YouTube-lenke fungerer

## 📊 PRIORITERING

### Fase 1 (Gjør NÅ)
1. Installer meta og test at det fungerer
2. Lag demo-repositories
3. Skriv om oppgave 1 til å bruke meta
4. Oppdater presentasjon med riktig innhold

### Fase 2 (Denne uken)
1. Lag alle workshop-oppgaver
2. Test ende-til-ende
3. Lag løsninger for hver oppgave

### Fase 3 (Før workshop)
1. Finpuss presentasjon
2. Test med kollegaer
3. Forbered backup-planer

## 📝 NOTATER

### Fra YouTube-video (https://youtu.be/GFaWYmctdfY)
- [ ] Se gjennom video for å hente ut:
  - [ ] Gode eksempler
  - [ ] Visualiseringer
  - [ ] Talking points
  - [ ] Demo-sekvenser

### Meta npm-pakke dokumentasjon
- Hovedside: https://github.com/mateodelnorte/meta
- Kommandoer: https://github.com/mateodelnorte/meta/wiki/Commands
- Plugins: https://github.com/mateodelnorte/meta#plugins

### Cloc
- Installasjon: `brew install cloc` eller `apt-get install cloc`
- Dokumentasjon: https://github.com/AlDanial/cloc

## ✅ DEFINISJON AV FERDIG

Workshop er klar når:
- [ ] Alle 8 oppgaver har README med instruksjoner
- [ ] Alle oppgaver har fungerende løsninger
- [ ] Presentasjon dekker alle punkter i agenda
- [ ] Demo-repositories er opprettet og fungerer
- [ ] Alt er testet ende-til-ende
- [ ] Backup-planer er dokumentert
- [ ] INSTRUCTOR.md er oppdatert med riktige kommandoer

---

**Start med:** Installer `meta` og test at det fungerer!

```bash
npm install -g meta
meta --help
```
