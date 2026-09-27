#!/usr/bin/env python3
"""Thue の最小インタプリタ。

仕様は Esolang wiki (https://esolangs.org/wiki/Thue) の記述に基づく。
規則は `<lhs>::=<rhs>` の形式。`rhs` が `~` で始まれば出力、`:::` そのもの
なら標準入力から1行読む。規則の適用順は非決定的なので `random.choice` で選ぶ。

Note: 同じ規則が複数箇所にマッチしていても最初に見つかった出現位置しか
候補にしていない (全出現位置を数える完全な実装ではない)。デモの規模では
この簡略化で十分。
"""
import argparse
import random
import sys

MAX_STEPS = 100_000


def run(src: str, rng: random.Random, out) -> str:
    rules, state, in_rules = [], [], True
    for line in src.splitlines():
        if in_rules:
            if line.strip() == "::=":
                in_rules = False
                continue
            if "::=" in line:
                lhs, rhs = line.split("::=", 1)
                rules.append((lhs, rhs))
        else:
            state.append(line)
    s = "\n".join(state)

    for _ in range(MAX_STEPS):
        usable = [(lhs, rhs) for lhs, rhs in rules if lhs in s]
        if not usable:
            return s
        lhs, rhs = rng.choice(usable)
        i = s.index(lhs)
        before, after = s[:i], s[i + len(lhs):]
        if rhs.startswith("~"):
            out.write(rhs[1:])
            s = before + after
        elif rhs == ":::":
            line = sys.stdin.readline()
            s = before + line.rstrip("\r\n") + after
        else:
            s = before + rhs + after
    raise RuntimeError(f"{MAX_STEPS} ステップを超えました (無限ループの可能性)")


def main():
    parser = argparse.ArgumentParser(description="Thue interpreter")
    parser.add_argument("program", help="Thue のソースファイル")
    parser.add_argument("--seed", type=int, default=None, help="非決定性を固定する乱数シード")
    args = parser.parse_args()

    with open(args.program, encoding="utf-8") as f:
        src = f.read()
    final_state = run(src, random.Random(args.seed), sys.stdout)
    print()
    print("最終状態:", repr(final_state))


if __name__ == "__main__":
    main()
