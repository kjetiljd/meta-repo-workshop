# Oppgave 3: Kommandoer med meta exec

## 📋 Mål

I denne oppgaven skal du:
- Lære hvordan `meta exec` fungerer
- Prøve andre kommandoer på tvers av repo
- Bruke filtrering med `--exclude`
- Utforske `--parallel` 
- Bruke pipeline og betingelser for selektiv kjøring

## 📚 Bakgrunn

`meta exec` lar deg kjøre vilkårlige kommandoer på tvers av alle repoer i meta-repoet ditt. Dette kan spare deg for mye tid når du skal gjøre endringer eller samle informasjon fra flere repositories.

## 🛠 Steg-for-steg

### Steg 1: Grunnleggende meta exec

Først, kjør en enkel kommando på tvers av alle repoer:

```shell
meta exec pwd
```
Du vil se at kommandoen kjøres i hvert repo, inkludert meta-repoet selv.

### Steg 2: git-log kommandoer

Vi har allerede sett `meta git status`. La oss prøve noen flere nyttige git-kommandoer.

#### git log

```shell
meta git log
```
Hm... det fungerer ikke, og ergerlig nok får vi *ingen tilbakemelding på at kommandoen ikke finnes*.

I stedet må vi gjøre slik (enklere uten paging):

```shell
meta exec "git --no-pager log"
```
Det gir jo veldig mye output, så la oss begrense det til de 3 siste commitene, og i kortformat:
```shell
meta exec "git log --oneline -3"
```

#### Git shortlog for å se bidragsytere

```shell
meta exec "git shortlog -sn"
```
Dette viser hvem som har bidratt til hvert repo, sortert etter antall commits (gjeldende branch).

### Steg 3: Filtering - ekskluder meta-repoet

Ofte vil du utelate selve meta-repoet. Bruk filtrering med `--exclude`:

```shell
meta exec "git log --oneline -1" --exclude "$(basename $PWD)" 
```
Dette kjører kommandoen kun i sub-repoene, ikke i meta-repoet.

`$(basename $PWD)` er det samme som: todo-meta
 ... men fungerer uansett hva meta-repo-mappen heter (inkludert i Docker-containeren der mappen heter /work)


Du kan ekskludere flere repoer ved å liste dem med komma:

```shell
meta exec "git log --oneline -1" --exclude todo-backend,todo-frontend
```

### Steg 4: Parallel kjøring

Prøv denne kommandoen som simulerer at hver oppgave tar fra 1 til 5 sekunder:
```shell
meta exec 'echo start ; sleep $((RANDOM % 5 + 1)) ; echo end'
```

For å bli fortere ferdig legg på `--parallel`:
```shell
meta exec 'echo start ; sleep $((RANDOM % 5 + 1)) ; echo end' --parallel
```
Legg merke til at når du bruker `--parallel` så får du ingen output før kjøringen i sub-repoet er ferdig.

Om du kjører flere ganger vil du se at rekkefølgen på output kan variere når du kjører parallelt, ettersom responsen kommer etterhvert som alt er gjort i hvert enkelt sub-repo.

### Forstå variabler og anførselstegn (fnutter) 

__Denne seksjonen kan variere etter hvilket shell du bruker, har testet med bash og zsh.__

En annen ting å merke seg er bruken av enkeltfnutter (`'`) rundt hele kommandoen. 

Her legger vi på en echo for å vise hvilket tall som genereresi stedet for å vente:

```shell
meta exec 'echo start ; echo sleep $((RANDOM % 5 + 1)) ; echo end' --parallel
```

La oss nå kjøre samme kommando, men med dobbelfnutter (`"`) rundt hele kommandoen:
```shell
meta exec "echo start ; echo sleep $((RANDOM % 5 + 1)) ; echo end" --parallel
```

Denne gangen er alle verdiene like, fordi `$((RANDOM % 5 + 1))` blir evaluert av shellet ditt (f.eks bash/zsh) før `meta exec` kjøres. 
Dermed får alle repoene samme tilfeldige tall.

Prøv nå å escape `$`-tegnet med `\`, fortsatt med dobbelfnutter:
```shell
meta exec "echo start ; echo sleep \$((RANDOM % 5 + 1)) ; echo end" --parallel
```
Nå virker det igjen som forventet, og hver repo får sitt eget tilfeldige tall.

### Steg 5: Kodestatistikk med cloc

<details markdown="1">
  <summary>Installasjon av cloc – om nødvendig!</summary>

[cloc](https://github.com/AlDanial/cloc) – "Count Lines of Code" – er et populært verktøy for å telle linjer med kode i et prosjekt.

Om du ikke har `cloc` installert, så er det [rekordmange muligheter](https://github.com/AlDanial/cloc?tab=readme-ov-file#install-via-package-manager), her er noen:

<details markdown="1">
  <summary>macOS</summary>

```shell
brew install cloc
```
</details>

<details markdown="1">
  <summary>Windows</summary>

Vurdér å bruke Docker-containeren som allerede har cloc installert.

Utestede alternativer:
```powershell
# Windows Package Manager
winget install AlDanial.Cloc

# Chocolatey
choco install cloc
```
</details>
<details markdown="1">
  <summary>Linux</summary>

```shell
# Debian/Ubuntu - eller bruk din pakkebehandler
sudo apt install cloc
```
</details>
</details>

Bruk `cloc` for å få oversikt over kodebasen:

```shell
meta exec "cloc . --vcs=git" --exclude "$(basename $PWD)"
```
Dette gir deg statistikk over antall linjer kode per språk i hvert repo. 
Vi bruker `--vcs=git` for å telle kun filer som er sporet av Git (og slippe slikt som `node_modules`).

### Steg 6: Pipeline og betinget kjøring

#### Eksempel: Finn repos med Gradle

Sjekk hvilke repos som har Gradle-konfigurasjon:

```shell
meta exec 'if [ -f build.gradle* ]; then echo "$(pwd): Has Gradle"; fi' --exclude "$(basename $PWD)"
```

#### Eksempel: Finn repos med npm

```shell
meta exec 'if [ -f package.json ]; then echo "$(pwd): Has npm"; fi' --exclude "$(basename $PWD)"
```

### Steg 7: Bygg-kommandoer


#### Kjør npm test der det finnes package.json

```shell
meta exec 'if [ -f package.json ]; then npm install ; npm test; fi' --exclude "$(basename $PWD)"
```

### Steg 8: Kombinere kommandoer

Du kan kombinere flere kommandoer med `&&` eller `;`:

```shell
meta exec 'echo "--- Start ---" && git status --porcelain ; echo "--- End ---"' --parallel --exclude "$(basename $PWD)"
```
Legg merke til enkelt-fnutter (`'`) rundt hele kommandoen, og doble fnutter (`"`) inni der det trengs.

## 🎯 Ekstra-oppgaver (disse kan du komme tilbake til siden)

Løs disse oppgavene med `meta exec` - og kommandolinje-verktøy:

1. **Commit historie**: Tell antall commits i hvert repo siste 7 dager
2. **Git branch status**: Se hvilken branch hvert repo er på
3. **Finn alle TODO-kommentarer**: Bruk `grep` for å finne TODO-kommentarer på tvers av alle repoer
4. **Size analysis**: Finn de største filene i hvert repo
5. **Siste endringer**: Finn hvilke filer som ble endret sist i hvert repo

<details markdown="1">
  <summary>Løsninger</summary>

Det finnes ofte flere måter å løse slike oppgaver på. Her er noen forslag til hver oppgave:

<details markdown="1">
  <summary>1</summary>
<hr/>

```shell
meta exec 'git log --oneline --since="7 days ago" | wc -l'
```

<hr/>
</details>

<details markdown="1">
  <summary>2</summary>
<hr/>

```shell
meta exec 'git branch --show-current'
```

<hr/>
</details>

<details markdown="1">
  <summary>3</summary>
<hr/>

```shell
meta exec 'git grep -n "TODO" || echo "No TODOs found"'"
```
Legg merke til bruken av `git grep` for å unngå filer som er i `.gitgnore`. `|| echo ...` hindrer at vi får en feilmelding når vi ikke finner noe.
<hr/>
</details>


<details markdown="1">
  <summary>4</summary>
<hr/>

```shell
meta exec 'find . -type f -exec du -ah {} + | sort -hr | head -5'
```

Alternativt, for å kun vise filer som er sporet av Git:
```shell
meta exec 'git ls-files -z | xargs -0 du -ah | sort -hr | head -5'
```

<hr/>
</details>

<details markdown="1">
  <summary>5</summary>
<hr/>

```shell
meta exec 'git log --oneline --name-only -1'
```

Alternativt, for kun å vise filnavn uten commit-info:
```shell
meta exec 'git show --name-only --pretty="" HEAD'
```

<hr/>
</details>
</details>

## 💡 Tips

- Bruk `--parallel` for raskere utførelse på store meta-repoer
- Kombiner med shell-scripting for kraftige workflows
- Husk anførselstegn rundt kommandoer
- Test kommandoer på et enkelt repo først

**[← Tilbake til oversikt](../)** | **[→ Neste oppgave: Automatisering](../04-automation/)**