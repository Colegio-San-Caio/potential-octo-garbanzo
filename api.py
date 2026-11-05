import json
from http.server import BaseHTTPRequestHandler, HTTPServer
from pathlib import Path

class H(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == "/api/pics":
            pics = sorted([p.name for p in Path("tartan/klaisur/pics").glob("*.jpg")])
            data = {"name": "klaisur", "count": len(pics), "pics": pics}
            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.send_header("Access-Control-Allow-Origin", "*")
            self.end_headers()
            self.wfile.write(json.dumps(data).encode())
        else:
            self.send_response(404); self.end_headers()
            self.wfile.write(b'{"error":"try /api/pics"}')
    def log_message(self, *a): pass

print("API on http://localhost:8082/api/pics")
HTTPServer(("0.0.0.0", 8082), H).serve_forever()
