# 📋 INSTRUKTØR QUICK REFERENCE

## ⏱ Tidsplan (2 timer)

```
00:00 - Velkommen, praktisk info, finne plasser (5 min)
00:05 - Motivasjon og intro til meta-repo (7 min)
00:12 - Intro til meta-verktøyet og .meta fil (3 min)
00:15 - HANDS-ON: Oppsett & kloning (10 min)
00:25 - HANDS-ON: Kommandolinje-øvelser (10 min)
00:35 - HANDS-ON: Make/script automatisering (15 min)
00:50 - HANDS-ON: Kodeendring på tvers (10 min)
01:00 - HANDS-ON: Kodeanalyse med cloc (10 min)
01:10 - HANDS-ON: Git-historikk analyse (15 min)
01:25 - DEMO: Meta-CLI avansert (5 min)
01:30 - DEMO: GitHub-konfig (5 min)
01:35 - HANDS-ON: Templates på tvers (10 min)
01:45 - HANDS-ON: Nytt meta-repo oppsett (10 min)
01:55 - Avslutning og Q&A (5 min)
```

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

## 💬 Talking Points per seksjon

### Introduksjon (5 min)
- "Hvor mange jobber med 5+ repos?"
- "Hvem har vurdert monorepo?"
- WiFi-passord, Slack-kanal

### Motivasjon (7 min)
- "Kontekst-switching dreper produktivitet"
- "Monorepo er ikke alltid svaret"
- "Meta-repo = best of both worlds"

### Meta-verktøyet (3 min)
- "NPM-pakke, ikke eget system"
- ".meta er bare JSON"
- "Plugins for alt mulig"

### Oppgave 1: Oppsett
- "Ikke bekymre deg hvis det tar tid"
- "Hjelp hverandre!"

### Oppgave 3: Automatisering
- "Dette er hvor det blir kraftfullt"
- "Tenk på repetitive tasks dere har"

### Oppgave 5: Kodeanalyse
- "cloc gir quick overview"
- "Kan utvides med andre verktøy"

### Oppgave 6: Git-historikk
- "Release notes på tvers av repos!"
- "Se hvem som contributer hvor"

### Demo: Meta-CLI
- "Bare smakebit - mye mer å utforske"

### Avslutning
- "Hva var mest nyttig?"
- "Hvordan kan dere bruke dette?"

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
