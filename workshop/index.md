# Workshop: Meta-Repository Pattern

## 📚 Oversikt

Denne workshopen består av oppgaver som bygger på hverandre, så her er det best å starte fra toppen.

## 🎯 Oppgaver

1. **[Installere `meta`](01-prereqs/)**
   - Installere Node.js og npm
   - Installere `meta` globalt via npm
   - Evt bruke Docker for isolert miljø

2. **[Oppsett og grunnleggende struktur](02-setup/)**
   - Klone demo-meta-repo
   - Legge til sub-repo med `meta project import`
   - Teste grunnleggende kommandoer

3. **[Kommandolinje-øvelser](03-commands/)**
   - Kjøre `meta exec "kommando"`
   - Ekskludere repo med `--exclude`
   - Kommando-kjeder og `cloc` analyse

4. **[Automatisering med make/scripts](04-automation/)**
   - Lage Makefile med meta-integrasjon
   - Makefile-triks: .PHONY og help target
   - `make stats` med cloc-rapporter

5. **[Git-historikk analyse](05-git-history/)**
   - Lag "hotspots" make target
   - Analysere mest endrede filer på tvers av repos
   - Git log analyse og commit-historikk

6. **[Docker og Docker Compose](06-dockered/)**
   - Sette opp Docker Compose for meta-repo
   - Service-koordinering og dependencies
   - Integrering med Makefile

7. **[IDE-integrasjon](07-ide-integration/)**
   - Gradle Composite Build setup
   - Unified workspace i IntelliJ
   - Cross-repository navigation og refactoring

8. **[Cross-repo koordinering](08-cross-repo/)**
   - Lag "recent-activity" make target
   - Koordinerte kodeendringer på tvers av repos
   - Commit coordination workflow

## 💡 Tips

- Hvis du står fast, spør!

## 🏁 La oss starte!

**[→ Start med Oppgave 1: Installere meta](01-prereqs/)**


