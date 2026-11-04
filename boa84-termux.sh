#!/bin/bash
# BOA84-TERMUX - boa84 [mime|status|push|ns] - SAP MAIN - OK
# Usage: boa84        = full auto (default)
#        boa84 mime   = FAT32-safe copy for SAP SMW0 / SE78 / SE80
#        boa84 status = counts only
#        boa84 push   = git push only
#        boa84 ns     = NS sync only
cd "$HOME/potential-octo-garbanzo" || exit 1
case "$1" in
  mime)
    echo "BOA84 MIME - FAT32 / exFAT safe - for USB -> SAP SMW0..."
    rm -rf fat32_boa84; mkdir -p fat32_boa84
    # ns_OneEyeMail_main.html -> ONEYEMAIL_MAIN_HTML
    # ns_HOLLA_main.py -> HOLLA_MAIN_PY
    # ns_BOA84_main.abap -> BOA84_MAIN_ABAP
    find . -name "ns_*" -not -path "./.git/*" -not -path "./fat32_boa84/*" | while read f; do
      base=$(basename "$f" | tr 'a-z' 'A-Z')
      base=${base#NS_}           # remove NS_
      base=${base//./_}          # . -> _
      base=${base//-/_}          # - -> _
      # FAT32: keep first 30 chars for SE78, keep full for SMW0 list
      echo "$f -> $base" >> fat32_boa84/_BOA84_MAP.txt
      cp "$f" "fat32_boa84/$base" 2>/dev/null
    done
    echo "BOA84 MIME - OK - $(ls fat32_boa84 | wc -l) files in fat32_boa84/"
    echo "BOA84 MIME - MAP in fat32_boa84/_BOA84_MAP.txt"
    echo "Copy fat32_boa84/ to USB -> SAP -> SMW0 -> /SAP/PUBLIC/BOA84/"
    ;;
  status)
    echo "main.* = $(find . -name "main.*" | wc -l)"
    echo "ns_OneEyeMail* = $(find . -name "ns_OneEyeMail*" | wc -l)"
    echo "ns_HOLLA* = $(find . -name "ns_HOLLA*" | wc -l)"
    echo "ns_BOA84* = $(find . -name "ns_BOA84*" | wc -l)"
    echo "fat32_boa84/ = $(ls fat32_boa84 2>/dev/null | wc -l)"
    ;;
  push)
    git add -A; git commit -m "boa84 push - $(date '+%Y-%m-%d %H:%M')" 2>/dev/null; git pull --rebase; git push origin HEAD
    ;;
  ns)
    for NS in ns_OneEyeMail ns_HOLLA ns_BOA84; do
      find . -name "main.*" -not -path "./.git/*" | while read f; do
        dir=$(dirname "$f"); base=$(basename "$f"); ns="$dir/${NS}_$base"
        [ ! -f "$ns" ] && cp "$f" "$ns" && echo "AUTO $ns"
      done
    done
    echo "BOA84 NS SYNC - OK"
    ;;
  *)
    echo "BOA84-TERMUX - Starting..."
    bash boa84-termux.sh ns
    bash autoexec.sh | tail -3
    if [ -n "$(git status --porcelain)" ]; then
      git add -A; git commit -m "TERMUX AUTO - $(date '+%Y-%m-%d %H:%M')" 2>/dev/null; git pull --rebase 2>/dev/null; git push origin HEAD 2>/dev/null && echo "BOA84-TERMUX - PUSHED - OK"
    else echo "BOA84-TERMUX - Nothing new - OK"; fi
    ;;
esac
cd "$HOME"; echo "BOA84-TERMUX - DONE"
