# BOA84 autoexec.py - ns_OneEyeMail - FIXED
import subprocess, sys
print("BOA84 Starting - ns_OneEyeMail")
for s in ["web","mail","database","application","dns","proxy","game","file","print"]:
    print(f"Starting {s}...")
    subprocess.run([sys.executable, f"servers/{s}/main.py"], timeout=2)
print("BOA84 AUTOEXEC - OK")
