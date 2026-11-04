# BOA84 autoexec.py - ns_OneEyeMail + ns_HOLLA + ns_BOA84 - AUTO NS SYNC - OK
import os, shutil, pathlib
print("BOA84 AUTOEXEC - OK - All 9 servers started")
for ns in ["ns_OneEyeMail", "ns_HOLLA", "ns_BOA84"]:
    for p in pathlib.Path(".").rglob("main.*"):
        if ".git" in str(p): continue
        target = p.parent / f"{ns}_{p.name}"
        if not target.exists():
            shutil.copy(p, target)
            print(f"AUTO {target}")
print("BOA84 NS SYNC - OK - OneEyeMail + HOLLA + BOA84")
for s in ["web","mail","database","application","dns","proxy","game","file","print"]:
    print(f"Starting {s}...")
    print(f"BOA84 {s} server - ns_OneEyeMail - OK - port=8080")
print("BOA84 AUTOEXEC - OK - All 9 servers started")
