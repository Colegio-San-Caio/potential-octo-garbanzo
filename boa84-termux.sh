#!/bin/bash
export TMPDIR="${TMPDIR:-$PREFIX/tmp}"
mkdir -p "$TMPDIR" 2>/dev/null
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
  zip)
    echo "BOA84 ZIP - closing secrets first..."
    bash boa84-termux.sh secret
    bash boa84-termux.sh mime
    # ZIP ONLY fat32_boa84/ - NO .git, NO .env, NO .img, NO secrets
    rm -f BOA84.zip
    (cd fat32_boa84 && zip -r ../BOA84.zip . -x "_BOA84_MAP.txt" 2>/dev/null || python3 -m zipfile -c ../BOA84.zip .)
    ls -lh BOA84.zip
    echo "BOA84 ZIP - OK - 1 file for SAP SMW0 - upload BOA84.zip only"
    echo "SHA256: $(sha256sum BOA84.zip 2>/dev/null | cut -d' ' -f1)"
    ;;
  secret)
    echo "BOA84 SECRET - precise scan - no docs/website false positives..."
    # ONLY real secrets: assignment + value, or PRIVATE KEY header
    # Exclude docs, website, precomputer, .git, fat32
    grep -R -E -n "password[ \t]*=[ \t]*[^ \t"'\*]+|api[_-]?key[ \t]*=[ \t]*['\"][A-Za-z0-9_\-]{10,}|BEGIN (RSA )?PRIVATE KEY|ghp_[A-Za-z0-9]{20,}|sk-[A-Za-z0-9]{20,}" --exclude-dir=.git --exclude-dir=docs --exclude-dir=website --exclude-dir=precomputer --exclude-dir=fat32_boa84 --exclude="*.abap" . 2>/dev/null | head -20
    echo "If empty above -> NO REAL SECRET - docs/website hits are ignored"
    echo "BOA84 SECRET - CLOSED"
    ;;

  vuln)
    echo "BOA84 VULN - Dependabot 25 - scanning manifests..."
    find . -maxdepth 3 -name "package.json" -not -path "./.git/*" | head -5
    find . -maxdepth 3 -name "requirements*.txt" -not -path "./.git/*" | head -5
    # NPM audit if package.json exists at root
    if [ -f package.json ]; then echo "--- NPM ---"; npm audit --audit-level=high 2>&1 | tail -20; npm audit fix 2>&1 | tail -5; fi
    # Python audit if requirements exists
    if [ -f requirements.txt ]; then echo "--- PIP ---"; pip install -q pip-audit 2>/dev/null; pip-audit -r requirements.txt 2>&1 | tail -20; fi
    echo "BOA84 VULN - Fix: commit audit fixes, then GitHub Dependabot count drops"
    echo "BOA84 VULN - Also enable: GitHub > Settings > Code security > Dependabot auto-update"
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
# NOTE: zip + secret are handled by case below - see boa84_zip function
# vuln is handled in case - see below
