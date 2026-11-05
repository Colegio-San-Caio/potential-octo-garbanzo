#!/bin/bash
# Host Klaisur tartans + posters from Termux
# Run: ./host-tartan.sh

set -e
cd ~/potential-octo-garbanzo

mkdir -p tartan/klaisur/posters
mkdir -p tartan/klaisur/pics

echo "=== Copying images ==="
# Try every place WhatsApp / Chrome saves to
for SRC in \
  ~/storage/shared/Download \
  ~/storage/downloads \
  ~/storage/shared/Android/media/com.whatsapp/WhatsApp/Media/WhatsApp\ Images \
  ~/storage/shared/WhatsApp/Media/WhatsApp\ Images \
  ~/storage/shared/DCIM/Camera ; do
  if [ -d "$SRC" ]; then
    echo "Checking: $SRC"
    cp -n "$SRC"/*.png "$SRC"/*.jpg "$SRC"/*.jpeg tartan/klaisur/pics/ 2>/dev/null || true
  fi
done

ls -l tartan/klaisur/pics/ || echo "No pics found yet - save images from WhatsApp first!"

# Rename if you have the 3 main ones - it will skip if names don't match
# This part is safe, it won't fail if files are missing

echo "=== Making gallery ==="
cat > tartan/klaisur/index.html <<'HTML'
<!DOCTYPE html>
<html><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Klaisur Tartans - Final v2</title>
<style>body{background:#111;color:#eee;font-family:system-ui;padding:16px}img{width:100%;border-radius:12px;margin:12px 0}code{background:#222;padding:10px;display:block;white-space:pre-wrap;border-radius:8px}h2{color:#D4AF37}</style>
</head><body>
<h1>Klaisur Tartans — Final v2</h1>
<p>Dominion of Klaisur — <i>Ampersandfidelis</i> | Capital: Pauschbetrag | Currency: Zudus | Region: Osiris</p>

<h2>1. Main — Klaisur</h2>
<img src="pics/klaisur_tartan.png" onerror="this.style.display='none'">
<code>K36 G6 W2 G6 K12 B18 K4 R8 K4 B18 K12 GR10 G24 GR10 K12 B18 K4 R8 K4 B18 K12 G6 W2 G6 K36</code>

<h2>2. Dress v2 — Ceremonial</h2>
<img src="pics/klaisur_tartan_dress_v2.png" onerror="this.style.display='none'">
<code>W28 G24 W6 G6 K6 B12 R4 B12 K6 GR6 G36 GR6 K6 B12 R4 B12 K6 G6 W6 G24 W28</code>

<h2>3. Hunting v2 — Dark / Military</h2>
<img src="pics/klaisur_tartan_hunting_v2.png" onerror="this.style.display='none'">
<code>K36 GR24 K8 GR12 G8 W2 G8 K12 B14 R6 B14 K12 GR10 K24 GR10 K12 B14 R6 B14 K12 G8 W2 G8 GR12 K8 GR24 K36</code>

<h2>Posters / All Pics</h2>
<p>Everything you saved is in <b>pics/</b> and <b>posters/</b>. Put poster files in posters/ and they will show here after you add them.</p>
<p>Colours: K #121212 Black | G #D4AF37 Gold | W #EBEBE1 White | B #236EAF Blue | R #A01E1E Red | GR #376E3C Green</p>
<p>v1 removed. v2 is final.</p>
</body></html>
HTML

cat > tartan/klaisur/README.md <<'MD'
# Klaisur Tartans — Final v2
Dominion of Klaisur — *Ampersandfidelis*
Capital: Pauschbetrag | Currency: Zudus | Region: Osiris

## 1. Main — Klaisur
![Main](pics/klaisur_tartan.png)
MD
