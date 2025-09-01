# Oppgave 7: IDE-integrasjon med Gradle Composite Build

## 📋 Mål

I denne oppgaven skal du:
- Sette opp Gradle Composite Build for meta-repo
- Åpne hele meta-repo som ett prosjekt i IntelliJ
- Utforske cross-repository navigation og refactoring
- Forstå fordelene med unified workspace

_NB! Denne oppgaven krever Java, Gradle og IntelliJ installert på maskinen din. Om du ikke har det så les bare igjennom._


## 📚 Bakgrunn

Når du har mange repositories blir IDE-arbeid fragmentert - hver repo må åpnes separat, og du mister oversikten over hele systemet. Gradle Composite Build løser dette ved å la deg kombinere flere separate prosjekter til én unified workspace i IntelliJ.

## 🛠 Steg-for-steg

### Steg 1: Opprett Gradle wrapper

Sørg for at du har Gradle installert:

```bash
gradle --version
```

Opprett wrapper
```
gradle wrapper
```
Sjekk at det ble opprettet
```bash
ls -la gradlew*
```

### Steg 3: Lag settings.gradle

Opprett settings.gradle:

```bash
cat > settings.gradle << 'EOF'
rootProject.name = "todo-meta"

includeBuild "todo-frontend"
includeBuild "todo-backend"
includeBuild "todo-sorter"
EOF
```

### Steg 4: Opprett tom build.gradle

Gradle Composite Build krever en build.gradle fil i roten:

Opprett tom build.gradle (hvis den ikke finnes):
```bash
touch build.gradle
```

### Steg 5: Åpne prosjektet i IntelliJ

1. **Start IntelliJ IDEA**
2. **Velg "Open"**
3. **Naviger til todo-meta mappen**
4. **Velg build-gradle-filen**
5. **Klikk "OK"** og åpne som Prosjekt

IntelliJ vil automatisk gjenkjenne Gradle-oppsettet og importere alle sub-prosjekter.

### Steg 6: Vent på import

IntelliJ vil:
- Kjøre Gradle import
- Laste ned dependencies (for gradle-prosjekter)
- Indeksere alle prosjekter

Dette kan ta et par minutter første gang. Du ser progresjon nederst til høyre i IntelliJ.

### Steg 7: Utforsk unified workspace

Når import er ferdig, sjekk Project-panelet til venstre:

```
todo-meta
├── todo-backend/
│   ├── src/
│   ├── build.gradle
│   └── ...
├── todo-frontend/
│   ├── src/
│   ├── package.json
│   └── ...
├── todo-sorter/
│   ├── src/
│   ├── package.json
│   └── ...
├── build.gradle
└── settings.gradle
```

Alle sub-prosjekter er nå synlige i samme workspace!

### Steg 8: Test cross-project navigation

**Global search:**

1. **Trykk Shift+Shift** (Search Everywhere)
2. **Søk etter  "medium"
3. **Se resultater fra alle repos** samtidig

### Steg 11: Commit Gradle Composite Build oppsettet

Commit Gradle-filene til meta-repoet:

```bash
git add settings.gradle build.gradle gradlew gradlew.bat gradle/
git commit -m"Legg til Gradle Composite Build for IDE-integrasjon"
```

**[← Tilbake til oversikt](../)** | **[→ Neste oppgave: Cross-repo koordinering](../08-cross-repo/)**