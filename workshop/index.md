# Workshop: Meta-Repository Pattern

## 📚 Oversikt

Denne workshopen består av 5 progressive oppgaver som bygger på hverandre. Vi starter enkelt og øker kompleksiteten gradvis.

## 🎯 Oppgaver

1. **[Oppsett og grunnleggende struktur](01-setup/)** (15 min)
   - Sette opp meta-repository struktur
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

**[→ Start med Oppgave 1: Oppsett](01-setup/)**

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

## 📝 Notater

Bruk dette området for egne notater under workshopen:

```
<!-- Dine notater her -->
```
