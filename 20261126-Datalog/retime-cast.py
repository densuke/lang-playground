"""録画した cast の各ステップの開始時刻を、台詞に合わせて付け替える。

収録スクリプトは各ステップの先頭で画面を消す (ESC[H ESC[2J)。そのイベントの直前の待ち時間だけを
書き換え、ステップの中身 (コマンドの入力・実行の所要) は録ったまま残す。
使い方: python3 retime-cast.py <cast> <終了時刻> <ステップ1の開始秒> <ステップ2の開始秒> ...
  ステップの数は cast の画面消去の回数と同じにする。前のステップが終わる前には始めない (0.8 秒以上あける)。
"""
import json
import sys
from pathlib import Path

CLEAR = "\x1b[H\x1b[2J"
path, end_at, starts = Path(sys.argv[1]), float(sys.argv[2]), [float(s) for s in sys.argv[3:]]
header, *lines = path.read_text().splitlines()
events = [json.loads(line) for line in lines]
clears = [i for i, e in enumerate(events) if e[1] == "o" and CLEAR in e[2]]
if len(clears) != len(starts):
    sys.exit(f"画面消去が {len(clears)} 回、開始秒が {len(starts)} 個。数を合わせてください")
# 先頭の起動表示 (container のスピナー) は、最初の画面消去より前を捨てて見せない。
events = events[clears[0] :]
clears = [i - clears[0] for i in clears]
SLOW = 3.5  # 負荷でコンパイルが遅れた分を詰める (入力待ちの 1.5 秒を含めた上限)
last_out = max(i for i, e in enumerate(events) if e[1] == "o" and "$ " in e[2])  # 最後の画面変化 (プロンプト) を終了時刻に置く
out, now, prev_end = [], 0.0, 0.0
for i, (delta, kind, data, *rest) in enumerate(events):
    if i in clears:
        want = starts[clears.index(i)]
        new_now = max(want, prev_end + 0.8)
        delta = new_now - now
    elif i == last_out:
        delta = max(end_at - now, 0.5)
    elif delta > SLOW and kind == "o" and not events[i + 1 :] == []:
        delta = SLOW if i - 1 in clears or i - 2 in clears else delta
    now += delta
    prev_end = now
    out.append(json.dumps([round(delta, 4), kind, data, *rest], ensure_ascii=False))
path.write_text("\n".join([header, *out]) + "\n")
print(f"終了 {now:.1f} 秒")
