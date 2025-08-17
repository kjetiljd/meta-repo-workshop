# Task Completion / Quality Gates
Purpose: Consistent checklist before committing/merging or declaring a workshop content task done.

## 1. Content Updates
- Replace any lingering placeholders ([Ditt navn], [din-email], etc.) in README.md, slides/slides.md, index.md, DEVELOP.md, INSTRUCTOR.md.
- Add new workshop task folder (e.g., `04-automation/`) with `index.md` following prior task structure (Goals, Steps, Tasks, Success criteria, Tips).
- Update `workshop/index.md` task list and timing if new tasks are added or renamed.
- Provide solution script(s) under `workshop/solutions/<task>/` when practical.

## 2. Local Verification (Static Site)
- Quick serve (fast path): `python3 -m http.server 8000` (basic static view for Markdown->HTML already built under _site if present).
- Full Jekyll dev (preferred):
  - Docker: `make serve` (confirm http://localhost:4000 loads, navigate slides & workshop pages).
  - OR Local: `bundle install && bundle exec jekyll serve` (watch for build warnings/errors).
- Check navigation links: index -> slides, index -> workshop, workshop tasks, resources/troubleshooting.
- Reveal.js slides: open `slides/` route; test speaker notes via `S`, overview via `ESC`.

## 3. Consistency & Style
- Emojis present for major headings (Workshop docs) for readability.
- Directory names match references (e.g., ensure `02-commands` vs `02-basic-commands` discrepancy resolved; update docs or rename dir).
- `_site/` not manually edited; if committed, ensure regeneration still clean.

## 4. Optional Content Quality Checks
- Spell / wording pass (manual or a spell-checker) on newly edited Markdown.
- Validate code fences have language tags (bash, yaml, python, html, css) for syntax highlighting.

## 5. Build / Container
- Jekyll build sanity: `bundle exec jekyll build` (should exit 0, no fatal errors).
- Docker image: `docker build -t meta-repo-workshop .` (optional; ensures Dockerfile still valid).
- Container run smoke: `docker run --rm -p 4000:4000 meta-repo-workshop` (stop after confirming page loads).

## 6. Meta Tool Exercise (If Task Involves Meta)
- If adding meta-repo exercise instructions, test sample commands with a minimal `.meta` file in a temp directory to avoid broken guidance.

## 7. Git & Commit
- Stage changes: `git add .` (exclude large/generated artifacts if adding ignore rules later).
- Commit message convention (suggested):
  - content: update workshop 04 automation task
  - chore: align task directory names
  - fix: broken link in README
- Push: `git push origin main` (or feature branch + PR if adopting review flow).

## 8. CI / Deployment
- Verify GitHub Actions run (Pages build) completes successfully.
- Confirm live site updates at https://<user>.github.io/meta-repo-workshop/ after build.

## 9. Post-Deploy
- Spot-check slides, workshop pages, and new tasks on the published site.
- Update `suggested_commands.md` memory if new recurring commands introduced.

## 10. Housekeeping
- Ensure `_site/` is either ignored (recommended) or intentionally versioned—decide and document.
- Track TODOs in TODO.md; remove resolved items.

## Quick Command Recap
```
make serve
bundle exec jekyll build
docker build -t meta-repo-workshop .
git add . && git commit -m "content: add automation task" && git push origin main
```

## Requirements Coverage (Internal)
- Content correctness ✔
- Local build ✔
- Container build ✔ (optional but recommended)
- Deployment trigger ✔
- Live verification ✔

Following these gates reduces risk of broken workshop pages or inconsistent instructions.