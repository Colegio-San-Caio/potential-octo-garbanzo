import json
from http.server import BaseHTTPRequestHandler, HTTPServer
from pathlib import Path

def get_pics():
    pics = sorted([p.name for p in Path("tartan/klaisur/pics").glob("*.jpg")])
    return {"name": "klaisur", "count": len(pics), "pics": pics}

class H(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == "/api/pics":
            self.send_json(get_pics())
        else:
            self.send_json({"error": "try /api/pics or POST /graphql"}, 404)
    def do_POST(self):
        if self.path == "/graphql":
            body = self.rfile.read(int(self.headers.get('Content-Length', 0))).decode()
            data = get_pics()
            # Mini GraphQL: if query asks only for count, return only count
            if "count" in body and "pics" not in body:
                self.send_json({"data": {"count": data["count"]}})
            elif "pics" in body and "count" not in body:
                self.send_json({"data": {"pics": data["pics"]}})
            else:
                self.send_json({"data": data})
        else:
            self.send_json({"error": "not found"}, 404)
    def send_json(self, obj, code=200):
        self.send_response(code)
        self.send_header("Content-Type", "application/json")
        self.send_header("Access-Control-Allow-Origin", "*")
        self.end_headers()
        self.wfile.write(json.dumps(obj).encode())
    def log_message(self, *a): pass

print("API on 8082 - REST + GraphQL")
HTTPServer(("0.0.0.0", 8082), H).serve_forever()
