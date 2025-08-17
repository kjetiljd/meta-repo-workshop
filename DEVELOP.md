# 🚀 Workshop Utvikler-guide

## For deg som skal holde workshopen

Dette dokumentet inneholder all informasjon DU trenger for å forberede, teste og gjennomføre workshopen. Deltakerne ser ikke dette.

## 📋 Forberedelse (1 uke før)

### 1. Tilpass innholdet
Bytt ut alle placeholder-verdier i filene:

- [ ] `[Ditt navn]` → Ditt faktiske navn
- [ ] `[din-email]` → Din email
- [ ] `[din-bruker]` → Din GitHub-bruker
- [ ] `[@din-twitter]` → Din Twitter/X handle

**Filer som må oppdateres:**
- `README.md`
- `slides/slides.md` (spesielt slide 4 - "Hvem er jeg?")
- `index.html`
- `package.json`
- Alle steder det står "example.com" eller lignende

### 2. Test hele oppsettet lokalt

```bash
# Enkleste test
python3 test-server.py

# Test med Docker (mer realistisk)
docker-compose up -d

# Eller med Make
make serve
```

**Sjekkliste for lokal testing:**
- [ ] Hovedside laster og ser bra ut
- [ ] Presentasjon fungerer (navigering, speaker notes med 'S')
- [ ] Workshop-oppgaver er lesbare
- [ ] Alle lenker fungerer
- [ ] Responsive design på mobil

### 3. Deploy til GitHub Pages

```bash
# Initialiser git hvis ikke gjort
git init
git add .
git commit -m "Workshop klar for JavaZone"

# Push til GitHub
git remote add origin https://github.com/kjetiljd/meta-repo-workshop.git
git push -u origin main
```

**GitHub Pages oppsett:**
1. Gå til Settings → Pages i repoet
2. Source: GitHub Actions
3. Vent 2-3 minutter
4. Test på: https://kjetiljd.github.io/meta-repo-workshop/

### 4. Forbered eksempel-repositories

Deltakerne trenger noen repos å jobbe med. Opprett disse på forhånd:

```bash
# Eksempel-repos (opprett på GitHub først)
https://github.com/kjetiljd/workshop-payment-service
https://github.com/kjetiljd/workshop-user-service
https://github.com/kjetiljd/workshop-frontend
```

Eller bruk eksisterende public repos som eksempler.

## 🎯 Under workshopen

### Tidsplan (2 timer)

| Tid | Hva | Notater |
|-----|-----|---------|
| 00:00-00:05 | Velkommen & praktisk info | WiFi, Slack, etc |
| 00:05-00:30 | Presentasjon (teori) | Bruk speaker notes |
| 00:30-00:35 | Introduser oppgave 1 | Vis strukturen |
| 00:35-00:50 | Oppgave 1: Oppsett | Gå rundt og hjelp |
| 00:50-01:05 | Oppgave 2: Basis-kommandoer | |
| 01:05-01:25 | Oppgave 3: Avanserte operasjoner | |
| 01:25-01:40 | Oppgave 4: Automatisering | |
| 01:40-01:50 | Oppgave 5: Real-world scenario | |
| 01:50-02:00 | Oppsummering & Q&A | |

### Speaker Notes for presentasjonen

Trykk **'S'** i presentasjonen for å se speaker notes. Disse er skrevet på norsk i `slides/slides.md` under `Note:` seksjoner.

### Live-koding fallback

Hvis deltakerne står fast, ha disse klar for live-demo:

```bash
# Quick win - vis at meta-kommandoer fungerer
cd workshop/solutions/01-setup
./meta.sh list
./meta.sh clone --all
./meta.sh status
```

### Vanlige problemer og quick fixes

**Problem: "Permission denied"**
```bash
chmod +x scripts/meta.sh
```

**Problem: "PyYAML not found"**
```bash
pip3 install pyyaml
# eller
pip install pyyaml
```

**Problem: "Git authentication failed"**
```bash
# Bytt til HTTPS isteden for SSH
git config --global url."https://github.com/".insteadOf git@github.com:
```

## 🛠 Teknisk oppsett

### Mappestruktur

```
meta-repo-workshop/
├── README.md             # For DELTAKERE
├── DEVELOP.md           # For DEG (denne filen)
├── index.html           # Landing page (GitHub Pages)
├── slides/              # Reveal.js presentasjon
│   ├── index.html       # Reveal.js wrapper
│   └── slides.md        # Innholdet (rediger denne!)
├── workshop/            # Oppgaver for deltakerne
│   ├── 01-setup/        # Oppgave 1
│   ├── 02-basic/        # Oppgave 2 (må lages)
│   ├── 03-advanced/     # Oppgave 3 (må lages)
│   ├── 04-automation/   # Oppgave 4 (må lages)
│   ├── 05-scenario/     # Oppgave 5 (må lages)
│   └── solutions/       # Fasit (ikke vis med en gang!)
└── resources/           # Ekstra materiell
```

### Test-kommandoer

```bash
# Start lokal server
make serve

```

### Utvikling av nye oppgaver

Template for ny oppgave:

```markdown
# Oppgave N: Tittel

## 📋 Mål
- Hva skal deltakerne lære?

## 🛠 Steg-for-steg
1. Først...
2. Deretter...

## 🎯 Oppgaver
- Oppgave N.1: ...
- Oppgave N.2: ...

## ✅ Suksesskriterier
- [ ] Kriterium 1
- [ ] Kriterium 2

## 💡 Tips
- Tips hvis de står fast
```

## 📊 Presentasjons-tips

### Keyboard shortcuts i Reveal.js
- `→` / `Space`: Neste slide
- `←`: Forrige slide  
- `S`: Speaker notes (VIKTIG!)
- `F`: Fullskjerm
- `ESC`: Oversikt
- `B`: Blank skjerm
- `?`: Vis alle shortcuts

### Tilpass tema
Rediger CSS i `slides/index.html` for å tilpasse farger/font:

```css
.reveal h1, .reveal h2, .reveal h3 {
    color: #42affa;  /* Endre farge her */
}
```

## 🚨 Backup-plan

### Hvis GitHub Pages ikke fungerer
Ha en lokal versjon klar på en USB-pinne:
```bash
# Lag offline-versjon
wget -r -k -np http://localhost:8000/
zip -r workshop-offline.zip localhost:8000/
```

### Hvis nettverk ikke fungerer
- Ha alle dependencies lokalt
- Forbered lokale git-repos
- USB-pinne med ferdig oppsett

### Hvis Docker ikke fungerer
- Fallback til Python server
- Eller bare statiske filer

## 📝 Etter workshopen

### Samle feedback
- [ ] Send ut feedback-skjema
- [ ] Noter forbedringspunkter
- [ ] Oppdater dokumentasjon

### Del materialet
- [ ] Push oppdateringer til GitHub
- [ ] Del lenke i Slack
- [ ] Tweet om workshopen?

### Oppfølging
- [ ] Svar på spørsmål i Slack
- [ ] Lag blog-post?
- [ ] Forbedre til neste gang

## 🔧 Avanserte tilpasninger

### Legge til flere oppgaver

```bash
# Opprett ny oppgave
mkdir workshop/02-basic-commands
cp workshop/01-setup/index.md workshop/02-basic-commands/
# Rediger innholdet
```

### Endre presentasjonstema

Reveal.js temaer: https://revealjs.com/themes/

Bytt tema i `slides/index.html`:
```html
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reveal.js@4.3.1/dist/theme/white.css">
```

### Legge til animasjoner

I `slides/slides.md`:
```markdown
<!-- .slide: data-transition="zoom" -->
# Fancy slide

<!-- .element: class="fragment" -->
Dette vises gradvis
```

## 🤝 Support

Hvis du står fast:
- Anthropic Discord/Slack?
- GitHub Issues
- Stack Overflow

---

**Lykke til med workshopen!** 🚀

*P.S. Husk å smile og ha det gøy - entusiasme smitter!*
