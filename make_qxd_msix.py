#!/usr/bin/env python3
"""make_qxd_msix.py - Assemble qxd.msix package (Open Packaging Conventions / ZIP format)."""
import os
import zipfile
import pathlib
import sys

def build_qxd_msix(output_path="qxd.msix"):
    layout_dir = pathlib.Path("qxd_layout")
    layout_dir.mkdir(exist_ok=True)
    assets_dir = layout_dir / "Assets"
    assets_dir.mkdir(exist_ok=True)

    # 1. Generate assets using make_assets logic or copying
    from suite.store.make_assets import png
    for name, w, h in (("StoreLogo.png", 50, 50), ("Square44x44Logo.png", 44, 44),
                       ("Square150x150Logo.png", 150, 150), ("Wide310x150Logo.png", 310, 150)):
        png(str(assets_dir / name), w, h)

    # 2. Write AppxManifest.xml for QxD
    manifest_content = """<?xml version="1.0" encoding="utf-8"?>
<Package xmlns="http://schemas.microsoft.com/appx/manifest/foundation/windows10"
         xmlns:uap="http://schemas.microsoft.com/appx/manifest/uap/windows10"
         xmlns:rescap="http://schemas.microsoft.com/appx/manifest/foundation/windows10/restrictedcapabilities"
         IgnorableNamespaces="uap rescap">
  <Identity Name="KaiOlafKetelhut.QxD" Publisher="CN=88544420-228E-4D31-8839-1D4CADF99C43" Version="1.0.0.0" ProcessorArchitecture="x64" />
  <Properties>
    <DisplayName>QxD</DisplayName>
    <PublisherDisplayName>Kai Olaf Ketelhut</PublisherDisplayName>
    <Logo>Assets\\StoreLogo.png</Logo>
  </Properties>
  <Dependencies>
    <TargetDeviceFamily Name="Windows.Desktop" MinVersion="10.0.17763.0" MaxVersionTested="10.0.22621.0" />
  </Dependencies>
  <Resources>
    <Resource Language="en-us" />
  </Resources>
  <Applications>
    <Application Id="QxDEvaluator" Executable="qxd_eval.exe" EntryPoint="Windows.FullTrustApplication">
      <uap:VisualElements DisplayName="QxD Evaluator" Description="QxD Layer L3 state evaluation engine for oeneyeOS"
          BackgroundColor="#141820" Square150x150Logo="Assets\\Square150x150Logo.png" Square44x44Logo="Assets\\Square44x44Logo.png">
        <uap:DefaultTile Wide310x150Logo="Assets\\Wide310x150Logo.png" />
      </uap:VisualElements>
    </Application>
  </Applications>
  <Capabilities>
    <rescap:Capability Name="runFullTrust" />
  </Capabilities>
</Package>
"""
    (layout_dir / "AppxManifest.xml").write_text(manifest_content, encoding="utf-8")

    # 3. Write [Content_Types].xml
    content_types = """<?xml version="1.0" encoding="utf-8"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
  <Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>
  <Default Extension="xml" ContentType="application/xml"/>
  <Default Extension="png" ContentType="image/png"/>
  <Default Extension="py" ContentType="text/plain"/>
  <Default Extension="qxd" ContentType="text/plain"/>
</Types>
"""
    (layout_dir / "[Content_Types].xml").write_text(content_types, encoding="utf-8")

    # 4. Copy qxd_eval.py, test_qxd_eval.py, and sandbox files
    import shutil
    shutil.copy("qxd_eval.py", layout_dir / "qxd_eval.py")
    shutil.copy("test_qxd_eval.py", layout_dir / "test_qxd_eval.py")
    
    sb_layout = layout_dir / "sandbox"
    sb_layout.mkdir(exist_ok=True)
    for qxd_file in pathlib.Path("sandbox").glob("*.qxd"):
        shutil.copy(qxd_file, sb_layout / qxd_file.name)

    # 5. Pack into ZIP / MSIX archive
    out_file = pathlib.Path(output_path)
    with zipfile.ZipFile(out_file, "w", zipfile.ZIP_DEFLATED) as zf:
        for p in layout_dir.rglob("*"):
            if p.is_file():
                zf.write(p, p.relative_to(layout_dir))

    print(f"Successfully generated {out_file} ({out_file.stat().st_size} bytes)")

if __name__ == "__main__":
    build_qxd_msix()
