# BOA84 FAT32 KDP - print server - ADJUSTABLE
import json, sys, os
try:
    cfg = json.load(open("servers/config.json"))["print"]
except:
    cfg = {"port": 0, "mode": "main"}
port = int(sys.argv[1]) if len(sys.argv) > 1 else int(os.environ.get("BOA84_PORT", cfg["port"]))
mode = sys.argv[2] if len(sys.argv) > 2 else os.environ.get("BOA84_MODE", cfg["mode"])
print(f"BOA84 print server - OK - port={port} mode={mode}")
