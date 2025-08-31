# 📋 TODO-LISTE for Workshop-utvikling

## 🔴 KRITISK - Må gjøres først

### Presentasjon (slides/)
- [X] **Slide 1-3: Introduksjon (5 min)**
    - [X] Velkommen og praktisk info
    - [X] Agenda-oversikt
    - [X] Forventningsavklaring
- [X] **Slide 4-10: Motivasjon (7 min)**
    - [X] Problem: Mange repo = kaos
    - [X] Mono-repo vs Multi-repo trade-offs
    - [X] Meta-repo som mellomvei
    - [X] Real-world eksempler (eessi-pensjon demo)
- [X] **Slide 11-13: Meta-verktøyet (3 min)**
    - [X] Hva er meta (npm-pakke)
    - [X] .meta fil-format
    - [X] Grunnleggende kommandoer

### Verktøy-oppsett
- [X] **Bytt fra custom bash-scripts til `meta` NPM-pakke**
  - [X] Installer meta globalt: `npm install -g meta`
  - [X] Lag `.meta` fil for workshop
  - [X] Oppdater alle eksempler til å bruke `meta` kommandoer
- [X] **Sett opp demo-repositories**
  - [X] Bruker demo-meta-repo fra GitHub
  - [X] Realistisk kode (todo-apps i forskjellige teknologier)
  - [X] Fungerer med meta-kommandoer


## 🟡 VIKTIG - Workshop-oppgaver

### Oppgave 1: Oppsett (10 min)
- [X] **workshop/01-prereqs/** (renamed from setup)
  - [X] Instruksjoner for npm install -g meta
  - [X] Docker-alternativ for Windows
  - [X] Forklare .meta fil-struktur

### Oppgave 2: Setup (10 min)  
- [X] **workshop/02-setup/**
  - [X] Klone demo-meta-repo
  - [X] Kjøre `meta git clone`
  - [X] Teste basic commands

### Oppgave 3: Kommandolinje-øvelser (10 min)
- [X] **workshop/03-commands/**
  - [X] `meta git status`
  - [X] `meta exec` med forskjellige kommandoer
  - [X] `--exclude` filtering
  - [X] Command chaining

### Oppgave 4: Make/Script (15 min)
- [X] **workshop/04-automation/**
  - [X] Lag Makefile med vanlige operasjoner
  - [X] Script for bulk-operasjoner
  - [X] Make og meta integration

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
- [X] **workshop/08-new-meta/** - DEKKET (gjøres tidlig i workshop)
  - [X] meta init
  - [X] meta project add
  - [X] Konfigurere .meta

## 🟢 BRA Å HA - Ekstra materiale

### Demo-seksjoner
- [X] **Eessi-pensjon demos (5 demos totalt)**
  - [X] Real-world meta-repo introduction
  - [X] Meta commands in practice  
  - [X] Automation with Makefile and Gradle upgrades
  - [X] Cross-repository analysis (Spring Boot versions, cloc, tertial reports)
  - [X] IDE integration with unified search and navigation
- [ ] **Meta-CLI demo (5 min)** - mangler i WORKSHOP-SPEC.md
  - [ ] Avanserte meta-kommandoer
  - [ ] Plugins og extensions  
- [ ] **GitHub-konfig demo (5 min)** - mangler i WORKSHOP-SPEC.md
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
- [X] Oppdater INSTRUCTOR.md med meta-kommandoer
- [X] Lag demo manuscript for eessi-pensjon demos
- [ ] Lag backup USB med alt materiale
- [ ] Forbered fallback hvis npm/internet feiler
- [ ] Test med 2-3 kollegaer først

### Tilpasninger
- [ ] Bytt alle placeholder [navn] etc
- [ ] Legg inn LinkedIn-lenke
- [ ] Oppdater bio hvis nødvendig
- [ ] Sjekk at YouTube-lenke fungerer

## 📊 PRIORITERING

### Fase 1 (Gjør NÅ) - FERDIG
1. [X] Installer meta og test at det fungerer
2. [X] Lag demo-repositories
3. [X] Skriv om oppgave 1 til å bruke meta
4. [X] Oppdater presentasjon med riktig innhold

### Fase 2 (Denne uken) - DELVIS FERDIG
1. [X] Lag grunnleggende workshop-oppgaver (01-04)
2. [X] Lag eessi-pensjon demos
3. [ ] Implementer manglende WORKSHOP-SPEC.md oppgaver (se PLAN.md)
4. [ ] Test ende-til-ende
5. [ ] Lag løsninger for hver oppgave

### Fase 3 (Før workshop)
1. [X] Finpuss presentasjon (slides ferdig)
2. [ ] Test med kollegaer
3. [ ] Forbered backup-planer

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
- [X] Presentasjon dekker alle punkter i agenda
- [X] Demo-repositories er opprettet og fungerer  
- [X] INSTRUCTOR.md er oppdatert med riktige kommandoer
- [X] Demo manuscript er laget
- [ ] Alle WORKSHOP-SPEC.md oppgaver har README med instruksjoner (se PLAN.md for gaps)
- [ ] Alle oppgaver har fungerende løsninger
- [ ] Alt er testet ende-til-ende
- [ ] Backup-planer er dokumentert

---

**Start med:** Installer `meta` og test at det fungerer!

```bash
npm install -g meta
meta --help
```
