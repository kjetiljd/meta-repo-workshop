# Oppgave 1: Installasjon av meta-verktøyet

## 📋 Mål

I denne oppgaven skal du:
- Installere meta-verktøyet

## 📚 Bakgrunn

Vi trenger meta-verktøyet til Matt Williams, som vi installerer med npm.

Som nevnt i [påmeldingssiden til workshop](https://2025.javazone.no/en/program/2ae2ead1-163a-4309-b0d5-890f4166423d)'en har dette blitt testet på macOS. Windows-brukere bør kunne bruke WSL2 (Windows Subsystem for Linux), evt så har jeg en docker-container,
som dere kan benytte (se lenger ned i siden her). Linux-nerds - dere er på egenhånd, men regner med at dere klarer dere fint :)

## 🛠 Steg-for-steg

### Steg 1: NPM og node

Test at du har node og npm installert:

```bash
node --version
npm --version
```

Om du ikke har node kan du installere det med:
```bash
brew install node   # Mac
```

På Linux kan du bruke pakkebehandleren din, f.eks:
```bash
sudo apt-get install nodejs npm   # Ubuntu/Debian
```

### Steg 2: Installer meta-verktøyet

Dersom du ikke bruker Docker, installer meta globalt med npm:

```bash
npm install -g --no-save meta
```

Test at det fungerer:

```bash
meta --version
```

### Alternativt: Docker

Dersom du ikke vil eller får installert verktøyene lokalt,
kan du bruke Docker:

Windows:
```shell
docker run --rm -it -v "$($PWD.Path):/work" -w /work ghcr.io/kjetiljd/meta-repo-workshop-tools:latest bash
```

Mac/Linux:
```shell
docker run --rm -it -v "$PWD:/work" -w /work ghcr.io/kjetiljd/meta-repo-workshop-tools:latest bash
```

Nå er du i en bash-terminal med alt du trenger installert.
`/work` er mappet til mappen du står når du kjører kommandoen.
Kjør `exit` for å gå ut av terminalen i docker-containeren.


**[← Tilbake til oversikt](../)** | **[→ Neste oppgave: Oppsett og grunnleggende struktur](../02-setup/)**