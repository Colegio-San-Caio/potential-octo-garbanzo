#!/usr/bin/env python3
"""cp.py - DOS code-page fonts for the KDP profile: MAIN437.FNT, MAIN850.FNT (and MAIN.FNT = CP437).

usage: python3 cp.py [folder]       writes the three fonts, reads them back, prints a few glyphs
Each file is a raw 8x16 VGA font: 256 glyphs x 16 bytes, one byte per row, bit 7 = leftmost pixel.
Letters, accents and symbols are rasterized from DejaVu Sans Mono (free licence) and packed below;
box-drawing and block glyphs are drawn by the code, so lines join up between cells.
Linux: setfont MAIN437.FNT
"""
import base64
import os
import sys
import zlib

DATA = """
eNpdV3mQFOUV/5hpp6bKKdJFWdhYU9g79E4GXHU0mHSwXcd20hlx3cAaFSdK2nHSMUDiZk1wY9Ym
m/g3BWtSpfiPiBrQHEbxADUii4jimRPJqTnIoQkhJprDXd/19XTziu3p78f73vW9773Xqk8BWUgm
/OCigg8HSGlaBH/z5p20wXFmaq0W/TfhXthwSznfw/d+fISbNkXW8IknzsVFlVhsu77ywP5gGS4+
iA8TKJFcU6pYtEwiq1gEZLFStmkWiUzTBmQJcTZct6F3naZEUKxlDagegScAnp6sPfk9I8ODzzPx
UTAM0mSHIL9OG7qB3/aDLm08Cx8u21McxMXZhDQLRsmqhzEuPqQRz8gFtGspPkrlkxynGRsGLs7B
x0SjMW4UCk0XFx/GR9luXBX5fkS7PoIP4C+hQWQKMXoR2BIJz0fFwiAaLBj038tSLrFf52YQjIbE
IFcOw3KOXs+TSMT0D2lQSaALBQn1+aQL7IHc4EATXu74G6c2TW1s2GWlLmBNruN0Y38vLnzyNPAD
+sPFhbSrEjYajbBSxkUTH+PNwPf9oDmOi4+RMWEY0h8ugjQS4uLjJAfEDPt+h1yiZAQhfowPXFxE
uywmkrNcvEAaIl0X065ma3S8BSbgYoiyV4h2XUImRNHydlskD+Oj0xkbGVk+HJBxn+CzQNU+Z8sK
8j3qdKIJsXllhgdzYYTjA36DcgrNpXKZQq8g+fNJfMyKF3Sml2lPfZ0tlzMSdB2nxjxX4GPyG3vb
7XYUdXGxingcBw8ooNO5kpDAcRPJbYpYwYB7aLPvn4IomwnhgV1Fhx/adDUNo6DU1b1bAYSJuJoy
wXP85JZ9WmVpVmFIbDONXSOXtJkbDAJKwQ5oAoIo+hBGRK5lnrINMbUpf8C5AtBgFOBFQOQzIify
4wbnRqTUXItrhJSJz0qi8y4Drs91ogvuU8Bn+jnwAS9eL3/WQI1K1QBrVK3lXInWjY+vizrIs06p
0SRgVP0+z7rWt0eQ8PULjKR0XS82d5P8GRUe9h0sU1/M2JzL5dSYIPW6DYSvNzDidkPPaJKcL3GB
ZN8X4uLLzEO6OWLrGYFccAY4E25kZPLrmEBU4sdlFyUQHexXZBcklYe1JVQ3SSGBBKrbFLGvQu3D
hjJqYhBL6BDX/YSUupkjZpVQiDmqkjIE+Fx52ZrUMVOy9S5cF4vlJbXrakvK2DC2UWbMq9cn6vU6
ibhbap0HFnKtu0f8jK1Ycv5e3YlM/fNt7lZ1t1ktl6iwbk/6nKYdxOPv2rp1Fzc9dR/F3fAcT5fY
+4XXabVk83f09jjH5qjvquPpeyL5nl1bRfL3U52L6QGKBdzlBPmBUsk5c/geJHtKRTPZ+hBbaHGv
QNqJrclKS344nRs3YdY9Qhk2NjZ2dg4JFo9mWyfQYxnr4GKoXbpXJtp3EwKzhKudeVzYB+bPH6Dq
rZ7A0guZvN7dY5SMhVAhn+wh5ZxRhPz9IaaFWTd7PE8l1lhYt7qu2oM9KtOJnlbF45C9EMAsMq2W
DmSRfXjsGeQZCjuUtgTZT/Gp1WrDrfEDG3HxbLbHGZY6oMxitqM9h/ZkkOfRngxyELVnkBfQr0xH
e5HkpJGXSE4aeZnkpJFXdM89pnvuq+h7pqP9CHVlOtqPUVcG+QnqyiA/RTkZ5GeoPYP8XOoGxFE6
xCEaXqJg+chYp4tJoF5D7Zkedxi1Z5BfoPYM8kvUlUF+RbvSPe7X1N8nOp2O7su/wXrZbK1aNQRD
CLW333JvSnWi1/mmpJA36Aqmkd/htDeQRn7PdSOF/IGvbQr5o1SEUxZsOHSITudItsdB/vwJlnUz
3dH+jPYU08hfxJ4e8lfR3kPeZL9SHe0t9iuF/I3lpJC/s5wUchTMKbslkKzP9B/se6qjHZMY9jra
PyWGPeRtsbmH/Eti2EP+LV70kHf0dY91BXpXd8bhEZkT/sPaUz3uv6w9hfyPtaeQ/7OuFPIe70r1
uJnMTIIVcpZ39XjmnCVdOInYnClFI0isu56dv1XPtKHMtPnb9ATQFk/z25jHNvU8lr+X5Xqr26s9
C+t4fofMOkgOHl5eesGy4ea+5hB+EuR30lBpExfdi7zU+cHQdsMQPc3vkTzsIkWITAsPfAOJPfuE
x9LNPL+fkQEYE9Aiy7JPPm7Om7UrUp89T/qFzUMZULcLP4hsULo9yEabuvDRB57a+fbU5s1YV/s2
aaGNGf4o6dusJeu5rm9K8xRmCsxzq+6MQGRA3zc1TzATMM+3UnKYZ3sP8Sw0t7LgeC8qp+BokVNG
067VSHtloQiOtty+JSKeU9lgJB5qKotl0uMqhUgrGXZk3Klcoz/I9CdZpasnmRAGGYQqMuU2vILX
IGSRjBRQVPErCJFkvI7lg3mRrQrQnlO0qE8l7xiiFWH/nXJ0TCCoP5lbYE2//Q8mI4DnxTHy7Bbk
a0dn3qVc6n+CgZl4wnMtNKVf8kfN+cCGU/PEc1BHY3JyModO9h9iNUemp4+wtv7XGJl+EhS9dwe8
Vfk7twubbuMZqcrfuRPt2dnDMSPJ4GFIFKocgwEIjse9oMrdJ39C65ZbWtQGqyF75YJTEe+iLw7T
9ax4hk+wSpF3MDQeuaWqkaTGRIKsoclmLh3JKI601bXEwhkSRpCc7wPEZYBs
"""

SYMS = "\u263a\u263b\u2665\u2666\u2663\u2660\u2022\u25d8\u25cb\u25d9\u2642\u2640\u266a\u266b\u263c\u25ba\u25c4\u2195\u203c\u00b6\u00a7\u25ac\u21a8\u2191\u2193\u2192\u2190\u221f\u2194\u25b2\u25bc"
HOUSE = 0x2302

# arms: up, down, left, right; 0 none, 1 single line, 2 double line
BOX = {
 0x2502:(1,1,0,0), 0x2524:(1,1,1,0), 0x2561:(1,1,2,0), 0x2562:(2,2,1,0), 0x2556:(0,2,1,0),
 0x2555:(0,1,2,0), 0x2563:(2,2,2,0), 0x2551:(2,2,0,0), 0x2557:(0,2,2,0), 0x255D:(2,0,2,0),
 0x255C:(2,0,1,0), 0x255B:(1,0,2,0), 0x2510:(0,1,1,0), 0x2514:(1,0,0,1), 0x2534:(1,0,1,1),
 0x252C:(0,1,1,1), 0x251C:(1,1,0,1), 0x2500:(0,0,1,1), 0x253C:(1,1,1,1), 0x255E:(1,1,0,2),
 0x255F:(2,2,0,1), 0x255A:(2,0,0,2), 0x2554:(0,2,0,2), 0x2569:(2,0,2,2), 0x2566:(0,2,2,2),
 0x2560:(2,2,0,2), 0x2550:(0,0,2,2), 0x256C:(2,2,2,2), 0x2567:(1,0,2,2), 0x2568:(2,0,1,1),
 0x2564:(0,1,2,2), 0x2565:(0,2,1,1), 0x2559:(2,0,0,1), 0x2558:(1,0,0,2), 0x2552:(0,1,0,2),
 0x2553:(0,2,0,1), 0x256B:(2,2,1,1), 0x256A:(1,1,2,2), 0x2518:(1,0,1,0), 0x250C:(0,1,0,1),
}

def box(up, down, left, right):
    g = [[0] * 8 for _ in range(16)]
    def hl(r, a, b):
        for x in range(a, b + 1): g[r][x] = 1
    def vl(c, a, b):
        for y in range(a, b + 1): g[y][c] = 1
    V = max(up, down); H = max(left, right)
    # ---- both axes single, or only one axis present ----
    if H == 0:
        cols = [4] if V == 1 else [3, 5]
        for c in cols:
            vl(c, 0, 15)
        return g
    if V == 0:
        for r in ([8] if H == 1 else [7, 9]): hl(r, 0, 7)
        return g
    if H == 1:
        vcols = [4] if V == 1 else [3, 5]
        a = 0 if left else (vcols[-1] if V == 2 else 4)
        b = 7 if right else (vcols[0] if V == 2 else 4)
        if left and right: a, b = 0, 7
        hl(8, a, b)
        for c in vcols:
            if up: vl(c, 0, 8)
            if down: vl(c, 8, 15)
        return g
    # H == 2 from here
    if V == 1:                                   # single vertical, double horizontal
        a = 0 if left else 4
        b = 7 if right else 4
        hl(7, a, b); hl(9, a, b)
        if up and down: vl(4, 0, 15)
        elif up: vl(4, 0, 7 if (left and right) else 9)
        elif down: vl(4, 9 if (left and right) else 7, 15)
        return g
    # V == 2 and H == 2 : the double-line family
    # columns
    for c, side_arm in ((3, left), (5, right)):
        if side_arm:                             # arm side: broken in the middle
            if up: vl(c, 0, 7)
            if down: vl(c, 9, 15)
        else:                                    # outer / through column
            if up and down: vl(c, 0, 15)
            elif up: vl(c, 0, 9)
            elif down: vl(c, 7, 15)
    # rows
    for r, is_top in ((7, True), (9, False)):
        if left and right:
            a, b = 0, 7
            hl(r, 0, 3); hl(r, 5, 7)
            if (is_top and not up) or ((not is_top) and not down): hl(r, 4, 4)
            continue
        if left:                                 # arm on the left only; ends on the right
            if down and not up: b = 5 if is_top else 3
            elif up and not down: b = 3 if is_top else 5
            else: b = 3
            hl(r, 0, b)
        else:                                    # arm on the right only; starts on the left
            if down and not up: a = 3 if is_top else 5
            elif up and not down: a = 5 if is_top else 3
            else: a = 5
            hl(r, a, 7)
    return g

BLOCKS = {  # 8 rows of 16: shades and halves
    0x2591: [0x22, 0x88] * 8, 0x2592: [0x55, 0xAA] * 8, 0x2593: [0xDD, 0x77] * 8,
    0x2588: [0xFF] * 16, 0x2584: [0] * 8 + [0xFF] * 8, 0x2580: [0xFF] * 8 + [0] * 8,
    0x258C: [0xF0] * 16, 0x2590: [0x0F] * 16,
}


def glyph_table():
    raw = zlib.decompress(base64.b64decode("".join(DATA.split())))
    return {int.from_bytes(raw[i:i + 2], "big"): raw[i + 2:i + 18] for i in range(0, len(raw), 18)}


def box_bytes(arms):
    g = box(*arms)
    return bytes(sum(0x80 >> x for x in range(8) if row[x]) for row in g)


def build(codec, table):
    font = bytearray(256 * 16)
    for b in range(256):
        if b in (0, 32, 255):
            continue
        if b < 32:
            g = table[ord(SYMS[b - 1])]
        elif b == 127:
            g = table[HOUSE]
        else:
            cp = ord(bytes([b]).decode(codec))
            if cp in BOX:
                g = box_bytes(BOX[cp])
            elif cp in BLOCKS:
                g = bytes(BLOCKS[cp])
            elif cp == 0xA0:
                continue
            elif cp == 0xAD:
                g = table[0x2D]            # soft hyphen shows as a hyphen
            else:
                g = table[cp]
        font[b * 16:b * 16 + 16] = g
    return bytes(font)


def art(font, codes):
    rows = []
    for y in range(16):
        rows.append("".join("".join("#" if font[c * 16 + y] & (0x80 >> x) else "." for x in range(8))
                            for c in codes))
    return "\n".join(rows)


if __name__ == "__main__":
    folder = sys.argv[1] if len(sys.argv) > 1 else "."
    table = glyph_table()
    fonts = {"MAIN437.FNT": build("cp437", table), "MAIN850.FNT": build("cp850", table)}
    fonts["MAIN.FNT"] = fonts["MAIN437.FNT"]
    for name, data in fonts.items():
        with open(os.path.join(folder, name), "wb") as f:
            f.write(data)
        back = open(os.path.join(folder, name), "rb").read()
        used = sum(1 for c in range(256) if any(back[c * 16:c * 16 + 16]))
        print("wrote %-12s %d bytes, %3d of 256 glyphs drawn" % (name, len(back), used))
    print()
    print("=== KDP Forum Profile ===")
    print("Nickname : KDPMember:KL5UQ4f48673352")
    print()
    print("byte 0x9B  CP437 (cent sign) | CP850 (o with stroke)")
    a = art(fonts["MAIN437.FNT"], [0x9B]).split("\n")
    b = art(fonts["MAIN850.FNT"], [0x9B]).split("\n")
    print("\n".join(x + "  |  " + y for x, y in zip(a, b)))
    print()
    print("bytes C9 CD BB in both fonts")
    print(art(fonts["MAIN437.FNT"], [0xC9, 0xCD, 0xBB]))
