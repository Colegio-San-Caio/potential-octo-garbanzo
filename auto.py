import os, glob
base = "tartan/klaisur"
pics = sorted(glob.glob(f"{base}/pics/*.*"))
html = "<html><head><meta name='viewport' content='width=device-width,initial-scale=1'><style>body{background:#111;color:#eee;font-family:system-ui;padding:16px}img{width:100%;border-radius:12px;margin:12px 0}code{background:#222;padding:10px;display:block;white-space:pre-wrap}</style></head><body><h1>Klaisur Tartans — Auto Gallery</h1>"
md = "# Klaisur Tartans — Auto Gallery\n\n"
for p in pics:
    name = os.path.basename(p)
    html += f"<h2>{name}</h2><img src='pics/{name}'>"
    md += f"## {name}\n![{name}](pics/{name})\n\n"
html += "<h2>Setts — Final v2</h2><code>Main: K36 G6 W2 G6 K12 B18 K4 R8 K4 B18 K12 GR10 G24 GR10 K12 B18 K4 R8 K4 B18 K12 G6 W2 G6 K36\n\nDress v2: W28 G24 W6 G6 K6 B12 R4 B12 K6 GR6 G36 GR6 K6 B12 R4 B12 K6 G6 W6 G24 W28\n\nHunting v2: K36 GR24 K8 GR12 G8 W2 G8 K12 B14 R6 B14 K12 GR10 K24 GR10 K12 B14 R6 B14 K12 G8 W2 G8 GR12 K8 GR24 K36</code></body></html>"
md += "## Setts\nMain: `K36 G6 W2 G6 K12 B18 K4 R8 K4 B18 K12 GR10 G24 GR10 K12 B18 K4 R8 K4 B18 K12 G6 W2 G6 K36`\n\nDress v2: `W28 G24 W6 G6 K6 B12 R4 B12 K6 GR6 G36 GR6 K6 B12 R4 B12 K6 G6 W6 G24 W28`\n\nHunting v2: `K36 GR24 K8 GR12 G8 W2 G8 K12 B14 R6 B14 K12 GR10 K24 GR10 K12 B14 R6 B14 K12 G8 W2 G8 GR12 K8 GR24 K36`\n"
open(f"{base}/index.html","w").write(html)
open(f"{base}/README.md","w").write(md)
print(f"Built gallery with {len(pics)} pics")
