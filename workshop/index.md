# Workshop: Meta-Repository Pattern

## 📚 Oversikt

Denne workshopen består av oppgaver som bygger på hverandre, så her er det best å starte fra toppen.

## 🎯 Oppgaver

1. **[Installere `meta`](01-prereqs/)**
   - Installere Node.js og npm
   - Installere `meta` globalt via npm
   - Evt bruke Docker for isolert miljø

2. **[Oppsett og grunnleggende struktur](02-setup/)**
   - Klone demo-meta-repo
   - Legge til sub-repo
   - Teste noen kommandoer

3. **[Kommandolinje-øvelser](03-commands/)**
   - Kjøre `meta exec "kommando"`
   - Ekskludere repo
   - Kommando-kjeder

4. **[Automatisering med make/scripts](04-automation/)**
    - Litt om make og Makefile
    - Lage Makefile
    - Makefile-triks: .PHONY og help target

5. **[Docker og Docker Compose](05-dockered/)**
    - Sette opp Docker Compose for meta-repo
    - Service-koordinering og dependencies
    - Integrering med Makefile

6. **[IDE-integrasjon](06-ide-integration/)**
    - Gradle Composite Build setup
    - Unified workspace i IntelliJ
    - Cross-repository navigation og refactoring

| 00:50 | 10 min | Kodeendring på tvers av repo | Hands-on |
| 01:00 | 10 min | Kodeanalyse med cloc som eksempel | Hands-on |
| 01:10 | 15 min | git-historikk analyse (endringer, release notes, statistikk) | Hands-on |
| 01:25 | 5 min | Inspirasjon: Meta-CLI | Demo |
| 01:30 | 5 min | Inspirasjon: github-konfig | Demo |
| 01:35 | 10 min | Templates på tvers | Hands-on |
| 01:45 | 10 min | Hvordan sette opp et nytt meta-repo og legge til repo | Hands-on |
| 01:55 | 5 min | Avslutning | Presentasjon |
KLADD:

4. Sette opp meta-repository struktur
   - Definere repository manifest
   - Klone første repositories

2. **[Implementere basis-kommandoer](02-basic-commands/)** (20 min)
   - Clone-kommando
   - Status-kommando
   - Exec-kommando

3. **[Avanserte operasjoner](03-advanced/)** (25 min)
   - Filtrering og seleksjon
   - Batch-oppdateringer
   - Parallell eksekvering

4. **[Automatisering og CI/CD](04-automation/)** (20 min)
   - GitHub Actions workflows
   - Scheduled jobs
   - Status-rapportering

5. **[Real-world scenario](05-scenario/)** (10 min)
   - Koordinert dependency-oppdatering
   - Security scanning
   - Release coordination

## 🛠 Forutsetninger

Sjekk at du har følgende installert:

```bash
# Git
git --version

# Docker (valgfritt, men anbefalt)
docker --version

# Node.js (for enkelte scripts)
node --version

# Python 3 (for enkelte scripts)
python3 --version
```

## 💡 Tips

- Start med oppgave 1 og jobb deg gjennom i rekkefølge
- Hver oppgave har en README med instruksjoner
- Løsningsforslag finnes i `solutions/` mappen
- Hvis du står fast, spør!

## 🏁 La oss starte!

**[→ Start med Oppgave 1: Oppsett](02-setup/)**

---

## 📁 Struktur

```
workshop/
├── 01-setup/           # Grunnleggende oppsett
├── 02-basic-commands/  # Basis kommandoer
├── 03-advanced/        # Avanserte features
├── 04-automation/      # CI/CD og automatisering
├── 05-scenario/        # Real-world case
├── solutions/          # Løsningsforslag
└── README.md          # Denne filen
```

## ⏱ Tidsplan

| Oppgave | Estimert tid | Akkumulert |
|---------|--------------|------------|
| Oppsett | 15 min | 15 min |
| Basis-kommandoer | 20 min | 35 min |
| Avanserte operasjoner | 25 min | 60 min |
| Automatisering | 20 min | 80 min |
| Scenario | 10 min | 90 min |

## 🆘 Troubleshooting

Se [resources/troubleshooting.md](../resources/troubleshooting.md) hvis du støter på problemer.

