# Demo Manuskript - Meta-Repository Workshop

## Demo 1: Real-world Meta-repo Introduksjon
**Slide:** "Eksempler på meta-prosjekter" (Del 2)

### Bakgrunnshistorie (2-3 minutter)
- "Jeg vil vise dere et ekte meta-repo som jeg har jobbet med"
- "Dette er fra NAV, eessi-pensjon-teamet"
- "Jeg jobbet i dette teamet i [X måneder/år] for et par år siden"
- "EESSI står for European Electronic Exchange of Social Security Information"
- "Systemet håndterer pensjonsdatautveksling mellom europeiske land"
- "Komplekst domene med mange deler - perfekt kandidat for meta-repo"

### Demo-punkter
1. **Vis meta-repo strukturen**
   - Naviger til https://github.com/navikt/eessi-pensjon
   - Vis .meta-filen
   - Påpek antall repositories (tell dem)
   - "Dette teamet administrerer X forskjellige repositories som ett sammenhengende system"

2. **Forklar repositories**
   - Blanding av backend-tjenester, frontends, biblioteker
   - Forskjellige teknologier (Java, Kotlin, JavaScript)
   - "Hvert repo kan utvikles uavhengig, men de jobber sammen"

3. **Vis .gitignore**
   - "Legg merke til hvordan alle sub-repo-mappene er ignorert"
   - "Meta-repoet sporer bare koordineringen, ikke selve koden"

### Overgang
- "Gjennom denne workshopen vil jeg bruke dette som et ekte eksempel"
- "Dere vil se hvordan et ekte team bruker meta-repo i praksis"

---

## Demo 2: Meta-kommandoer i Praksis
**Slide:** Etter hands-on øvelser (Del 3)

### Setup-kommandoer
```bash
# Prosjektet er allerede klonet og klart
cd eessi-pensjon
```

### Demo-punkter
1. **Vis meta git status**
   ```bash
   meta git status
   ```
   - "Dette viser git status for ALLE repositories på en gang"
   - Påpek forskjellige tilstander på tvers av repos

2. **Vis meta exec**
   ```bash
   meta exec "pwd"
   ```
   - "Kjører samme kommando i hvert repository"
   - "Se hvordan den bytter mellom mapper og viser hvor den er"
   
   Eller som alternativ:
   ```bash
   meta exec "git branch --show-current"
   ```
   - "Viser hvilken branch hvert repo er på - nyttig for å se status"

3. **Vis filtrering (hvis tilgjengelig)**
   ```bash
   meta exec "git log --oneline -1" --exclude eessi-pensjon 
   ```
   - "Du kan ekskludere spesifikke repositories fra kommandoer"

### Nøkkelbeskjeder
- "Én kommando påvirker flere repositories"
- "Sparer tid"

---

## Demo 3: Automatisering i Praksis
**Slide:** Under make/automatisering-seksjonen (Del 4)

### Vis Eksisterende Automatisering
1. **Vis Makefile**
   ```bash
   make help
   ```
   - "Se her - dette teamet har 28+ forskjellige kommandoer!"
   - "Dette er ekte automatisering bygget på meta"

2. **Vis konkrete eksempler**
   ```bash
   # Vis pull-kommandoen
   grep -A 2 "pull:" Makefile
   # Vis build-kommandoen  
   grep -A 2 "build:" Makefile
   ```

3. **Vis og kjør gradle-oppgradering**
   ```bash
   # Først - se nåværende versjon
   meta exec "./gradlew --version | grep Gradle"
   
   # Se automaseringen
   grep -A 2 "upgrade-gradle:" Makefile
   cat script/upgrade_gradle.sh
   
   # Se Java-versjon (relevant for Gradle)
   meta exec "cat .java-version"
   
   # Kjør oppgraderingen!
   GRADLEW_VERSION=8.14.3 make upgrade-gradle
   ```
   - "Se hvordan den oppdaterer Gradle i alle 20+ repositories"
   - "Dette er kjedelig å gjøre manuelt"

### Diskusjonspunkter
- "Dette teamet har automatisert forskjellige ting - fra enkle git-operasjoner til komplekse dependency-oppdateringer"
- "Nye teammedlemmer trenger bare å lære make-kommandoene, ikke interne detaljer"
- "Se hvor ryddig alt er dokumentert med ## kommentarer"
- "Dette er hvor det blir kraftfullt - tenk på repetitive tasks dere har"
- "Så kan man kanskje si at dette kan løses med Dependabot? Ja, men det blir fort mye dependabot PRs å håndtere manuelt"
- "Og det er ikke alle oppgaver som kan automatiseres med Dependabot"

---

## Demo 4: Analyse på tvers av Repositories
**Slide:** Under avanserte emner eller oppsummering

### Analytiske Kommandoer
1. **Spring Boot versjoner**
   ```bash
   meta exec "./gradlew dependencies | grep 'spring-boot:' | head -1" --exclude eessi-pensjon --parallel
   ```
   - "Se her - de fleste er på Spring Boot 3.5.5, men noen er fortsatt på 3.5.4"
   - "Dette ville tatt lang tid å sjekke manuelt i hvert repo"
   - "Nå ser vi umiddelbart hvor det trengs oppdateringer"
   - "Legg merke til at noen repos ikke har gradlew (UI og meta-analyse) - det er ok"

2. **Kodestatistikk**
   ```bash
   # Først - vis for ett repo
   cd eessi-pensjon-fagmodul
   cloc . --vcs=git
   cloc . --vcs=git --exclude-lang=JSON
   
   # Så - vis for alle repos
   cd ..
   meta exec "cloc --vcs=git --exclude-lang=JSON --quiet . 2>/dev/null" --exclude eessi-pensjon
   ```
   - "Først ser vi ett repo, så alle på en gang"
   - "Med --vcs=git får vi bare koden som er i git, ikke node_modules osv"
   - "Se hvordan vi får total oversikt over hele systemet"

3. **Avansert analyse med egen verktøy**
   ```bash
   cd ep-meta-analyse
   ./changes.py
   cd ..
   ```
   - "Dette teamet har laget sitt eget analyseverktøy!"
   - "Analyserer endringer på tvers av alle repositories siste uke"
   - "Kategoriserer etter risiko, type endring (features, bugfix, refactoring)"
   - "For å få kategoriseringen bruker teamet en git-notasjon som heter Arlo's Commit Notation"
   - "Dette er interessant bruk av meta-repo"
   - "Det er nærliggende å tenke at dette er et bra underlag for release notes også"

4. **Tertial-rapporter**
   ```bash
   ls -la ep-meta-analyse/archive/
   # Åpne den siste rapporten
   open ep-meta-analyse/archive/2025T2_2025-08-29_Utviklingsstatistikk.pdf
   ```
   - "Teamet har tatt det enda lenger"
   - "De genererer rapporter hvert tertial om utviklingen i alle systemene"  
   - "Dette gir ledelsen innsikt i hvor mye som skjer på tvers av hele økosystemet"
   - "Her er rapporten fra 2025 T2: https://github.com/navikt/eessi-pensjon/blob/main/ep-meta-analyse/archive/2025T2_2025-08-29_Utviklingsstatistikk.pdf"

### Nøkkelbeskjeder
- "Meta-repos gjør systemomfattende analyse mulig"
- "Få innsikt på tvers av hele økosystemet ditt"
- "Perfekt for teknisk gjeldshåndtering"

---

## Demo 5: IDE-integrasjon (hvis tid tillater)
**Slide:** IDE-integrasjon seksjon (Del 6)

### Vis Utviklingsopplevelsen
- "La meg vise dere hvordan dette ser ut i IntelliJ i eessi-pensjon"
- Demonstrer enhetlig søk
  - P_BUC_06 
    - Finnes mange steder i ulike repo ...
    - Men det er lett å finne med IDE-søk
    - Og vi kan finne absolutt alle stedene i koden
  - Søk etter "FROM " i Dockerfile
    - En med node, resten på samme basebilde
- "Jeg har allerede eessi-pensjon åpent her som et Gradle Composite Build"
- Vis navigering på tvers av repositories (Project og Package view)
  - Vis config-pakka og KafkaStoppingErrorHandler
  - Jeg husker at disse var ganske forskjellige i ulike repo
    - Trolig burde dette være en delt library
    - Men samtidig er det én fil ...
  - Tilbake i project view
    - Vis at det finens bibliotetek-repo også
  - Vis Github Action-view - vis at det ser *veldig* likt ut
    - Ingen diff! ... mystisk
- Vis hvordan alle sub-prosjektene vises i samme workspace

### Nøkkelbeskjeder
- "IDE-et ditt behandler det som ett stort prosjekt"
- "Refaktorering på tvers av repositories blir mulig"
- "Utviklingsopplevelse lik monorepo"

---

## Generelle Demo-tips

### Før Hver Demo
- [ ] Sjekk internettforbindelse  
- [ ] Ha terminal åpent i eessi-pensjon-mappen
- [ ] Ha IntelliJ åpent med eessi-pensjon (fra Del 6)
- [ ] Tøm terminalhistorikk hvis nødvendig
- [ ] Sjekk at skriftstørrelse er lesbar for publikum

### Under Demos
- Snakk mens du skriver
- Forklar hva du forventer å se før du kjører kommandoer
- Ikke bekymre deg for mindre feil - de gjør det autentisk
- Hold demoer korte (maks 2-3 minutter hver)
- Spør "Kan alle se dette?" regelmessig

### Gjenopprettingsplaner
- **Hvis kommandoer er trege:** Ha skjermbilder klare
- **Hvis spesifikt repo er utilgjengelig:** Bytt til backup-eksempler

### Tidspunkter
- Demo 1: 3 minutter
- Demo 2: 4 minutter  
- Demo 3: 3 minutter
- Demo 4: 3 minutter
- Demo 5: 2 minutter (valgfritt)
- **Totalt: 15 minutter med demos**

---

## Backup-eksempler
Hvis eessi-pensjon blir utilgjengelig, bruk disse alternativene:
- https://github.com/navikt/pia-hub
- https://github.com/opensearch-project/opensearch-plugins (plugins-mappen)
- Ditt eget demo meta-repo med enkle eksempler