# Oppgave 6: IDE-integrasjon med Gradle Composite Build

## 📋 Mål

I denne oppgaven skal du:
- Sette opp Gradle Composite Build for meta-repo
- Åpne hele meta-repo som ett prosjekt i IntelliJ
- Utforske cross-repository navigation og refactoring
- Forstå fordelene med unified workspace

## 📚 Bakgrunn

Når du har mange repositories blir IDE-arbeid fragmentert - hver repo må åpnes separat, og du mister oversikten over hele systemet. Gradle Composite Build løser dette ved å la deg kombinere flere separate prosjekter til én unified workspace i IntelliJ.

## 🛠 Steg-for-steg

### Steg 1: Sjekk eksisterende oppsett

Gå til todo-meta mappen og sjekk om Gradle-oppsett allerede finnes:

```bash
cd todo-meta

# Sjekk om Gradle wrapper finnes
ls -la gradlew*

# Sjekk om settings.gradle finnes
cat settings.gradle
```

Du skal se noe slikt:

```gradle
rootProject.name = "todo-meta"

includeBuild "todo-frontend"
includeBuild "todo-backend"
includeBuild "todo-sorter"
```

### Steg 2: Opprett Gradle wrapper (hvis det ikke finnes)

Hvis Gradle wrapper ikke finnes, opprett det:

```bash
# Sørg for at du har Gradle installert
gradle --version

# Opprett wrapper
gradle wrapper

# Sjekk at det ble opprettet
ls -la gradlew*
```

### Steg 3: Lag settings.gradle (hvis det ikke finnes)

Hvis settings.gradle ikke finnes, opprett den:

```bash
# Opprett settings.gradle
cat > settings.gradle << 'EOF'
rootProject.name = "todo-meta"

includeBuild "todo-frontend"
includeBuild "todo-backend"
includeBuild "todo-sorter"
EOF
```

### Steg 4: Opprett tom build.gradle

Gradle Composite Build krever en build.gradle fil i roten:

```bash
# Opprett tom build.gradle (hvis den ikke finnes)
touch build.gradle
```

### Steg 5: Åpne prosjektet i IntelliJ

1. **Start IntelliJ IDEA**
2. **Velg "Open"**
3. **Naviger til todo-meta mappen**
4. **Velg mappen** (ikke en spesifikk fil)
5. **Klikk "OK"**

IntelliJ vil automatisk gjenkjenne Gradle-oppsettet og importere alle sub-prosjekter.

### Steg 6: Vent på import

IntelliJ vil:
- Kjøre Gradle import
- Laste ned dependencies
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

**For Java/Kotlin prosjekter:**

1. **Åpne en klasse** i todo-backend
2. **Hold Cmd/Ctrl og klikk** på en import eller klasse-referanse
3. **Hopp til definisjon** - selv om den er i et annet repo

**Global search:**

1. **Trykk Shift+Shift** (Search Everywhere)
2. **Søk etter en klasse eller funksjon**
3. **Se resultater fra alle repos** samtidig

### Steg 9: Test unified run configurations

1. **Gå til Run/Debug Configurations**
2. **Se at du kan lage configurations** som berører flere prosjekter
3. **Test å kjøre tasks** fra forskjellige repos

### Steg 10: Sjekk build integrasjon

Fra IntelliJ Terminal eller Gradle tool window:

```bash
# Kjør tasks på tvers av alle prosjekter
./gradlew build

# Kjør task i spesifikt sub-prosjekt
./gradlew :todo-backend:build

# List alle tilgjengelige tasks
./gradlew tasks
```

### Steg 11: Commit Gradle Composite Build oppsettet

Commit Gradle-filene til meta-repoet:

```bash
git add settings.gradle build.gradle gradlew gradlew.bat gradle/
git commit -m"Legg til Gradle Composite Build for IDE-integrasjon"
```

## 🎯 Ekstra-oppgaver

1. **Code style consistency**: Sett opp felles code style settings
2. **Shared run configurations**: Lag run configs som starter flere services
3. **Custom Gradle tasks**: Lag tasks som opererer på tvers av repos
4. **Debugging**: Test debugging på tvers av service-grenser
5. **Version catalogs**: Bruk Gradle version catalogs for dependency management

<details markdown="1">
  <summary>Løsningsforslag</summary>

<details markdown="1">
  <summary>1. Code style consistency</summary>

1. **File → Settings → Editor → Code Style**
2. **Eksporter settings** til en fil
3. **Legg settings-filen** i meta-repo
4. **Team kan importere** samme settings

```bash
# Legg code style i meta-repo
mkdir -p .idea/codeStyles
# Kopier exported settings hit
```
</details>

<details markdown="1">
  <summary>2. Shared run configurations</summary>

**Compound run configuration:**
1. **Run → Edit Configurations**
2. **+ → Compound**
3. **Legg til flere run configs**
4. **Navn: "Start All Services"**

Nå kan du starte alle services med én kommando!
</details>

<details markdown="1">
  <summary>3. Custom Gradle tasks</summary>

```gradle
// I root build.gradle
task startAll {
    description = 'Start all services'
    dependsOn ':todo-backend:bootRun', 
              ':todo-frontend:serve',
              ':todo-sorter:start'
}

task testAll {
    description = 'Test all projects'
    dependsOn gradle.includedBuilds.collect { 
        it.task(':test') 
    }
}
```
</details>

<details markdown="1">
  <summary>4. Version catalogs</summary>

```gradle
// gradle/libs.versions.toml
[versions]
spring-boot = "2.7.0"
junit = "5.8.2"

[libraries]
spring-boot-starter = { module = "org.springframework.boot:spring-boot-starter", version.ref = "spring-boot" }
junit-jupiter = { module = "org.junit.jupiter:junit-jupiter", version.ref = "junit" }
```

```gradle
// I sub-prosjekter
dependencies {
    implementation libs.spring.boot.starter
    testImplementation libs.junit.jupiter
}
```
</details>

</details>

## 🔄 Feilsøking

### Vanlige problemer:

**Import feiler**:
```bash
# Rydd opp og prøv igjen
./gradlew clean
# I IntelliJ: File → Reload Gradle Project
```

**Sub-prosjekter vises ikke**:
- Sjekk at settings.gradle har korrekte `includeBuild` statements
- Sjekk at sub-mappene faktisk eksisterer
- Verifiser at hver sub-mappe har sitt eget build system

**Gradle wrapper problemer**:
```bash
# Re-generer wrapper
gradle wrapper --gradle-version 8.5
```

**Performance problemer**:
- Øk heap size for IntelliJ
- Ekskluder unødvendige mapper fra indeksering
- Bruk "Power Save Mode" hvis nødvendig

## 💡 Tips

- **Store prosjekter**: Composite build fungerer best med < 20 sub-prosjekter
- **Mixed technologies**: Fungerer godt selv med JavaScript, Python etc i samme workspace
- **Git integration**: IntelliJ håndterer Git på tvers av alle repos
- **Code inspection**: Får felles code inspection på tvers av prosjekter
- **Dependency graph**: Bruk "Show Gradle Dependencies" for å se sammenhenger

## 📈 Fordeler du nå har

✅ **Global search** på tvers av alle repositories

✅ **Cross-repo refactoring** med trygghet

✅ **Unified navigation** mellom alle komponenter

✅ **Consistent development environment**

✅ **Simplified debugging** på tvers av services

✅ **Shared configurations** og settings

**[← Tilbake til oversikt](../)** | **[→ Neste: Avancerte scenarios](../07-advanced/)**