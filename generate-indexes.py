#!/usr/bin/env python3
"""
Generate index.html for all workshop folders
"""

from pathlib import Path

TEMPLATE = '''<!DOCTYPE html>
<html lang="no">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{title}</title>
    <script src="https://cdn.jsdelivr.net/npm/marked/marked.min.js"></script>
    <style>
        body {{ font-family: -apple-system, BlinkMacSystemFont, sans-serif; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 2rem; }}
        .container {{ max-width: 900px; margin: 0 auto; background: white; border-radius: 15px; padding: 3rem; box-shadow: 0 20px 60px rgba(0,0,0,0.3); }}
        .nav {{ margin-bottom: 2rem; }}
        .nav a {{ color: #764ba2; text-decoration: none; font-weight: 600; margin-right: 1rem; }}
        #content h1 {{ color: #764ba2; }}
        #content h2 {{ color: #667eea; }}
        #content code {{ background: rgba(66, 175, 250, 0.1); padding: 2px 6px; border-radius: 3px; }}
        #content pre {{ background: #f6f8fa; padding: 1rem; border-radius: 6px; overflow-x: auto; }}
    </style>
</head>
<body>
    <div class="container">
        <div class="nav">
            <a href="{back_url}">← Tilbake</a>
            <a href="{home_url}">Hovedside</a>
        </div>
        <div id="content">Laster...</div>
    </div>
    <script>
        fetch('README.md')
            .then(r => r.text())
            .then(md => document.getElementById('content').innerHTML = marked.parse(md))
            .catch(() => document.getElementById('content').innerHTML = '<h2>Kunne ikke laste innhold</h2><p>Se på <a href="https://github.com/kjetiljd/meta-repo-workshop/tree/main/workshop/{path}">GitHub</a></p>');
    </script>
</body>
</html>'''

# Workshop directories
dirs = [
    ('workshop', 'Workshop', '../', '../'),
    ('workshop/01-setup', 'Oppgave 1: Oppsett', '../', '../../'),
    ('workshop/02-commands', 'Oppgave 2: Kommandoer', '../', '../../'),
    ('workshop/03-automation', 'Oppgave 3: Automatisering', '../', '../../'),
    ('workshop/04-cross-repo', 'Oppgave 4: Kodeendring', '../', '../../'),
    ('workshop/05-analysis', 'Oppgave 5: Analyse', '../', '../../'),
    ('workshop/06-git-history', 'Oppgave 6: Git-historikk', '../', '../../'),
    ('workshop/07-templates', 'Oppgave 7: Templates', '../', '../../'),
    ('workshop/08-new-meta', 'Oppgave 8: Nytt meta-repo', '../', '../../'),
]

base = Path('/Users/t988833/Projects/kjetiljd/meta-repo-workshop')

for dir_path, title, back, home in dirs:
    full_path = base / dir_path
    full_path.mkdir(parents=True, exist_ok=True)
    
    html = TEMPLATE.format(
        title=title,
        back_url=back,
        home_url=home,
        path=dir_path
    )
    
    (full_path / 'index.html').write_text(html)
    print(f"✓ Created {dir_path}/index.html")

print("\n✅ Done! Now run:")
print("git add workshop/*/index.html")
print("git commit -m 'Add index.html for all workshop pages'")
print("git push")
