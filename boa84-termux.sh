#!/bin/bash
case "$1" in
  secret)
    echo "BOA84 SECRET - precise scan..."
    grep -R -E -n -f .boa84_secret_pat.txt --exclude-dir=.git --exclude-dir=docs --exclude-dir=website --exclude-dir=precomputer --exclude-dir=fat32_boa84 --exclude="*.abap" . 2>/dev/null | head -20 || echo "NO REAL SECRET"
    ;;
  mail)
    NAME=${2:-Test}
    echo "BOA84 MAIL - ns_oeneyeMail -> $NAME"
    sed "s/{name}/$NAME/g" ns_oeneyeMail
    ;;
  upgrade)
    echo "BOA84 UPGRADE - real-time..."
    for d in website worker precomputer; do echo "=== $d ==="; (cd $d && npm install --legacy-peer-deps 2>&1 | tail -2 || true); done
    ;;
  *) echo "BOA84 usage: boa84 secret | mail {name} | upgrade" ;;
esac
