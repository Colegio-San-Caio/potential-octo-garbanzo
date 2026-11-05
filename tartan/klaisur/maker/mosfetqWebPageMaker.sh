#!/bin/bash
# mosfetqWebPageMaker - MACRO
# Connects: index.html + BLUH.bly + copyright.html -> new page
cd ~/potential-octo-garbanzo/tartan/klaisur/maker

echo "=== Fetching 3 sources ==="
curl -sL https://raw.githubusercontent.com/kaiolafketelhut/index.html/main/index.html -o src_index.html || echo "index.html fetch failed"
curl -sL https://raw.githubusercontent.com/kaiolafketelhut/index.html/main/BLUH.bly -o src_BLHU.bly || echo "BLUH.bly fetch failed"
curl -sL https://raw.githubusercontent.com/kaiolafketelhut/demo-repository/main/copyright.html -o src_copyright.html || echo "copyright fetch failed"

# Fallback if GitHub is private/404 - use your local Klausur files
[ ! -s src_index.html ] && cp ../index.html src_index.html
[ ! -s src_BLHU.bly ] && echo "BLUH MACRO: OENEYE + Klausur + TRAFO + MAIN ENERGY" > src_BLHU.bly
[ ! -s src_copyright.html ] && echo "<footer>© 2026 Colegio-San-Caio / mosfetq - All rights reserved - OENEYE</footer>" > src_copyright.html

TITLE=${1:-"My mosfetq Page"}
BODY=${2:-"<h1>$TITLE</h1><p>Made with mosfetqWebPageMaker</p>"}

cat > "made_${TITLE// /_}.html" <<EOF
<!DOCTYPE html>
<html><head><meta name="viewport" content="width=device-width, initial-scale=1"><title>$TITLE</title></head>
<body style="background:#000;color:#fff;font-family:sans-serif;padding:20px">
<!-- MACRO: BLUH.bly -->
<!-- $(cat src_BLHU.bly) -->
$BODY
<hr>
<!-- MACRO: copyright.html -->
$(cat src_copyright.html)
<p><a href="../index.html" style="color:#0f0">← Back to Klausur</a></p>
</body></html>
EOF

echo "Made: made_${TITLE// /_}.html"
ls -l made_*.html
