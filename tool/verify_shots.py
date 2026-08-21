#!/usr/bin/env python3
"""Check captured screenshots against a store's size rules.

Reads the PNG header rather than shelling out to `sips`, which exists only on
macOS — the iOS leg could use it, the Android leg runs on Linux, and one checker
serving both means the two legs cannot drift into checking different things.

A capture path that answers success whatever happened has been green over an
empty directory before, so this exists to disagree with it.

    python3 tool/verify_shots.py --exact 1320x2868 --exact 1290x2796 DIR
    python3 tool/verify_shots.py --min-edge 320 --max-edge 3840 --portrait DIR
"""
from __future__ import annotations

import argparse
import glob
import os
import struct
import sys


def png_size(path: str) -> tuple[int, int]:
    """Width and height from the IHDR chunk.

    The first eight bytes are the signature, then a four-byte length and the
    "IHDR" tag, then width and height as big-endian uint32. Anything that is not
    a PNG fails here rather than being reported as a strange size.
    """
    with open(path, "rb") as fh:
        header = fh.read(24)
    if len(header) < 24 or header[:8] != b"\x89PNG\r\n\x1a\n" or header[12:16] != b"IHDR":
        raise ValueError(f"{os.path.basename(path)} is not a PNG")
    return struct.unpack(">II", header[16:24])


def main() -> int:
    p = argparse.ArgumentParser()
    p.add_argument("directory")
    p.add_argument("--exact", action="append", default=[],
                   help="an allowed WxH; repeatable. Any match passes.")
    p.add_argument("--min-edge", type=int)
    p.add_argument("--max-edge", type=int)
    p.add_argument("--portrait", action="store_true", help="height must exceed width")
    args = p.parse_args()

    allowed = set()
    for spec in args.exact:
        w, _, h = spec.lower().partition("x")
        allowed.add((int(w), int(h)))

    files = sorted(glob.glob(os.path.join(args.directory, "*.png")))
    if not files:
        print(f"::error::no PNGs in {args.directory}")
        return 1

    problems = []
    for path in files:
        name = os.path.basename(path)
        try:
            w, h = png_size(path)
        except ValueError as e:
            problems.append(str(e))
            continue
        print(f"  {name}  {w}x{h}")
        if allowed and (w, h) not in allowed:
            problems.append(f"{name} is {w}x{h}, not one of "
                            + ", ".join(f"{a}x{b}" for a, b in sorted(allowed)))
            continue
        if args.min_edge and min(w, h) < args.min_edge:
            problems.append(f"{name} is {w}x{h}, under the {args.min_edge}px minimum")
        if args.max_edge and max(w, h) > args.max_edge:
            problems.append(f"{name} is {w}x{h}, over the {args.max_edge}px maximum")
        if args.portrait and h <= w:
            problems.append(f"{name} is {w}x{h}, which is not portrait")

    for problem in problems:
        print(f"::error::{problem}")
    return 1 if problems else 0


if __name__ == "__main__":
    raise SystemExit(main())
