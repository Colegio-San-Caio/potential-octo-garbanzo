#!/bin/bash
# BOA84-TERMUX - TERMUX ONLY - SAP MAIN - OK
echo "BOA84-TERMUX - Starting..."
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
  echo "STOP! You are on Windows! Use boa84.ps1, NOT boa84-termux.sh"
  exit 1
fi
# FIX: check for NESTED clone with ABSOLUTE path, not relative!
if [ -d "$HOME/potential-octo-garbanzo/potential-octo-garbanzo" ]; then
  echo "STOP! Nested clone found! Run: rm -rf $HOME/potential-octo-garbanzo/potential-octo-garbanzo"
  exit 1
fi
cd "$HOME/potential-octo-garbanzo" || { echo "Repo not found!"; exit 1; }
for NS in ns_OneEyeMail ns_HOLLA ns_BOA84; do
  find . -name "main.*" -not -path "./.git/*" | while read f; do
    dir=$(dirname "$f"); base=$(basename "$f"); ns="$dir/${NS}_$base"
    [ ! -f "$ns" ] && cp "$f" "$ns" && echo "AUTO $ns"
  done
done
echo "BOA84 NS SYNC - OK - OneEyeMail + HOLLA + BOA84"
bash autoexec.sh | tail -3
if [ -n "$(git status --porcelain)" ]; then
  git add -A
  git commit -m "TERMUX AUTO - $(date '+%Y-%m-%d %H:%M')" 2>/dev/null
  git pull --rebase 2>/dev/null
  git push origin HEAD 2>/dev/null && echo "BOA84-TERMUX - PUSHED - OK"
else
  echo "BOA84-TERMUX - Nothing new - OK"
fi
cd "$HOME"
echo "BOA84-TERMUX - DONE - You are back in HOME"
