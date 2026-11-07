#!/bin/sh
echo "bluh: checking potential-octo-garbanzo..."
[ -f fnt/MAIN.FNT ] && echo "OK fnt/MAIN.FNT" || echo "FAIL fnt/MAIN.FNT missing"
ls *.bak *.BAK 2>/dev/null && echo "FAIL .bak exists" || echo "OK no .bak"
ls fnt/*.bak fnt/*.BAK 2>/dev/null && echo "FAIL fnt/.bak exists" || echo "OK no fnt/.bak"
grep -q "BOA84 - CLEAN CANARY" index.html 2>/dev/null && echo "OK canary index.html BOA84" || echo "FAIL canary index.html missing"
[ -f cover.jpg ] && echo "FAIL cover.jpg should NOT be here" || echo "OK no cover.jpg"
echo "bluh: done"
