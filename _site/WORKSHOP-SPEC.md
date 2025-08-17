# Workshop Spesifikasjon

## Tittel
**Mono-repo eller mange repo? Prøv meta-repo!**

## Format
- **Type:** Workshop
- **Varighet:** 2 timer
- **Språk:** Norsk
- **Status:** Bekreftet

## Abstract
Mange kode-repo å holde greie på i teamet ditt? Har du tenkt på mono-repo, men har hørt at det er en del utfordringer? Kanskje er tiden inne for å forsøke *meta-repo*? Meta-repo er en teknikk (med enkle verktøy) for å kunne gjøre ting med flere repo samtidig, uten at repoene må henge sammen. I denne workshop'en vil du få en introduksjon til meta-repo, hvordan man setter det opp, og få se og prøve ut noen muligheter det gir for å håndtere mange repo på en enklere måte, uten å ta steget helt til mono-repo. Når workshop'en er ferdig er du klar til å ta teknikken i bruk i ditt eget team.

## Målgruppe
Dette er for utviklere som må jobbe på tvers av flere/mange git-repo, og som gjerne vil redusere repetitivt arbeid.

## Detaljert Agenda (120 minutter)

| Tid | Varighet | Tema | Type |
|-----|----------|------|------|
| 00:00 | 5 min | Introduksjon, agenda, finne plassene | Presentasjon |
| 00:05 | 7 min | Motivasjon og introduksjon til meta-repo | Presentasjon |
| 00:12 | 3 min | Introduksjon til verktøyet meta og .meta-fil | Demo |
| 00:15 | 10 min | Oppsett av meta-verktøyet & kloning av demo-repo | Hands-on |
| 00:25 | 10 min | Kommandolinje-øvelser | Hands-on |
| 00:35 | 15 min | Bruk av make eller script til nyttige kommandoer (git pull, status etc) | Hands-on |
| 00:50 | 10 min | Kodeendring på tvers av repo | Hands-on |
| 01:00 | 10 min | Kodeanalyse med cloc som eksempel | Hands-on |
| 01:10 | 15 min | git-historikk analyse (endringer, release notes, statistikk) | Hands-on |
| 01:25 | 5 min | Inspirasjon: Meta-CLI | Demo |
| 01:30 | 5 min | Inspirasjon: github-konfig | Demo |
| 01:35 | 10 min | Templates på tvers | Hands-on |
| 01:45 | 10 min | Hvordan sette opp et nytt meta-repo og legge til repo | Hands-on |
| 01:55 | 5 min | Avslutning | Presentasjon |

## Verktøy som brukes
- **meta** - NPM-pakke for meta-repo management (https://github.com/mateodelnorte/meta)
- **cloc** - Count Lines of Code
- **make** - For automatisering
- **git** - Versjonskontroll

## Bakgrunnsmateriale
- 40-minutters bedriftsintern presentasjon: https://youtu.be/GFaWYmctdfY
- Demo-repo med avanserte verktøy for kode og commit-statistikk-analyse

## Om foredragsholder
**Kjetil Jørgensen-Dahl**

Programvare oversvømmer verden – vi produserer mer enn vi klarer å håndtere, og vi trenger alle triks i boka for å henge med. Å kjempe mot entropi og kognitiv last er en hjertesak for Kjetil, utvikler og smidig-entusiast gjennom et par tiår. For tiden jobber han som Principal Software Engineer i Telenor, der man transformerer en telekom-gigant til en lærende, brukerorientert og innovativ leverandør av sikre og verdifulle tjenester til forbrukere, bedrifter og det offentlige.

## Notater
- Workshop først tunet bedriftinternt
- Enkle hands-on-øvelser for å vise hvor greit det er å komme i gang
- Demo-repo med avanserte verktøy som inspirasjon
