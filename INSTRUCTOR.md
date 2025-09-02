# 📋 INSTRUKTØR GUIDE

## Workshop-struktur
1. **Introduksjon (Del 1)**: Problemstilling - utfordringer med mange repositories
2. **Meta-repo (Del 2)**: Hva er meta-repo, fordeler, alternative verktøy
   - **Forutsetninger (01-prereqs/)**: Installer Node.js, npm, og `meta` CLI verktøy (Docker-alternativ tilgjengelig)
3. **Meta Verktøy (Del 3)**: Introduksjon til `meta` CLI, grunnleggende kommandoer
    - **Demo 1**: Real-world meta-repo introduksjon med eessi-pensjon
   - **Oppsett (02-setup/)**: Klon Oppdemo-meta-repo, legg til sub-repo, test grunnleggende kommandoer
   - **Demo 2**: Meta kommandoer i praksis med eessi-pensjon
   - **Kommandoer (03-commands/)**: Kommandolinje-øvelser med `meta exec`, ekskludering og kommando-kjeding (inkluderer cloc i steg 5)
4. **Automatisering (Del 4)**: Make og Makefile integrasjon
   - **Automatisering Praksis (04-automation/)**: Make og Makefile oppsett, automatiseringsskript (inkluderer make stats med cloc)
   - **Demo 3**: Real-world automatisering - Makefile og Gradle oppgraderinger med eessi-pensjon
5. **Git-historikk analyse (Del 5)**: Code hotspots og analyse
   - **Git Analyse Praksis (05-git-history/)**: Lag "hotspots" make target for å finne mest endrede filer
   - **Demo 4**: Git historikk analyse - hvilke filer endres oftest i eessi-pensjon
   - **Demo 5**: Analyse på tvers av repositories - Spring Boot versjoner, cloc kodestatistikk og tertialrapporter
6. **Docker & Docker Compose (Del 6)**: Docker containere og service koordinering
   - **Docker Praksis (06-dockered/)**: Docker Compose oppsett for meta-repo med service koordinering
7. **IDE Integrasjon (Del 7)**: Gradle Composite Build, enhetlig IntelliJ workspace
   - **IDE Integrasjon Praksis (07-ide-integration/)**: Gradle Composite Build og enhetlig IntelliJ workspace
   - **Demo 5**: IDE integrasjon med enhetlig søk, navigering og workspace
8. **Templates på tvers (Del 8)**: Template-system for konsistens
   - **Demo 6**: Template-system - Java version oppgradering fra 21.0.4 til 21.0.8 med eessi-pensjon
9. **Cross-repo koordinering (Del 9)**: Mer enn bare kode
   - **Cross-repo Praksis (08-cross-repo/)**: Lag "recent-activity" make target, koordinert commit workflow
   - Flere eksempler: dependency management, sikkerhet, konfigurasjonsendringer, release koordinering


## ⏱ FAKTISK TIDSPLAN (basert på vurdering av innhold, og gjennomkjøring)

| Tid       | Varighet | Tema                                      | Type                       | Notater |
|-----------|----------|-------------------------------------------|----------------------------|---------|
| 00:00     | 14 min   | **Del 1: Introduksjon**                   | Slides                     | Velkommen, problemstilling |
| 00:14     | 10 min   | **Del 2: Meta-repo konsept + 01-prereqs** | Slides + Hands-on          | Motivasjon + Node/npm install |
| 00:25     | 7 min    | **Del 3: Meta-verktøyet**                 | Slides + Demo 1            | .meta-fil, kommandoer, eessi-pensjon demo |
| 00:32     | 12 min   | **02-setup**                              | Hands-on + Demo 2          | Klon, meta init, eessi praksis |
| 00:44     | 12 min   | **03-commands**                           | Hands-on                   | meta exec, filtrering, cloc (steg 5) |
| 00:56     | 5 min    | **Del 4: Make introduksjon**              | Slides                     | Makefile syntax, .PHONY osv |
| 01:00     | 20 min   | **04-automation**                         | Hands-on + Demo 3          | Makefile, make stats, eessi demo |
| 01:20     | 12 min   | **05-git-history**                        | Hands-on + Demo 4          | Hotspots, git log analyse |
| 01:32     | 10 min   | **Del 5: Docker intro**                   | Slides + Hands-on          | Docker Compose konsepter |
| 01:42     | 10 min   | **Demo 5: Analyse på tvers**              | Demo 5                     | Spring Boot versjoner, cloc statistikk |
| 01:52     | 3 min    | **Del 6: IDE intro**                      | Slides                     | Gradle Composite Build |
| 01:55     | 8 min    | **Demo 6: IDE integrasjon**               | Demo 6                     | Enhetlig IntelliJ workspace |
| 02:03     | 5 min    | **Hands-on: IDE integrasjon**             | Oppgave 7                  | Enhetlig IntelliJ workspace |
| 02:08     | 8 min    | **Del 7: Templates**                      | Slides + Demo 7            | Template-system, Java version bump |
| 02:16     | 10 min   | **Del 8: Cross-repo koordinering**        | Slides + **08-cross-repo** | Eksempler + hands-on |
| **02:26** |          | **FERDIG**                                |                            | |

**Prioritering:**
- **Kjerneinnhold**: Del 1-4 + workshop 01-04 (grunnleggende meta + make)
- **Avansert**: Del 5-9, prioriter git-history og cross-repo workshops  
- **Kan forkortes**: Del 5-6 slides, Demo 5, Demo 7
- **Kan skipes**: 06-dockered, 07-ide-integration workshops

## ⏱ WORKSHOP-SPEC.md Tidsplan (2 timer) - OPPRINNELIG

| Tid | Varighet | Tema | Type |
|-----|----------|------|------|
| 00:00 | 5 min | Introduksjon, agenda, finne plassene | Presentasjon |
| 00:05 | 7 min | Motivasjon og introduksjon til meta-repo | Presentasjon |
| 00:12 | 3 min | Introduksjon til verktøyet meta og .meta-fil | Demo |
| 00:15 | 10 min | Oppsett av meta-verktøyet & kloning av demo-repo | Hands-on |
| 00:25 | 10 min | Kommandolinje-øvelser | Hands-on |
| 00:35 | 15 min | Bruk av make eller script til nyttige kommandoer (git pull, status etc) | Hands-on |
| 00:50 | 10 min | Kodeendring på tvers av repo | Hands-on |
| 01:00 | 10 min | Kodeanalyse med cloc som eksempel | Hands-on |
| 01:10 | 15 min | git-historikk analyse (endringer, release notes, statistikk) | Hands-on |
| 01:25 | 5 min | Inspirasjon: Meta-CLI | Demo |
| 01:30 | 5 min | Inspirasjon: github-konfig | Demo |
| 01:35 | 10 min | Templates på tvers | Hands-on |
| 01:45 | 10 min | Hvordan sette opp et nytt meta-repo og legge til repo | Hands-on |
| 01:55 | 5 min | Avslutning | Presentasjon |

## 🚀 Meta Quick Commands

```bash
# Installer meta (hvis ikke gjort)
npm install -g meta

# Grunnleggende meta-kommandoer
meta git status           # Status for alle repos
meta git pull            # Pull alle repos
meta git branch          # Vis branches
meta exec "npm install"  # Kjør kommando i alle

# Klone alle repos
meta git clone

# Legge til nytt repo
meta project add frontend git@github.com:user/frontend.git
```

## 🔥 Vanlige problemer

**"meta: command not found"**
```bash
npm install -g meta
# Eller med npx
npx meta git status
```

**"npm: command not found"**
```bash
# Mac
brew install node
# Ubuntu/Debian
sudo apt-get install nodejs npm
```

**"cloc: command not found"**
```bash
# Mac
brew install cloc
# Ubuntu/Debian
sudo apt-get install cloc
```

**Git authentication issues**
```bash
# Bytt til HTTPS
meta exec "git remote set-url origin https://github.com/..."
```


## 📱 Viktige URLer

- **Slides:** http://localhost:8000/slides/
- **Meta docs:** https://github.com/mateodelnorte/meta
- **Workshop:** https://kjetiljd.github.io/meta-repo-workshop/
- **Slack:** #javazone-workshops

## 🆘 Nødplaner

**Hvis npm/internet feiler:**
- Bruk lokal npm cache
- Ha meta pre-installert
- USB med node_modules

**Hvis folk ikke får til oppgave 1:**
- Live-demo sammen
- Par-programmering
- Skip til oppgave 2

**Hvis vi går tom for tid:**
- Prioriter oppgave 1-4 (core meta setup og automation)  
- Vis Demo 6 (templates) i stedet for hands-on
- Skip workshop 06-07, fokus på 05 (git-history) og 08 (cross-repo)
- Fokus på konsepter over hands-on

## ✅ Sjekkliste før start

- [ ] `meta` installert og fungerer
- [ ] Demo-repos klare og tilgjengelige
- [ ] cloc installert
- [ ] WiFi fungerer
- [ ] Presentasjon oppe
- [ ] Backup på USB

## 🎯 Husk

- **Start on time!** (respekter folks tid)
- **Gå rundt aktivt under hands-on**
- **Live-demo hvis mange står fast**
- **Hold energien oppe**
- **Det er OK å ikke vite alt om meta**

## 🔧 Demo-repos

```bash
# Eksempel .meta fil
{
  "projects": {
    "backend": "git@github.com:kjetiljd/demo-backend.git",
    "frontend": "git@github.com:kjetiljd/demo-frontend.git",
    "shared": "git@github.com:kjetiljd/demo-shared.git",
    "mobile": "git@github.com:kjetiljd/demo-mobile.git",
    "docs": "git@github.com:kjetiljd/demo-docs.git"
  }
}
```

---

**Lykke til! Du er godt forberedt!** 💪
