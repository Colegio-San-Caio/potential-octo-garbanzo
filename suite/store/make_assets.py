#!/usr/bin/env python3
"""make_assets.py - write the Store logo PNGs (pure Python, no libraries).

usage: python3 make_assets.py [folder]      default: Assets
Each logo is a dark tile with colour bars taken from the characters of the KDP code.
"""
import os
import struct
import sys
import zlib

CODE = "KL5UQ4f48673352"


def png(path, w, h):
    bg = (0x14, 0x18, 0x20)
    rows = bytearray()
    n = len(CODE)
    for y in range(h):
        rows.append(0)                                   # filter: none
        for x in range(w):
            if h * 0.25 <= y < h * 0.75 and w * 0.1 <= x < w * 0.9:
                c = ord(CODE[int((x - w * 0.1) / (w * 0.8) * n) % n])
                px = ((c * 37) % 200 + 55, (c * 91) % 200 + 55, (c * 53) % 200 + 55)
            else:
                px = bg
            rows += bytes(px)
    def chunk(tag, data):
        body = tag + data
        return struct.pack(">I", len(data)) + body + struct.pack(">I", zlib.crc32(body) & 0xFFFFFFFF)
    data = (b"\x89PNG\r\n\x1a\n" + chunk(b"IHDR", struct.pack(">IIBBBBB", w, h, 8, 2, 0, 0, 0))
            + chunk(b"IDAT", zlib.compress(bytes(rows), 9)) + chunk(b"IEND", b""))
    open(path, "wb").write(data)


if __name__ == "__main__":
    folder = sys.argv[1] if len(sys.argv) > 1 else "Assets"
    os.makedirs(folder, exist_ok=True)
    for name, w, h in (("StoreLogo.png", 50, 50), ("Square44x44Logo.png", 44, 44),
                       ("Square150x150Logo.png", 150, 150), ("Wide310x150Logo.png", 310, 150)):
        png(os.path.join(folder, name), w, h)
        print("wrote %s/%s (%dx%d)" % (folder, name, w, h))
