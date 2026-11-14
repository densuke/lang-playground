"""録画した cast の最初のプロンプトを指定の時刻へ揃える。

コンテナの起動時間 (1.4〜2.9 秒) が録るたびにぶれるため、台詞に合わせた待ち時間を
そのまま使えるように、最初の "$ " が出る時刻だけを後から固定する。
使い方: python3 align-cast.py <cast> <最初のプロンプトを出したい秒数>
"""
import json
import sys
from pathlib import Path

path, target = Path(sys.argv[1]), float(sys.argv[2])
header, *events = path.read_text().splitlines()
elapsed = 0.0
for i, line in enumerate(events):
    delta, kind, data = json.loads(line)[:3]
    elapsed += delta
    if kind == "o" and "$ " in data:
        events[i] = json.dumps([delta + target - elapsed, kind, data], ensure_ascii=False)
        break
path.write_text("\n".join([header, *events]) + "\n")
