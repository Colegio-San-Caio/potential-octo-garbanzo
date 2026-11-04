# BOA84 autoexec.py - Compadre Edition
import subprocess, sys
print("BOA84 Starting - OneEyeMail - BLUH - NASA")
for s in ["web","mail","database","application","dns","proxy","game","file","print"]:
    print(f"Starting {s}...")
    subprocess.Popen([sys.executable, f"servers/{s}/main.py", s])
print("BOA84 AUTOEXEC - OK - All 9 servers started")
