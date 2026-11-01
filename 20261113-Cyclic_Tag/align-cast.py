"""録画した cast の先頭を整える。

コンテナ起動のスピナー表示 (起動時間は録るたびにぶれる) を捨て、最初の画面消去 + プロンプトを
指定の時刻に置く。これで台詞に合わせた待ち時間をそのまま使える。
使い方: python3 align-cast.py <cast> <最初のプロンプトを出したい秒数>
"""
import json
import sys
from pathlib import Path

path, target = Path(sys.argv[1]), float(sys.argv[2])
header, *events = path.read_text().splitlines()
first = next(i for i, line in enumerate(events) if "\\u001b[H\\u001b[2J" in line)
delta, kind, data = json.loads(events[first])[:3]
events = [json.dumps([target, kind, data], ensure_ascii=False), *events[first + 1 :]]
path.write_text("\n".join([header, *events]) + "\n")
