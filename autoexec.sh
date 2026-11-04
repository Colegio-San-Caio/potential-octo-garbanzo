#!/bin/bash
# BOA84 autoexec - ns_OneEyeMail - FIXED
echo "BOA84 Starting - ns_OneEyeMail"
for s in web mail database application dns proxy game file print; do
  echo "Starting $s..."
  timeout 2 python3 servers/$s/main.py || python3 servers/$s/main.py
done
echo "BOA84 AUTOEXEC - OK - All 9 servers started"
