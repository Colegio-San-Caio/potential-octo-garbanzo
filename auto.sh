#!/bin/bash
cd ~/potential-octo-garbanzo
while true; do
  git add tartan/klaisur/ api.py 2>/dev/null
  if ! git diff --cached --quiet; then
    git commit -m "Auto: Klaisur update $(date '+%Y-%m-%d %H:%M')" >/dev/null
    git pull --rebase origin main >/dev/null 2>&1
    git push origin main
    echo "Pushed new pics + poster + demos"
  fi
  sleep 10
done
