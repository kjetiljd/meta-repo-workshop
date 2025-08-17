# Meta-Repository Pattern
## Orkestrering av multi-repo arkitekturer

JavaZone 2025

<small>[Ditt navn] - [@din-twitter]</small>

Note:
- Velkommen til workshop om meta-repositories
- 2 timer sammen
- Praktisk tilnærming

---

## 📋 Agenda

- **30 min** - Introduksjon og teori
- **75 min** - Hands-on oppgaver
- **15 min** - Oppsummering og Q&A

Note:
- Mye praktisk arbeid
- Spør underveis!

---

## 🎯 Læringsmål

- Forstå meta-repository pattern
- Implementere orkestrering av flere repositories
- Automatisere vanlige oppgaver på tvers av repos
- Best practices for multi-repo arkitekturer

---

## Hvem er jeg?

- [Din bakgrunn]
- [Din erfaring med temaet]
- [Kontaktinfo]

Note:
- Presenter deg selv kort
- Bygg kredibilitet

---

# Del 1: Problemet

--

## Multi-repository kaos

```
company-repos/
├── service-a/
├── service-b/
├── service-c/
├── library-x/
├── library-y/
└── frontend-app/
```

Hvordan holder vi dette synkronisert? 🤔

Note:
- Typisk microservices-oppsett
- Hver service sitt repo
- Utfordringer med koordinering

--

## Utfordringer

- 🔄 Versjonssynkronisering
- 📦 Avhengighetshåndtering
- 🚀 Koordinerte deployments
- 🔧 Konsistent konfigurasjon
- 📝 Dokumentasjon spredt utover

Note:
- Kjente problemer?
- Hvem har opplevd dette?

--

## Dagens løsninger

<div class="two-column">
<div class="column">

### Monorepo
✅ Alt på ett sted  
✅ Atomiske endringer  
❌ Skalerer dårlig  
❌ Kompleks CI/CD  

</div>
<div class="column">

### Multi-repo
✅ Uavhengig utvikling  
✅ Enkel CI/CD per repo  
❌ Koordinering vanskelig  
❌ Duplikasjon  

</div>
</div>

---

# Del 2: Meta-Repository Pattern

--

## Hva er et meta-repository?

Et **orkestreringslag** over flere repositories

```yaml
meta-repo/
├── repositories.yaml    # Definerer alle repos
├── scripts/             # Automatisering
├── templates/           # Felles templates
└── docs/               # Overordnet dokumentasjon
```

Note:
- Ikke kode, men orkestrering
- Single source of truth for arkitektur

--

## Kjernekonsepter

1. **Repository Manifest** - Definerer alle repos
2. **Orkestrering** - Koordinerte operasjoner
3. **Templates** - Standardisering
4. **Automatisering** - Scripts og workflows

--

## Repository Manifest

```yaml
repositories:
  - name: service-a
    url: git@github.com:company/service-a.git
    type: backend
    language: java
    team: platform
    
  - name: service-b
    url: git@github.com:company/service-b.git
    type: backend
    language: python
    team: payments
    
  - name: frontend-app
    url: git@github.com:company/frontend-app.git
    type: frontend
    language: typescript
    team: web
```

Note:
- Sentral oversikt
- Metadata for filtrering
- Grunnlag for automatisering

--

## Orkestrering

```bash
# Klone alle repos
./meta-repo clone --all

# Oppdatere alle backend-tjenester
./meta-repo update --filter type=backend

# Kjøre kommando på tvers
./meta-repo exec --all "git pull origin main"
```

Note:
- Kraftige kommandoer
- Filtrering og seleksjon
- Batch-operasjoner

---

# Del 3: Praktiske eksempler

--

## Eksempel 1: Koordinert oppdatering

```bash
#!/bin/bash
# Oppdater Node-versjon i alle JavaScript-prosjekter

meta-repo exec --filter language=javascript \
  "npm install --save-dev @types/node@latest"
  
meta-repo exec --filter language=javascript \
  "git add . && git commit -m 'chore: update Node types'"
  
meta-repo exec --filter language=javascript \
  "git push origin main"
```

Note:
- Ett script, mange repos
- Konsistent oppdatering
- Automatiserbar

--

## Eksempel 2: Dependency scanning

```python
# scan_dependencies.py
import yaml
import subprocess

with open('repositories.yaml') as f:
    repos = yaml.safe_load(f)['repositories']
    
for repo in repos:
    print(f"Scanning {repo['name']}...")
    subprocess.run([
        'docker', 'run', '--rm',
        '-v', f"{repo['path']}:/app",
        'aquasec/trivy', 'fs', '/app'
    ])
```

Note:
- Sikkerhetsskanning
- Sentralisert rapportering
- Compliance

--

## Eksempel 3: Release koordinering

```yaml
# release-train.yaml
release:
  version: 2.1.0
  date: 2025-02-01
  
  services:
    - name: service-a
      version: 2.1.0
      changes:
        - "New payment gateway"
        
    - name: service-b
      version: 2.0.5
      changes:
        - "Bug fixes"
        
    - name: frontend-app
      version: 2.1.0
      changes:
        - "Payment UI update"
```

Note:
- Release train konsept
- Koordinerte versjoner
- Changelog generering

---

# Del 4: Verktøy

--

## Meta-repo verktøy

- **Google's repo** - Android-prosjektet
- **git-subrepo** - Git extension
- **meta** - NPM-pakke for meta-repos
- **myrepos** - Multi-repository management
- **Custom scripts** - Skreddersydd løsning

Note:
- Mange alternativer
- Velg basert på behov
- Vi lager custom i workshopen

--

## GitHub Actions for meta-repos

```yaml
name: Sync All Repos
on:
  schedule:
    - cron: '0 6 * * 1'  # Hver mandag
    
jobs:
  sync:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Sync repositories
        run: |
          ./scripts/sync-all.sh
          
      - name: Generate report
        run: |
          ./scripts/generate-status-report.sh > status.md
          
      - name: Commit report
        run: |
          git add status.md
          git commit -m "Weekly status report"
          git push
```

Note:
- Automatisering er nøkkelen
- Scheduled workflows
- Rapportering

---

# Del 5: Best Practices

--

## Organisering

✅ **DO:**
- Hold meta-repo lett og fokusert
- Versjonér meta-repo sammen med releases
- Dokumentér arkitekturbeslutninger
- Automatiser alt som kan automatiseres

❌ **DON'T:**
- Ikke legg applikasjonskode i meta-repo
- Ikke lag for tette koblinger
- Ikke ignorer team-autonomi

Note:
- Meta-repo er et verktøy
- Ikke erstatte team-autonomi
- Balance

--

## Sikkerhet

- 🔐 Bruk SSH-nøkler eller tokens
- 🔒 Secrets i environment variables
- 👥 Tilgangskontroll per team
- 📝 Audit logging av endringer

Note:
- Sikkerhet fra starten
- Meta-repo har mye makt
- Må kontrolleres

--

## Skalering

```
meta-repos/
├── platform-meta/     # Platform team
├── payments-meta/     # Payments team
└── company-meta/      # Overordnet
    └── teams.yaml     # Refererer til team-metas
```

Note:
- Meta-repos kan nestes
- Team-autonomi bevares
- Hierarkisk struktur

---

# Workshop tid! 🚀

## La oss bygge vårt eget meta-repository system

[Start med oppgave 1 →](../workshop/01-setup/)

Note:
- Nå blir det hands-on
- Følg oppgavene i workshop-mappen
- Jeg hjelper underveis

---

## Ressurser

- 📚 [Meta-repository pattern artikkel](https://example.com)
- 🔧 [Google repo tool](https://gerrit.googlesource.com/git-repo/)
- 📖 [Monorepo vs Polyrepo](https://example.com)
- 💬 Slack: #meta-repo-workshop

---

# Spørsmål?

<br>

### Kontakt
- Email: [din-email]
- GitHub: [@din-github]
- Twitter: [@din-twitter]

<br>

**Takk for deltakelsen!** 🙏
