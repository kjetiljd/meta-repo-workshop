# 📋 INSTRUKTØR GUIDE

## Workshop Flyt Struktur
1. **Introduksjon (Del 1)**: Problemstilling - utfordringer med mange repositories
2. **Meta-repository Konsept (Del 2)**: Hva er meta-repo, fordeler, alternative verktøy
   - **Demo 1**: Real-world meta-repo introduksjon med eessi-pensjon
3. **Meta Verktøy (Del 3)**: Introduksjon til `meta` CLI, grunnleggende kommandoer
   - **Forutsetninger (01-prereqs/)**: Installer Node.js, npm, og `meta` CLI verktøy (Docker-alternativ tilgjengelig)
   - **Oppsett (02-setup/)**: Klon demo-meta-repo, legg til sub-repo, test grunnleggende kommandoer
   - **Kommandoer (03-commands/)**: Kommandolinje-øvelser med `meta exec`, ekskludering og kommando-kjeding
   - **Demo 2**: Meta kommandoer i praksis med eessi-pensjon
4. **Automatisering (Del 4)**: Make og Makefile integrasjon
   - **Automatisering Praksis (04-automation/)**: Make og Makefile oppsett, automatiseringsskript
   - **Demo 3**: Real-world automatisering - Makefile og Gradle oppgraderinger med eessi-pensjon
5. **Docker & Docker Compose (Del 5)**: Docker containere og service koordinering
   - **Docker Praksis (05-dockered/)**: Docker Compose oppsett for meta-repo med service koordinering
   - **Demo 4**: Analyse på tvers av repositories - Spring Boot versjoner, kodestatistikk og tertialrapporter
6. **IDE Integrasjon (Del 6)**: Gradle Composite Build, enhetlig IntelliJ workspace
   - **IDE Integrasjon Praksis (06-ide-integration/)**: Gradle Composite Build og enhetlig IntelliJ workspace
   - **Demo 5**: IDE integrasjon med enhetlig søk, navigering og workspace

## ⏱ WORKSHOP-SPEC.md Tidsplan (2 timer)

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
- Prioriter oppgave 1-3, 6, 8
- Del løsninger for resten
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
