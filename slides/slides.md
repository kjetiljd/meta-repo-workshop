Mono-repo eller mange repo? 
# Prøv meta-repo!
## Workshop

JavaZone 2025

<small>Kjetil Jørgensen-Dahl - Telenor</small>

Note:
- Velkommen til workshop om meta-repositories
- 2 timer sammen
- En ganske praktisk tilnærming

--

## 📋 Agenda

- **15 min** - Introduksjon
- **45 min** - Hands-on oppgaver 
- **25 min** - Demo og inspirasjon
- **25 min** - Hands-on oppgaver
- **10 min** - Oppsummering og avslutning

Note:
- Mye praktisk arbeid
- Spør underveis!

--

## 🎯 Læringsmål

- Forstå meta-repo og `meta`
- Sette opp og bruke et meta-repo
- Hvordan forenkle arbeid med mange repositories
- Nye muligheter med meta-repo

--

## Hvem er jeg?

- 25+ år som utvikler 
- Interessert i _utvikleropplevelsen_
- Mange år som konsulent, så noen år i NAV
- Nå jobber jeg i Telenor

Note:
- Jeg er Kjetil Jørgensen-Dahl
- Utvikleropplevelsen
  - Jeg liker å være "i sonen", i flyt, alene, eller helst sammen med andre
  - Da er det viktig at ting fungerer, at det er enkelt å jobbe
  - Så jeg liker å kunne kjøre ting lokalt på maskinen (fordi man ikke stoppes av avhengigheter til sentrale systemer, nettverk osv)
  - Jeg liker også at vi har en viss orden i ting så vi ikke må bruke dyrebar tankekraft å prøve å huske hvordan man gjør ting i det ene eller det andre repoet
- Jobbet i mange team, og mange forskjellige oppsett
 - Jobbet i team med mange git-repositories


---

# Del 1: Problemet

--

## Mange repo er vanlig

![mangerepo-undersokelse.png](images/mangerepo-undersokelse.png)

Note:
- Jeg spurte en del team hos NAV om hvor mange repo de hadde ansvar for
- Som dere ser, så er det noen som har få, men de fleste har gankse mange
- Jeg tenker jo at når man bikker over 10 repo, så begynner det å bli litt mye å holde styr på
- Og her ser dere at mange har mer enn 20, og opp til over 100 repo

--

## Hvorfor mange repo?

- 🏰 Arkitektur: Microservices, frontends/backends <!-- .element: class="fragment" -->
- 🛠️ Verktøykassen: Dårlig støtte for monorepo <!-- .element: class="fragment" -->
- 🛠️ Fleksibilitet: Kan bruke ulike teknologier <!-- .element: class="fragment" -->
- 🏗️ Deploy: Uavhengig deploy <!-- .element: class="fragment" -->
- 🧠 Kognitiv last: Enklere å resonnere om et lite repo <!-- .element: class="fragment" -->
- 👨‍💼 Eierskap: Enklere å unngå delt eierskap <!-- .element: class="fragment" -->

Note:
Vi kunne jo tenkt oss at vi lagde en monolitt f eks

- 🏰 Arkitektur: Monolittene er vanskelige, det blir fort spaghetti og vrient å splitte 
  - Typisk microservices-oppsett
  - Hver service sitt repo
  - Utfordringer med koordinering
- 🛠️ Verktøykassen: Dårlig støtte for monorepo med verktøyene vi har/kan
- 🛠️ Fleksibilitet: Java i backend og React i frontend
- 🏗️ Deploy: Uavhengig deploy betyr raskere feedback
- 🧠 Kognitiv last: Enklere å resonnere om endringer i et lite repo
- 👨‍💼 Eierskap: Mindre risiko for delte repo på tvers av team, letter å flytte også

--

## Fra et repo eller to ...

service-a

frontend-app-1

service-b <!-- .element: class="fragment" data-fragment-index="1" -->

service-c <!-- .element: class="fragment" data-fragment-index="1" -->

ioc <!-- .element: class="fragment" data-fragment-index="2" -->

library-x <!-- .element: class="fragment" data-fragment-index="3" -->

frontend-app-2 <!-- .element: class="fragment" data-fragment-index="4" -->

service-d <!-- .element: class="fragment" data-fragment-index="4" -->

library-y <!-- .element: class="fragment" data-fragment-index="4" -->

osv...<!-- .element: class="fragment" data-fragment-index="5" -->

Note:
... men det stopper jo gjerne ikke der.
Jeg har vært i team med så mange repo at man må inn å lese README for å huske hva det handlet om.
Og i team der det har vært så mye omskiftinger at man er usikre på hvilke repo man eier. Det skal bare én omorganisering til ...

--

## Multi-repo

```text
repos
├── frontend-app-1
├── frontend-app-2
├── service–a
├── service–b
├── service-c
├── library-x
├── library-y
├── library-z
└── ioc
```

Note:
Ofte sitter utviklere med noen, eller mange, repo sjekket ut lokalt på maskinen.
Men kanskje ikke *alle* teamet sine, og kanskje noen repo som ikke tilhører teamet.
(service-d er ikke med, library-z er et annet team sitt)

--

## Hva er utfordringene med å ha mange repo?

- 👷 Duplisering av vedlikehold <!-- .element: class="fragment" -->
- 📦 Bygge og deploy-script-duplisering <!-- .element: class="fragment" -->
- 🚀 Tungt å oppdatere på tvers av repos <!-- .element: class="fragment" -->
- 🔄 Versjonssynkronisering <!-- .element: class="fragment" -->
- 🔍 Fragmentert oversikt <!-- .element: class="fragment" -->
- 🔀 Ulike konvensjoner dukker opp <!-- .element: class="fragment" -->
- 🔧 Forbedringer i ett repo blir ikke delt <!-- .element: class="fragment" -->
- 📝 Ikke noe naturlig sted å ha felles dokumentasjon <!-- .element: class="fragment" -->

Note:
- Kjente problemer?
- Hvem har opplevd dette?
- Og så er det jo ikke slik at det ikke finnes løsninger på mye av dette ...
- ... ofte handler det om å lage enda et repo, for eksempel et med felles deployscript.
- Men det finnes ikke én god løsning på alt dette.
- Kanskje med unntak av mono-repo, men det har ulemper som vi var innom.
- 

--

## To løsninger

<div class="two-column">
<div class="column">

### Mange repo

✅ Uavhengig utvikling

✅ Enkel CI/CD per repo

❌ Koordinering vanskelig

❌ Duplisering

</div><!-- .element: class="fragment" data-fragment-index="1" -->
<div class="column">

### Mono-repo

✅ Alt på ett sted

✅ Atomiske endringer

❌ Kompleks CI/CD

❌ Krever andre verktøy

</div><!-- .element: class="fragment" data-fragment-index="2" -->
</div>

--

## Hva gjør folk for å håndtere mange repo?

- 🚫Ingenting (veldig vanlig!) <!-- .element: class="fragment" -->
- 📚Skiller ut bibliotek eller rammeverk i egne repo <!-- .element: class="fragment" -->
- 👷‍♀️Bygg/deploy i egne repo <!-- .element: class="fragment" -->
- 💲Kommandolinjen til å gjøre ting på tvers <!-- .element: class="fragment" -->
- ䷝ Team-CLI for å gjøre ting på tvers <!-- .element: class="fragment" -->
- 📐Template-repo <!-- .element: class="fragment" -->
- 🤘Meta-repo! <!-- .element: class="fragment" -->

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
