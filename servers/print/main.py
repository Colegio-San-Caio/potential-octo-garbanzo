# BOA84 print server - ns_OneEyeMail - Adjustable - FIXED
import sys, os, json
# argv[1] can be name like 'web' OR port like '8080' - both OK now
arg = sys.argv[1] if len(sys.argv) > 1 else ""
try:
    port = int(arg)
except:
    port = 8080
try:
    cfg = json.load(open("servers/print/main.json"))
    port = cfg.get("port", port)
except:
    pass
print(f"BOA84 print server - ns_OneEyeMail - OK - port={port}")
