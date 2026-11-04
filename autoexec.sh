#!/bin/bash
# BOA84 FAT32 KDP - autoexec.sh - Compadre Edition
echo "BOA84 Starting - OneEyeMail - BLUH - NASA"
for s in web mail database application dns proxy game file print; do
  echo "Starting $s..."
  python3 servers/$s/main.py "$s" &
done
echo "BOA84 AUTOEXEC - OK - All 9 servers started"
wait
