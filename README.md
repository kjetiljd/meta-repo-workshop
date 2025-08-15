# Meta-Repository Workshop - JavaZone 2025

## 🎯 Mono-repo eller mange repo? Prøv meta-repo!

Velkommen til workshop om **meta-repo** - en teknikk for å håndtere mange repositories uten å gå all-in på monorepo.

## 📚 Rask-start

### Online versjon
Gå til: https://kjetiljd.github.io/meta-repo-workshop/

### Lokal versjon
```bash
git clone https://github.com/kjetiljd/meta-repo-workshop.git
cd meta-repo-workshop
python3 -m http.server 8000
```
Åpne http://localhost:8000 i nettleseren.

## 🛠 Forutsetninger

Installer følgende FØR workshopen:

```bash
# 1. Node.js og npm
node --version  # Should be v14 or higher
npm --version

# 2. Meta (hovedverktøyet vi skal bruke)
npm install -g meta
meta --help

# 3. Git
git --version

# 4. cloc (for kodeanalyse)
# Mac:
brew install cloc
# Ubuntu/Debian:
sudo apt-get install cloc
# Windows:
choco install cloc

# 5. Make (valgfritt men nyttig)
make --version
```

## 📝 Agenda (2 timer)

1. **Introduksjon** (5 min) - Velkommen og praktisk info
2. **Motivasjon** (7 min) - Hvorfor meta-repo?
3. **Meta-verktøyet** (3 min) - Introduksjon til meta og .meta fil
4. **Hands-on øvelser** (85 min)
   - Oppsett og kloning
   - Kommandolinje-øvelser
   - Automatisering med make/scripts
   - Kodeendring på tvers av repos
   - Kodeanalyse med cloc
   - Git-historikk analyse
   - Templates
   - Opprette nytt meta-repo
5. **Inspirasjon** (10 min) - Avanserte muligheter
6. **Avslutning** (5 min) - Oppsummering og Q&A

## 🎯 Dette lærer du

- ✅ Hva meta-repo er og når det passer
- ✅ Sette opp og bruke `meta` verktøyet
- ✅ Kjøre kommandoer på tvers av mange repos
- ✅ Automatisere repetitive oppgaver
- ✅ Analysere kode og git-historikk samlet
- ✅ Beste praksis for multi-repo håndtering

## 💻 Workshop-oppgaver

Alle oppgaver finner du i `workshop/` mappen:

1. [Oppsett](./workshop/01-setup/) - Kom i gang med meta
2. [Kommandoer](./workshop/02-commands/) - Grunnleggende meta-kommandoer
3. [Automatisering](./workshop/03-automation/) - Make og scripts
4. [Kodeendring](./workshop/04-cross-repo/) - Endre kode på tvers
5. [Analyse](./workshop/05-analysis/) - Kodeanalyse med cloc
6. [Git-historikk](./workshop/06-git-history/) - Commit-analyse
7. [Templates](./workshop/07-templates/) - Standardisering
8. [Nytt meta-repo](./workshop/08-new-meta/) - Start fra scratch

## 💡 Tips

- **Står du fast?** Sjekk `workshop/solutions/` eller spør!
- **Problemer?** Se [troubleshooting](./resources/troubleshooting.md)
- **Spørsmål?** Post i Slack: #javazone-workshops

## 📚 Ressurser

- [Meta documentation](https://github.com/mateodelnorte/meta)
- [Meta plugins](https://github.com/mateodelnorte/meta#plugins)
- [cloc documentation](https://github.com/AlDanial/cloc)
- [Talk: Meta-repo (40 min)](https://youtu.be/GFaWYmctdfY)

## 👨‍💻 Om workshopleder

**Kjetil Jørgensen-Dahl** - Principal Software Engineer @ Telenor

Utvikler og smidig-entusiast med passion for å redusere kognitiv last og bekjempe entropi i programvareutvikling. Jobber med transformasjon av Telenor til en moderne tech-bedrift.

- LinkedIn: [kjetiljd](https://www.linkedin.com/in/kjetiljd/)
- GitHub: [@kjetiljd](https://github.com/kjetiljd)

---

**La oss sette i gang!** 🚀
