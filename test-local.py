#!/usr/bin/env python3
"""
Test workshop locally with Python server
"""

import http.server
import socketserver
import webbrowser
import os
from pathlib import Path

# Change to workshop directory
os.chdir('/Users/t988833/Projects/kjetiljd/meta-repo-workshop')

PORT = 8000

print(f"🚀 Starting test server on http://localhost:{PORT}")
print("📁 Serving from:", os.getcwd())
print("\nTest these URLs:")
print(f"  • http://localhost:{PORT}/ - Hovedside")
print(f"  • http://localhost:{PORT}/workshop/ - Workshop med Markdown loader")
print(f"  • http://localhost:{PORT}/workshop/01-setup/ - Oppgave 1 med Markdown")
print(f"  • http://localhost:{PORT}/slides/ - Presentasjon")
print("\nTrykk Ctrl+C for å stoppe\n")

# Start server
with socketserver.TCPServer(("", PORT), http.server.SimpleHTTPRequestHandler) as httpd:
    webbrowser.open(f'http://localhost:{PORT}/workshop/')
    httpd.serve_forever()
