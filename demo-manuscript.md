# Demo Manuskript - Meta-Repository Workshop

## Demo 1: Real-world Meta-repo Introduksjon
**Slide:** "Eksempler på meta-prosjekter" (Del 2)

### Bakgrunnshistorie (2-3 minutter)
- "Jeg vil vise dere et ekte meta-repo som jeg har jobbet med"
- "Dette er fra NAV, eessi-pensjon-teamet"
- "Jeg jobbet i dette teamet i en periode for et par år siden"
- "EESSI står for Electronic Exchange of Social Security Information"
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

1. **Vis meta exec**

```bash
meta exec pwd
```
- "Kjører samme kommando i hvert repository"
- "Se hvordan den bytter mellom mapper og viser hvor den er"
- Den kjører også selve meta-repoet

Eller :

```bash
meta exec "git branch --show-current"
```
- Legg merke til at jeg bruker dobbeltfnutter når det er en kommando med mellomrom i seg
- "Viser hvilken branch hvert repo er på - nyttig for å se status"

2. **Vis meta git status**

```bash
meta git status
```

- "Dette viser git status for ALLE repositories på en gang"
- Påpek forskjellige tilstander på tvers av repos

3. **Vis filtrering (hvis tilgjengelig)**

```bash
meta exec "git log --oneline -1" --exclude eessi-pensjon
```
- "Du kan ekskludere spesifikke repo fra kommandoer"


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
   
   # Se automatiseringen
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

## Demo 4: Git Historikk Analyse - Hvilke filer endres oftest?

**Når:** Etter oppgave 4 (Automatisering) og git-history workshop-oppgave  
**Varighet:** 3-4 minutter
**Mål:** Vise hvordan meta kan hjelpe med å analysere git-historikk på tvers av repositories

### Kontekst
"Dere har nettopp laget en 'hotspots' kommando selv. La meg vise dere hvordan samme teknikk ser ut med et ekte system som eessi-pensjon."

### Live Demo

```bash
# Gå til eessi-pensjon meta-repo
cd ../../navikt/eessi-pensjon

# Se hvilke filer som har flest commits
echo "La oss se hvilke filer som endres oftest på tvers av alle repositories:"
meta exec "git log --name-only --pretty=format: | grep -Ev '^$' | sort | uniq -c | sort -rn | head -5"

# Forventet resultat basert på ekte data:
# /Users/t988833/Projects/navikt/eessi-pensjon:
#   33 Makefile
#   27 settings.gradle
#   24 templates/buildSrc/ep-module.gradle
#   21 docs/adr/0003-Utviklingshastighet.md
#   18 templates/src/main/kotlin/no/nav/eessi/pensjon/shared/person/Fodselsnummer.kt
#
# eessi-pensjon-fagmodul:
# 1281 build.gradle
#  378 VERSION
#  200 src/main/kotlin/no/nav/eessi/pensjon/fagmodul/api/SedController.kt
#  185 src/main/kotlin/no/nav/eessi/pensjon/fagmodul/api/BucController.kt
#  125 src/main/kotlin/no/nav/eessi/pensjon/fagmodul/eux/EuxInnhentingService.kt

# Diskuter resultatet
echo "Wow! Se på tallene - build.gradle har 1281 commits, VERSION-filer 378 commits!"
echo "Og SedController.kt med 200 commits - der skjer det mye utvikling..."

# Se på produksjonskode uten gradle-config (siste 3 måneder)
echo "La oss filtrere bort gradle-filer og se på ekte kode-hotspots:"
meta exec "git log --name-only --pretty=format: --since='3 months ago' | grep -v 'gradle' | grep -Ev '^$' | sort | uniq -c | sort -rn | head -5"

# Se på filhistorikken for en spesifikk fil
echo "Hvis vi lurer på hvorfor en fil endres ofte, kan vi se commit-historikken:"
echo "La oss se på PensjonsinformasjonUtlandController.kt i fagmodul:"
cd eessi-pensjon-fagmodul && git log --oneline -- src/main/kotlin/no/nav/eessi/pensjon/fagmodul/pesys/PensjonsinformasjonUtlandController.kt && cd -
```

### Talking Points
- **"Dette kalles 'code hotspots' - områder som endres ofte kan være tegn på problemer"**
- **"1281 commits i build.gradle! Det forteller oss hvor mye maintenance-arbeid som skjer"**
- **"SedController med 200 commits - der foregår mye utvikling og endringer"**
- **"VERSION-filer med 378 commits viser hyppige releases"**  
- **"Se hvordan vi enkelt kan 'drill down' fra hotspots til spesifikke commit-historikk"**
- **"Dette hjelper oss forstå HVORFOR en fil endres ofte - feature utvikling vs bugfixes"**
- **"Med meta får vi umiddelbart oversikt på tvers av 15+ repositories"**

### Hva vises
- Liste over mest endrede filer på tvers av alle microservices
- Tidsfiltert analyse (siste 3 måneder)
- Filtrert analyse som fokuserer på produksjonskode
- Diskusjon av hva tallene forteller oss om kodebasen

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

## Demo 6: Template-system - Java version oppgradering

**Når:** Etter templates slides
**Varighet:** 4-5 minutter  
**Mål:** Vise praktisk template-system i action med ekte eessi-pensjon eksempel

### Kontekst
"Nå skal jeg vise dere template-systemet i praksis med et ekte eksempel fra eessi-pensjon. Vi skal oppgradere Java-versjon fra 21.0.4 til 21.0.8 på tvers av alle repositories med én kommando."

### Live Demo

```bash
# Gå til eessi-pensjon meta-repo
cd ../../navikt/eessi-pensjon

# 1. Vis template-strukturen
echo "Først - la oss se på template-strukturen:"
ls templates/
ls templates/.github/workflows/

# 2. Finn hvor Java-versjon er definert
echo "La oss finne hvor Java 21.0.4 er definert i templates:"
grep -r "21\.0\.4" templates/

# Forventet resultat:
# templates/.github/workflows/release_mainline.yml:35:          java-version: 21.0.4
# templates/.github/workflows/bygg_mainline_og_deploy_q1.yml:30:          java-version: 21.0.4
# templates/.github/workflows/bygg_branch_og_publiser.yml:32:          java-version: 21.0.4
# templates/.github/workflows/bygg_mainline_og_deploy.yml:30:          java-version: 21.0.4
# templates/.github/workflows/bygg_branch.yml:31:          java-version: 21.0.4

echo "Se der! Java 21.0.4 er brukt i 5 forskjellige workflow-templates"

# 3. Vis en av template-filene
echo "La oss se på én av template-filene:"
head -40 templates/.github/workflows/bygg_branch.yml

# 4. Vis template-data strukturen  
echo "Og her er template-data for hvert repo:"
ls template-data/ | head -5
echo "... og mange flere"

# 5. Utfør oppgraderingen
echo "Nå oppgraderer vi fra 21.0.4 til 21.0.8 i alle templates:"
sed -i 's/21\.0\.4/21.0.8/g' templates/.github/workflows/*.yml

echo "Sjekk at endringen ble gjort:"
grep -r "21\.0\.8" templates/ | head -3

# 6. Se hvilke filer som ble endret
echo "Git viser oss hvilke template-filer som ble endret:"
git diff --name-only templates/

# 7. Generer filer til alle repos
echo "Nå distribuerer vi templates til alle repositories:"
make generate-files

# Dette vil kjøre gjennom alle repos og oppdatere workflow-filene
# Forventet output: "Generating .github/workflows/bygg_branch.yml ... CHANGED!" osv

# 8. Se resultatet i ett av sub-repoene
echo "La oss sjekke at det fungerte - se i en av sub-repoene:"
cd eessi-pensjon-fagmodul
git status
git diff .github/workflows/bygg_branch.yml
cd ..

# 9. Vis hvor mange repos som ble påvirket  
echo "La oss se hvor mange repos som ble påvirket:"
meta exec "git status --porcelain | grep '.github/workflows'" | wc -l

echo "Så mange repos fikk oppdatert Java-versjon med én kommando!"
```

### Talking Points
- **"Dette er template-systemet i praksis på et ekte prosjekt"**
- **"Én sed-kommando endrer Java-versjon i alle 5 workflow-templates"**  
- **"make generate-files distribuerer endringene til 15+ repositories"**
- **"Se hvordan git diff viser nøyaktig hvilke filer som ble endret i hvert repo"**
- **"Fra 21.0.4 til 21.0.8 på tvers av hele økosystemet på under ett minutt"**
- **"Samme teknikk kan brukes for Docker base images, dependency-versjoner, osv"**
- **"Dette sparer timer med manuelt arbeid og eliminerer glemte repositories"**

### Oppfølging
- "Hvis vi ville committed dette, kunne vi kjørt `meta git add -A && meta git commit -m 'Upgrade Java to 21.0.8'`"
- "I praksis ville dette gå gjennom code review prosess"
- "Template-systemet sikrer at alle repos holder seg konsistente"

---

## Demo 7: Analyse på tvers av Repositories
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

