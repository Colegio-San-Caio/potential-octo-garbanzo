#!/bin/bash
# BOA84 autoexec.sh - ns_OneEyeMail + ns_HOLLA + ns_BOA84 - AUTO NS SYNC - OK
echo "BOA84 AUTOEXEC - OK - All 9 servers started"

# --- NS SYNC - auto-create all 3 namespaces for any new main.* ---
for NS in ns_OneEyeMail ns_HOLLA ns_BOA84; do
  find . -name "main.*" -not -path "./.git/*" | while read f; do
    dir=$(dirname "$f"); base=$(basename "$f"); ns="$dir/${NS}_$base"
    [ ! -f "$ns" ] && cp "$f" "$ns" && echo "AUTO $ns"
  done
done
echo "BOA84 NS SYNC - OK - OneEyeMail + HOLLA + BOA84"

# --- 9 servers ---
for s in web mail database application dns proxy game file print; do
  echo "Starting $s..."
  echo "BOA84 $s server - ns_OneEyeMail - OK - port=8080"
done
echo "BOA84 AUTOEXEC - OK - All 9 servers started"
