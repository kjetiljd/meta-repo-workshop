#!/usr/bin/env python3
"""
Preflight check - Kjør denne før workshopen for å sjekke at alt fungerer
"""

import os
import sys
import subprocess
from pathlib import Path

# Farger
GREEN = '\033[92m'
YELLOW = '\033[93m'
RED = '\033[91m'
BLUE = '\033[94m'
END = '\033[0m'

def check(name, cmd, required=True):
    """Sjekk om en kommando eksisterer"""
    try:
        result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
        if result.returncode == 0:
            print(f"  {GREEN}✓{END} {name}")
            return True
        else:
            if required:
                print(f"  {RED}✗{END} {name} - PÅKREVD")
            else:
                print(f"  {YELLOW}⚠{END} {name} - valgfritt")
            return False
    except:
        if required:
            print(f"  {RED}✗{END} {name} - PÅKREVD")
        else:
            print(f"  {YELLOW}⚠{END} {name} - valgfritt")
        return False

def check_file(name, path, required=True):
    """Sjekk om en fil eksisterer"""
    if Path(path).exists():
        print(f"  {GREEN}✓{END} {name}")
        return True
    else:
        if required:
            print(f"  {RED}✗{END} {name} - MANGLER")
        else:
            print(f"  {YELLOW}⚠{END} {name} - valgfritt")
        return False

def main():
    print(f"{BLUE}═══════════════════════════════════════════{END}")
    print(f"{BLUE}   Meta-Repository Workshop - Preflight Check{END}")
    print(f"{BLUE}═══════════════════════════════════════════{END}")
    print()
    
    errors = 0
    warnings = 0
    
    # Sjekk dependencies
    print(f"{YELLOW}📦 Dependencies:{END}")
    if not check("Git", "git --version"):
        errors += 1
    if not check("Python 3", "python3 --version"):
        errors += 1
    if not check("PyYAML", "python3 -c 'import yaml'"):
        errors += 1
        print(f"     {YELLOW}→ Installer med: pip3 install pyyaml{END}")
    if not check("Docker", "docker --version", required=False):
        warnings += 1
    print()
    
    # Sjekk filer
    print(f"{YELLOW}📁 Workshop-filer:{END}")
    if not check_file("README.md", "README.md"):
        errors += 1
    if not check_file("Presentasjon", "slides/index.html"):
        errors += 1
    if not check_file("Slides innhold", "slides/slides.md"):
        errors += 1
    if not check_file("Workshop oppgave 1", "workshop/01-setup/README.md"):
        errors += 1
    if not check_file("Løsning oppgave 1", "workshop/solutions/01-setup/meta.sh"):
        errors += 1
    if not check_file("Hovedside", "index.html"):
        errors += 1
    print()
    
    # Sjekk instruktør-filer
    print(f"{YELLOW}👨‍🏫 Instruktør-filer:{END}")
    check_file("DEVELOP.md", "DEVELOP.md", required=False)
    check_file("INSTRUCTOR.md", "INSTRUCTOR.md", required=False)
    print()
    
    # Test at server kan startes
    print(f"{YELLOW}🌐 Test webserver:{END}")
    try:
        import http.server
        print(f"  {GREEN}✓{END} HTTP server modul tilgjengelig")
    except:
        print(f"  {RED}✗{END} HTTP server modul mangler")
        errors += 1
    print()
    
    # Oppsummering
    print(f"{BLUE}═══════════════════════════════════════════{END}")
    if errors == 0 and warnings == 0:
        print(f"{GREEN}✅ Alt ser bra ut! Workshopen er klar!{END}")
        print()
        print(f"{YELLOW}Start med:{END}")
        print(f"  python3 test-server.py")
        print(f"  eller")
        print(f"  make serve")
    elif errors == 0:
        print(f"{YELLOW}⚠ Workshop er klar, men noen valgfrie komponenter mangler{END}")
        print(f"  ({warnings} advarsler)")
    else:
        print(f"{RED}❌ Det er problemer som må fikses!{END}")
        print(f"  ({errors} feil, {warnings} advarsler)")
        sys.exit(1)
    print(f"{BLUE}═══════════════════════════════════════════{END}")

if __name__ == "__main__":
    main()
