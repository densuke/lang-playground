#!/usr/bin/env python3
"""BCT で Collatz 列を計算する (このリポジトリのオリジナル)。使い方: collatz_bct.py [n]

esolangs.org の Bitwise Cyclic Tag のページにある生成規則 (De Mol の tag system に基づくとある) を
BCT プログラムにして走らせる。データ語は 100 を n 個並べたもの。
規則 6 つを 1 周するたび (BCT では 0 だけの命令を 6 回通るたび) にデータ語を見て、
100 がちょうど k 個並んだ形のときだけ k を読む。
k が偶数なら k/2、奇数なら (3k+1)/2 が次の k になる。
"""
import re
import sys

from ct import run_bct, to_bct

RULES = "010001,100,100100100,,,".split(",")
n = int(sys.argv[1]) if len(sys.argv) > 1 else 3
program = to_bct(RULES)
print(f"BCT プログラムの長さ: {len(program)} ビット")
ks, semis, steps = [n], 0, 0
for steps, cmd, data in run_bct(program, "100" * n, 100000):
    if cmd == "0":
        semis += 1
        if semis % 6 == 0:
            k = len(data) // 3
            if re.fullmatch("(100)+", data) and k != ks[-1]:
                ks.append(k)
                if k == 1:
                    break
print("k:", " -> ".join(map(str, ks)))
print(f"実行したコマンド: {steps}")
