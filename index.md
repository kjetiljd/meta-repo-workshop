---
title: "Meta-Repository Workshop"
description: "Mono-repo eller mange repo? Prøv meta-repo! - JavaZone 2025"
---

# 🚀 Meta-Repository Workshop

**Mono-repo eller mange repo? Prøv meta-repo!**

JavaZone 2025 - 2 timers hands-on workshop

## 🎯 Kom i gang

<div style="text-align: center; margin: 2rem 0;">
  <a href="slides/" style="display: inline-block; margin: 0.5rem; padding: 1rem 2rem; background: #159957; color: white; text-decoration: none; border-radius: 0.3rem; font-weight: bold;">📊 Start presentasjon</a>
  <a href="workshop/" style="display: inline-block; margin: 0.5rem; padding: 1rem 2rem; background: #155799; color: white; text-decoration: none; border-radius: 0.3rem; font-weight: bold;">💻 Gå til workshop</a>
  <a href="https://github.com/kjetiljd/meta-repo-workshop" style="display: inline-block; margin: 0.5rem; padding: 1rem 2rem; background: #333; color: white; text-decoration: none; border-radius: 0.3rem; font-weight: bold;">📦 GitHub</a>
</div>

## 📚 Workshop-innhold

### 📚 Introduksjon
Motivasjon og introduksjon til meta-repo pattern med verktøyet `meta`.

### 🛠 Hands-on
8 praktiske oppgaver: oppsett, kommandoer, automatisering, analyse og mer.

### 💡 Inspirasjon
Avanserte muligheter med Meta-CLI, GitHub-konfig og templates.

## 📋 Forutsetninger

- Node.js og npm installert
- Git installert og konfigurert
- Grunnleggende kjennskap til Git
- Erfaring med flere repositories
- En god teksteditor (VS Code, IntelliJ, etc.)

## 🎯 Du vil lære

- Hva meta-repo er og når det passer
- Bruke `meta` NPM-pakken effektivt
- Kjøre kommandoer på tvers av mange repos
- Automatisere repetitive oppgaver
- Analysere kode og git-historikk samlet
- Sette opp ditt eget meta-repo fra scratch

## 🚀 Installasjon

Installer verktøyet og klon workshop-materialet:

```bash
# Installer meta globalt
npm install -g meta

# Klon workshop-materialet
git clone https://github.com/kjetiljd/meta-repo-workshop.git
cd meta-repo-workshop

# Start lokal server for slides
python3 -m http.server 8000
```

## 💻 Lokal utvikling med Jekyll

Hvis du vil kjøre workshop-materialet lokalt med Jekyll:

```bash
# Med Docker (anbefalt)
make serve

# Eller uten Docker
bundle install
bundle exec jekyll serve
```

---

**Workshop av [Kjetil Jørgensen-Dahl](https://www.linkedin.com/in/kjetiljd/)**  
*Principal Software Engineer @ Telenor*
