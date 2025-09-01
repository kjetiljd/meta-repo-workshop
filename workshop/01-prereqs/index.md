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

### Troubleshooting Mac

#### Proxy-problemer

Dersom du får en feilmelding som dette:
```
npm warn deprecated inflight@1.0.6: This module is not supported, and leaks memory. Do not use it. Check out lru-cache if you want a good and tested way to coalesce async requests by a key value, which is much more comprehensive and powerful.
npm warn deprecated rimraf@2.7.1: Rimraf versions prior to v4 are no longer supported
npm warn deprecated glob@7.2.3: Glob versions prior to v9 are no longer supported
npm error code FETCH_ERROR
npm error errno FETCH_ERROR
npm error request to https://codeload.github.com/mateodelnorte/commander.js/tar.gz/9060bf880b791cf39245d425f1e8a41a55616781 failed, reason: Socket closed
npm error A complete log of this run can be found in: /Users/t992958/.npm/_logs/2025-09-01T11_28_49_761Z-debug-0.log
```
Så har du problemer med proxy-innstillinger - skru av proxy for npm: 

```bash
npm config set noproxy "registry.npmjs.org,codeload.github.com,github.com"
```

### Troubleshooting Windows

#### Cygwin (muligens også WSL)

Det er dessverre en bug i meta som gjør at den ikke fungerer. [Saken er meldt](https://github.com/mateodelnorte/meta/issues/334) til meta-prosjektet, men inntil videre må dere gjøre en workaround.

Symptom:
```bash
$ meta init
Error: spawn EINVAL
    at ChildProcess.spawn (node:internal/child_process:421:11)
    at spawn (node:child_process:796:9)
    at Command.executeSubCommand (C:\Users\username\AppData\Roaming\npm\node_modules\meta\node_modules\commander\index.js:565:12)
    at Command.parse (C:\Users\username\AppData\Roaming\npm\node_modules\meta\node_modules\commander\index.js:489:17)
    at exports.run (C:\Users\username\AppData\Roaming\npm\node_modules\meta\index.js:47:11)
    at Object.<anonymous> (C:\Users\username\AppData\Roaming\npm\node_modules\meta\bin\meta:8:15)
    at Module._compile (node:internal/modules/cjs/loader:1738:14)
    at Object..js (node:internal/modules/cjs/loader:1871:10)
    at Module.load (node:internal/modules/cjs/loader:1470:32)
    at Module._load (node:internal/modules/cjs/loader:1290:12) {
  errno: -4071,
  code: 'EINVAL',
  syscall: 'spawn'
}
```

Workaround - rapportert av en bruker som fikk det til å fungere:

Redigerte line 563 og 565 i denne filen: C:\Users\<username>\AppData\Roaming\npm\node_modules\meta\node_modules\commander\index.js

Fra:
```javascript
proc = spawn(process.argv[0], args, { stdio: 'inherit', customFds: [0, 1, 2] });
} else {
proc = spawn(bin, args, { stdio: 'inherit', customFds: [0, 1, 2] });
```

Til:
```javascript
proc = spawn(process.argv[0], args, { stdio: 'inherit', shell: true, customFds: [0, 1, 2] });
} else {
proc = spawn(bin, args, { stdio: 'inherit', shell: true, customFds: [0, 1, 2] });
```


### Alternativt: Docker

Dersom du ikke vil eller får installert verktøyene lokalt,
kan du bruke Docker:

Windows (Powershell):
```shell
docker run --rm -it -v "$($PWD.Path):/work" -w /work ghcr.io/kjetiljd/meta-repo-workshop-tools:latest bash
```

Mac/Linux/...:
```shell
docker run --rm -it -v "$PWD:/work" -w /work ghcr.io/kjetiljd/meta-repo-workshop-tools:latest bash
```

Nå er du i en bash-terminal med alt du trenger installert.
`/work` er mappet til mappen du står når du kjører kommandoen.

Kjør `exit` nå for å gå ut av terminalen i docker-containeren:
```shell
exit
```


**[← Tilbake til oversikt](../)** | **[→ Neste oppgave: Oppsett og grunnleggende struktur](../02-setup/)**