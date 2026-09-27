#!/usr/bin/env python3
"""Subleq の最小インタプリタ。

仕様は Esolang wiki (https://esolangs.org/wiki/Subleq) の記述どおり。
命令は 1 つだけで、3 つの数 `a b c` で 1 命令になる。

    mem[b] -= mem[a]
    結果が 0 以下なら c 番地へ飛ぶ。そうでなければ次の命令へ進む

- b が -1 のときは引き算の代わりに、引こうとした値 mem[a] を 1 文字として出力する
- 負の番地へ飛ぶと停止する (メモリの外へ出たときも停止する)
- 入力 (a が -1) は同梱のデモで使わないので対応しない

ソースは数を空白かカンマで区切って並べる。`#` から行末はコメント。
"""
import sys

MAX_STEPS = 1_000_000


def run(mem: list[int], out) -> None:
    pc = 0
    for _ in range(MAX_STEPS):
        if not 0 <= pc <= len(mem) - 3:
            return
        a, b, c = mem[pc], mem[pc + 1], mem[pc + 2]
        if a == -1:
            raise NotImplementedError("入力 (a = -1) には対応していません")
        if b == -1:
            out.write(chr(mem[a]))
            pc += 3
            continue
        mem[b] -= mem[a]
        pc = c if mem[b] <= 0 else pc + 3
    raise RuntimeError(f"{MAX_STEPS} ステップを超えました (停止しないプログラムかもしれません)")


def main():
    if len(sys.argv) != 2:
        sys.exit("使い方: python3 subleq.py <ファイル>")
    with open(sys.argv[1], encoding="utf-8") as f:
        code = " ".join(line.split("#", 1)[0] for line in f)
    run([int(x) for x in code.replace(",", " ").split()], sys.stdout)


if __name__ == "__main__":
    main()
