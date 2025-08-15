#!/usr/bin/env python3
"""
Simple test server for workshop - no Docker required
"""

import http.server
import socketserver
import os
import sys
import webbrowser
from pathlib import Path

# Farger for terminal output
class Colors:
    GREEN = '\033[92m'
    YELLOW = '\033[93m'
    BLUE = '\033[94m'
    RED = '\033[91m'
    END = '\033[0m'

def print_colored(text, color):
    print(f"{color}{text}{Colors.END}")

class WorkshopHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):
    """Custom handler with better MIME types"""
    
    def end_headers(self):
        # Add CORS headers for local development
        self.send_header('Access-Control-Allow-Origin', '*')
        super().end_headers()
    
    def guess_type(self, path):
        mimetype = super().guess_type(path)
        if path.endswith('.md'):
            return ('text/markdown', None)
        return mimetype

def run_server(port=8000):
    """Run the test server"""
    
    # Change to workshop directory
    workshop_dir = Path(__file__).parent
    os.chdir(workshop_dir)
    
    print_colored("🚀 Meta-Repository Workshop - Test Server", Colors.BLUE)
    print()
    
    try:
        with socketserver.TCPServer(("", port), WorkshopHTTPRequestHandler) as httpd:
            print_colored(f"✅ Server kjører på port {port}", Colors.GREEN)
            print()
            print_colored("📚 Tilgjengelige URLer:", Colors.BLUE)
            print(f"  • Hovedside:    http://localhost:{port}")
            print(f"  • Presentasjon: http://localhost:{port}/slides/")
            print(f"  • Workshop:     http://localhost:{port}/workshop/")
            print(f"  • Ressurser:    http://localhost:{port}/resources/")
            print()
            print_colored("💡 Tips:", Colors.YELLOW)
            print("  • Trykk Ctrl+C for å stoppe serveren")
            print("  • Trykk 'S' i presentasjonen for speaker notes")
            print("  • Trykk 'F' for fullskjerm i presentasjonen")
            print()
            
            # Åpne nettleser automatisk
            if len(sys.argv) > 1 and sys.argv[1] == '--no-browser':
                print("Hopper over automatisk åpning av nettleser")
            else:
                print_colored(f"Åpner http://localhost:{port} i nettleseren...", Colors.YELLOW)
                webbrowser.open(f'http://localhost:{port}')
            
            print_colored("Server kjører... Trykk Ctrl+C for å stoppe", Colors.GREEN)
            httpd.serve_forever()
            
    except KeyboardInterrupt:
        print()
        print_colored("👋 Stopper server...", Colors.YELLOW)
        sys.exit(0)
    except OSError as e:
        if e.errno == 48:  # Port already in use
            print_colored(f"❌ Port {port} er allerede i bruk!", Colors.RED)
            print(f"Prøv en annen port: python3 test-server.py {port + 1}")
        else:
            print_colored(f"❌ Feil: {e}", Colors.RED)
        sys.exit(1)

if __name__ == "__main__":
    port = 8000
    if len(sys.argv) > 1 and sys.argv[1].isdigit():
        port = int(sys.argv[1])
    elif len(sys.argv) > 2 and sys.argv[2].isdigit():
        port = int(sys.argv[2])
    
    run_server(port)
