# 🔧 Troubleshooting Guide

## Vanlige problemer og løsninger

### Git-relaterte problemer

#### Problem: "Permission denied (publickey)"
```bash
# Løsning: Sjekk SSH-nøkler
ssh -T git@github.com

# Hvis det feiler, generer ny SSH-nøkkel:
ssh-keygen -t ed25519 -C "din-email@example.com"
# Legg til nøkkelen i GitHub Settings → SSH Keys
```

#### Problem: "Could not resolve host: github.com"
```bash
# Sjekk nettverkstilkobling
ping github.com

# Sjekk DNS
nslookup github.com

# Prøv å bruke HTTPS i stedet for SSH
git config --global url."https://github.com/".insteadOf git@github.com:
```

### Script-problemer

#### Problem: "Permission denied" når jeg kjører script
```bash
# Gjør scriptet kjørbart
chmod +x scripts/meta.sh

# Eller kjør med bash direkte
bash scripts/meta.sh
```

#### Problem: "command not found: yq"
```bash
# Installer yq for YAML-parsing

# macOS
brew install yq

# Linux
sudo wget -qO /usr/local/bin/yq https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64
sudo chmod +x /usr/local/bin/yq

# Eller bruk Python som alternativ
pip install pyyaml
```

### Docker-problemer

#### Problem: "Cannot connect to the Docker daemon"
```bash
# Start Docker Desktop eller Docker daemon
# macOS/Windows: Åpne Docker Desktop
# Linux:
sudo systemctl start docker

# Sjekk status
docker info
```

#### Problem: "docker: command not found"
```bash
# Installer Docker
# Se https://docs.docker.com/get-docker/
```

### YAML-parsing problemer

#### Problem: "yaml.scanner.ScannerError"
```yaml
# Sjekk YAML-syntaks:
# - Konsistent innrykk (bruk spaces, ikke tabs)
# - Korrekt nøkkel:verdi format
# - Escaping av spesialtegn

# Bruk online validator:
# https://www.yamllint.com/
```

### Filstruktur-problemer

#### Problem: "No such file or directory"
```bash
# Sjekk at du er i riktig mappe
pwd

# List filer for å verifisere struktur
ls -la

# Opprett manglende mapper
mkdir -p config scripts templates docs
```

### GitHub Pages problemer

#### Problem: Siden vises ikke
1. Sjekk repository settings → Pages
2. Velg riktig branch og mappe (root eller /docs)
3. Vent 5-10 minutter for deployment
4. Sjekk Actions-fanen for byggefeil

#### Problem: 404 på undersider
```html
<!-- Sjekk at paths er relative -->
<a href="./slides/">  <!-- Ikke /slides/ -->
```

### Generelle tips

#### Debugging Bash-scripts
```bash
# Aktiver debug-modus
set -x  # Vis kommandoer som kjøres
set -e  # Stopp ved første feil

# Eller kjør med debug
bash -x scripts/meta.sh
```

#### Test incrementelt
```bash
# Test hver del for seg
./scripts/meta.sh list
./scripts/meta.sh clone payment-service
./scripts/meta.sh status
```

#### Sjekk logs
```bash
# Git logs
git log --oneline -5

# System logs (Linux/macOS)
tail -f /var/log/system.log

# Workshop logs
./scripts/meta.sh 2>&1 | tee workshop.log
```

## 🆘 Trenger mer hjelp?

### Under workshopen
- 🙋 Rekk opp hånden
- 💬 Spør i Slack: #javazone-workshops
- 👥 Spør sidemannen

### Etter workshopen
- 📧 Email: [workshop-leder-email]
- 🐛 GitHub Issues: [repo-url]/issues
- 📚 Dokumentasjon: [repo-url]/wiki

## 📖 Nyttige ressurser

- [Git dokumentasjon](https://git-scm.com/doc)
- [Bash scripting guide](https://www.gnu.org/software/bash/manual/)
- [YAML spesifikasjon](https://yaml.org/spec/)
- [GitHub Actions dokumentasjon](https://docs.github.com/en/actions)
- [Docker dokumentasjon](https://docs.docker.com/)

## 💡 Pro tips

1. **Start enkelt**: Ikke prøv å implementere alt på en gang
2. **Version control**: Commit ofte, selv små endringer
3. **Les feilmeldinger**: De inneholder ofte løsningen
4. **Bruk autocomplete**: Tab-completion sparer tid og reduserer typos
5. **Keep it simple**: Enkel kode er lettere å debugge

---

**[← Tilbake til workshop](../workshop/)**
