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
Hm... det fungerer ikke, og ergerlig nok får vi ingen tilbakemelding på at kommandoen ikke finnes.

I stedet må vi gjøre slik (enklere uten paging)
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
# "$(basename $PWD)" er det samme som: todo-meta
# ... men fungerer uansett hva mappen heter (inkludert i Docker-containeren der mappen heter /work)
```
Dette kjører kommandoen kun i sub-repoene, ikke i meta-repoet.

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
Legg merke til at når du bruker `--parallel` så får du ingen output før kjøringen i sub-repoet er fullført.
Om du kjører flere ganger vil du se at rekkefølgen på output kan variere når du kjører parallelt, ettersom responsen kommer når hver enkelt er ferdig.

En annen ting å merke seg er bruken av enkeltfnutter (`'`) rundt hele kommandoen. 

Her legger vi på en echo for å vise hvilket tall som genereres:

```shell
meta exec 'echo start ; echo sleep $((RANDOM % 5 + 1)) ; echo end' --parallel
```

La oss nå kjøre samme kommando, men med dobbelfnutter (`"`) rundt hele kommandoen:
```shell
meta exec "echo start ; echo sleep $((RANDOM % 5 + 1)) ; echo end" --parallel
```

Denne gangen er alle verdiene like, fordi `$((RANDOM % 5 + 1))` blir evaluert av shellet ditt (f.eks bash/zsh) før `meta exec` kjøres. 
Dermed får alle repoene samme tilfeldige tall.

Prøv nå å scapee `$`-tegnet med `\`, fortsatt med dobbelfnutter:
```shell
meta exec "echo start ; echo sleep \$((RANDOM % 5 + 1)) ; echo end" --parallel
```


### Steg 5: Kodestatistikk med cloc

Bruk `cloc` (Count Lines of Code) for å få oversikt over kodebasen:

```shell
meta exec "cloc . --vcs=git"
```


Dette gir deg statistikk over antall linjer kode per språk i hvert repo.

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

## 🎯 Ekstra-oppgaver

Løs disse oppgavene med `meta exec`.

1. **Finn alle TODO-kommentarer**: Bruk `grep` for å finne TODO-kommentarer på tvers av alle repoer
2. **Git branch status**: Se hvilken branch hvert repo er på
3. **Size analysis**: Finn de største filene i hvert repo
4. **Sjekk dependencies**: List opp alle package.json dependencies

<details markdown="1">
  <summary>1</summary>
<hr/>

```shell
meta exec 'git grep -n "TODO" || echo "No TODOs found"'"
```
Legg merke til bruken av `git grep` for å unngå filer som er i `.gitgnore`. `|| echo ...` hindrer at vi får en feilmelding når vi ikke finner noe.
<hr/>
</details>

<details markdown="1">
  <summary>2</summary>
<hr/>

```shell
meta exec 'git branch --show-current' --exclude "$(basename $PWD)"
```

<hr/>
</details>

<details markdown="1">
  <summary>3</summary>
<hr/>

```shell
meta exec 'du -ah . | sort -hr | head -5' --exclude "$(basename $PWD)"
```

<hr/>
</details>

<details markdown="1">
  <summary>4</summary>
<hr/>

```shell
meta exec 'if [ -f package.json ]; then echo "=== $(pwd) ===" && cat package.json | jq -r ".dependencies // {} | keys[]" 2>/dev/null || grep -o "\"[^\"]*\":" package.json | grep -v "devDependencies\|scripts\|name\|version"; fi' --exclude "$(basename $PWD)"
```

<hr/>
</details>

## 💡 Tips

- Bruk `--parallel` for raskere utførelse på store meta-repoer
- Kombiner med shell-scripting for kraftige workflows
- Husk anførselstegn rundt kommandoer
- Test kommandoer på et enkelt repo først

**[← Tilbake til oversikt](../)** | **[→ Neste oppgave: Automatisering](../04-automation/)**