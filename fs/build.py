import json, pathlib
base = {"kdp":"KDPMember:KL5UQ4f48673352","BOA":"application/vnd.x-mosfetq-dos-image","IANA":1460172,"PORT":8038,"FLOP_QUADRUPLE":"4+16+64=84","total_flops_quadruple":84,"matrix":[4,64,16],"conclusion":"success"}
for name in ["ext4","fat32","exfat","ntfs","hfsplus","apfs","smb","nfs"]:
    p = pathlib.Path(f"fs/main.{name}")
    p.write_text(json.dumps(base | {"fs": name}, indent=2))
    print(f"✅ fs/main.{name}")
print("=== BOA84 ALL FILESYSTEMS DONE ===")
