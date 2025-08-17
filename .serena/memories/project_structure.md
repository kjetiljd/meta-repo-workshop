# Project Structure (High-Level)
Root:
- README.md: Participant-facing overview, prerequisites, agenda, learning goals, commands.
- DEVELOP.md: Instructor/developer prep guide (pre-work, testing, customization, advanced tips).
- INSTRUCTOR.md: Quick reference & runtime facilitation guide.
- WORKSHOP-SPEC.md: Formal workshop specification (title, abstract, agenda, tools).
- index.md: Jekyll landing page with CTA buttons to slides & workshop.
- slides/: Reveal.js presentation (index.html wrapper, slides.md content with speaker notes and sample YAML/script/code blocks).
- workshop/: Hands-on task directories (currently 01-setup plus placeholders/plan in workshop/index.md listing intended 02-commands, 03-automation, etc. Actual directories present: 01-setup, 02-commands, 03-automation, solutions/01-setup/meta.sh). Some mismatch vs DEVELOP/plan naming (e.g., doc references 02-basic-commands vs 02-commands).
- resources/: troubleshooting.md and related site exports.
- assets/: css (main.scss) plus images under _site build.
- _config.yml: Jekyll config (remote theme slate, plugins list, metadata).
- Gemfile / Gemfile.lock: Ruby dependencies.
- Dockerfile: Build Jekyll site image (Ruby 3.2 + node + bundler + jekyll build, then serve with livereload).
- Makefile: Automation targets (build, serve, serve-daemon, logs, stop, clean, install, serve-local, rebuild, help).
- _includes, _sass, assets/css: Theming and styling resources.
- _site/: Generated site output (should not usually be source-of-truth edits).
Notes:
- Some planned workshop subfolders (04-automation, etc.) not yet created; roadmap present in docs.
- Solutions folder only populated for 01-setup.
Potential Cleanup/Consistency Tasks:
- Align naming: 02-basic-commands vs 02-commands; 03-advanced vs 03-automation vs 03-advanced in docs.
- Remove or gitignore _site if committed (avoid editing generated output).
