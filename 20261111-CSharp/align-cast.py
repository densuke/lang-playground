"""録画した cast の最初のプロンプトを指定の時刻へ揃える。

コンテナの起動時間と SDK の暖機 (十数秒、画面には何も映らない) が録るたびにぶれるため、
先頭の長い空白を詰めたうえで、最初の "$ " が出る時刻だけを後から固定する。
使い方: python3 align-cast.py <cast> <最初のプロンプトを出したい秒数>
"""
import json
import sys
from pathlib import Path

path, target = Path(sys.argv[1]), float(sys.argv[2])
header, *events = path.read_text().splitlines()
parsed = [json.loads(line) for line in events]
first = next(i for i, e in enumerate(parsed) if e[1] == "o" and "$ " in e[2])
for e in parsed[:first]:
    e[0] = min(e[0], 0.1)  # 暖機などの空白を詰める
elapsed = sum(e[0] for e in parsed[:first])
if elapsed > target:
    sys.exit(f"先頭の出力だけで {elapsed:.1f} 秒あり、{target} 秒へ揃えられない")
parsed[first][0] = target - elapsed
path.write_text("\n".join([header, *(json.dumps(e, ensure_ascii=False) for e in parsed)]) + "\n")
