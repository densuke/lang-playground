"""cast の先頭に映るコンテナ起動のスピナーを取り除く (最初の画面クリアより前の出力)。
使い方: python3 clean-cast.py <cast>   (align-cast.py のあとに実行する)
"""
import json
import sys
from pathlib import Path

path = Path(sys.argv[1])
header, *events = path.read_text().splitlines()
kept, carry, cleared = [], 0.0, False
for line in events:
    delta, kind, data = json.loads(line)[:3]
    if not cleared and kind == "o" and "\x1b[2J" in data:
        cleared = True
    if not cleared and kind == "o":
        carry += delta
        continue
    kept.append(json.dumps([delta + carry, kind, data], ensure_ascii=False))
    carry = 0.0
path.write_text("\n".join([header, *kept]) + "\n")
