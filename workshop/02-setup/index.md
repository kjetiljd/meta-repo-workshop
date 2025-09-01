# Oppgave 2: Oppsett og grunnleggende struktur

## 📋 Mål

I denne oppgaven skal du:
- Starte fra et tomt repo og gjøre det til et meta-repo
- Importere repo'er inn i meta-repoet
- Kjøre noen enkle kommandoer.

## 📚 Bakgrunn

Et meta-repository fungerer som et kontrollsenter for flere Git-repositories. Det inneholder ingen applikasjonskode, men scripts og konfigurasjon for å administrere andre repos.

## 🛠 Steg-for-steg

### Steg 1: Starte fra tomt repo


Åpne terminal/kommandolinje i ditt favorittverktøy.

Deretter:

```shell
cd <something> # til der du vil opprette et repo vi skal jobbe i
```
La oss starte med å klone vårt tomme repo:

```shell
git clone https://github.com/kjetiljd/todo-meta.git
```

### Steg 2: Opprette meta-repo

Gå inn i prosjekt-mappen:

```shell
cd todo-meta
```

Det kan se tomt ut her:

```shell
ls 
```

Men det er et git-repo:

```shell
ls -al 
```
På Mac/Linux skjules filer som starter med `.` så vi trenger `-a` for å vise at det har dukket opp en `.meta`-fil.

Repoet er ikke _helt_ tomt, det finnes noen branch'er vi kan bruke hvis ting går galt.

*Dersom du velger å bruke Docker* er det nå du starter Docker-containeren og jobber videre inne i den:
<details markdown="1">
  <summary>Ekspander for Docker-container-instruksjon</summary>
<hr/>
Start container slik (denne gang tar vi med git name/email):

Windows (powershell):
```powershell
$gitUserName = try { git config user.name } catch { "" }
$gitUserEmail = try { git config user.email } catch { "" }

docker run --rm -it `
  -v "$($PWD.Path):/work" -w /work `
  -e "GIT_USER_NAME=$gitUserName" `
  -e "GIT_USER_EMAIL=$gitUserEmail" `
  ghcr.io/kjetiljd/meta-repo-workshop-tools:latest bash
```

Mac/Linux/...:
```shell
docker run --rm -it \
  -v "$PWD:/work" -w /work \
  -e "GIT_USER_NAME=$(git config user.name || echo '')" \
  -e "GIT_USER_EMAIL=$(git config user.email || echo '')" \
  ghcr.io/kjetiljd/meta-repo-workshop-tools:latest bash

```

Merk at inne i Docker-containeren heter mappen `/work`, ikke `todo-meta`.

<hr/>
</details>


Gjør mappen til et meta-prosjekt slik:

```shell
meta init
```
Nå ble det opprettet en `.meta`-fil.

```shell
ls -al
```
La oss titte på den.

```shell
cat .meta # eller tilsvarende kommando for å se innhold i filer
```
Det ser ut som om dette er JSON.

### Steg 3: Legge til sub-repo

Vårt demo-system har (bare!) tre komponenter:

- [todo-frontend](https://github.com/kjetiljd/todo-frontend) Frontend typescript/vue.js
- [todo-backend](https://github.com/kjetiljd/todo-backend) Backend i Java/Spring Boot
- [todo-sorter](https://github.com/kjetiljd/todo-sorter) En sorteringstjeneste i JavaScript/Express.js

Nå skal vi legge til disse i meta-prosjektet vårt.

Begynn med å forstå hvordan `meta`-kommandoen fungerer.

```shell
meta                      # Dette viser deg standard hjelpe-teksten
```

```shell
meta help project         # Her får du hjelp med `project`
```

```shell
meta project help import  # Her får du hjelp med `project import`
```

Kommandoen vi trenger er på formen: `meta project import [folder] [git-url]`

Legg til det første repoet, som har git-url: https://github.com/kjetiljd/todo-frontend.git

```shell
meta project import todo-frontend https://github.com/kjetiljd/todo-frontend.git
```
Som du ser så klones repoet, også.

Ta en titt på `.meta`-filen:
```shell
cat .meta # eller tilsvarende kommando for å se innhold i filer
```

Se også på `.gitignore`:
```shell
cat .gitignore
```
Mappen med sub-repoet (`todo-frontend`) er ignorert i det ytre git-prosjektet. git i meta-prosjektet bryr seg ikke om sub-repoene. Dette gir oss en løs kopling mellom meta-repo'et og de andre repoene.

Fortsett med det neste repoet:

```shell
meta project import todo-backend https://github.com/kjetiljd/todo-backend.git
```

Sjekk `.meta` og `.gitignore` om de ser ut som forventet:

```shell
cat .meta
```

```shell
cat .gitignore
```

La oss legge til det siste repoet, men gjøre en liten vri

Denne gangen gjør vi *en vanlig git clone* først:

```shell
git clone https://github.com/kjetiljd/todo-sorter.git
```

Siden vi allerede har klonet repoet, kan vi bruke `meta project import` *uten url* denne gangen:
```shell
meta project import todo-sorter
```

Sjekk `.meta` og `.gitignore` om de ser ut som forventet:

```shell
cat .meta
cat .gitignore
```

(Dersom vi ikke hadde noe repo i det hele tatt, men skal lage et nytt, kunne vi brukt `meta project create [folder] [url]`.)


## Steg 4: Sjekk om vi er oppdatert

Nå skal vi bruke `meta git`-subkommandoen.

```shell
meta git status
```
Du skal nå få noe som ser slik ut (men med litt farger):
```plaintext
/todo-meta:
On branch main
Your branch is up to date with 'origin/main'.

Untracked files:
  (use "git add <file>..." to include in what will be committed)
	.gitignore
	.meta

nothing added to commit but untracked files present (use "git add" to track)
/todo-meta ✓

todo-frontend:
On branch main
Your branch is up to date with 'origin/main'.

nothing to commit, working tree clean
todo-frontend ✓

todo-backend:
On branch main
Your branch is up to date with 'origin/main'.

nothing to commit, working tree clean
todo-backend ✓

todo-sorter:
On branch main
Your branch is up to date with 'origin/main'.

nothing to commit, working tree clean
todo-sorter ✓

```

## Steg 5: Gjør en commit i meta-repoet

La oss commit'e endringene våre i meta-repoet, siden vi nå har et fungerende meta-repo.

```shell
git add .meta .gitignore
git commit -m"Etabler meta-repo"
```

**[← Tilbake til oversikt](../)** | **[→ Neste oppgave: Kommandoer med meta exec](../03-commands/)**
