# BOA84 FAT32 KDP - mail server - ADJUSTABLE - OneEyeMail
import json, sys, os
# Simulates: user can make email + write email
# Frontend in index.html saves to localStorage, this is the backend logic
to = sys.argv[1] if len(sys.argv) > 1 else "user@example.com"
subject = sys.argv[2] if len(sys.argv) > 2 else "BOA84 Test"
body = sys.argv[3] if len(sys.argv) > 3 else "Hello from OneEyeMail"
print(f"BOA84 mail server - OK - to={to} subject={subject} body={body[:40]}")
