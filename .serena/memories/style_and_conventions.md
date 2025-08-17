# Style & Conventions
Language & Tone:
- Primary audience language: Norwegian (Bokmål) with occasional English technical terms.
- Friendly, instructional tone; liberal use of emojis for section headers (🚀, 🎯, 🛠, etc.).
- Concise bullet lists; checklists for preparation & success criteria.

Markdown / Docs:
- Headings: `#` top-level per file, then `##` subsections. Emojis precede many headings for scannability.
- Checklists: `- [ ]` used for prep tasks (placeholders to replace, verification steps).
- Code fences: Language-tagged (bash, yaml, python, html, css) for syntax highlighting; short, outcome-focused examples.
- Notes for speaker in slides: "Note:" blocks after `---` slide separators in `slides/slides.md`; incremental reveal via `--` markers.
- Directory trees rendered inside triple backticks for structure illustration.

Naming:
- Filenames in lowercase with hyphens (e.g., `WORKSHOP-SPEC.md` uses uppercase + hyphen for emphasis; mixed style but accepted).
- Workshop task directories prefixed with zero-padded ordinal (e.g., `01-setup`). Some planned names diverge across docs (e.g., `02-commands` vs `02-basic-commands`). Consistency improvement recommended.

Code / Scripts:
- Shell snippets assume POSIX bash; no Windows batch equivalents provided (except tool installation hints).
- Make targets all lowercase, single-responsibility; echo statements use emojis for feedback.
- Dockerfile: Multi-step with layer caching (COPY Gemfile first). Simplicity prioritized over multi-stage optimization.

Jekyll / Site:
- Remote theme configured via `_config.yml`; minimal site-specific SCSS (assets/css/main.scss). Use kramdown GFM input.
- Plugin usage minimal; rely on GitHub Pages compatibility.

Emojis / Visual Cues:
- Consistent emoji use to differentiate sections (Agenda, Prereqs, Tips, etc.) aiding scanning during a workshop.

Content Placeholder Policy:
- Square bracket placeholders (e.g., `[Ditt navn]`, `[din-email]`) to be replaced before delivery; tracked in DEVELOP.md prep checklist.

Commit / Versioning (implicit):
- Conventional commit style hinted ("chore:" in examples) but not strictly enforced.

Quality Suggestions (not yet codified):
- Add `.gitignore` entry for `_site/` build output if not already.
- Establish consistent naming for workshop subdirectories.
- Introduce a CONTRIBUTING.md if external contributions expected.
