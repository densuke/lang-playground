#!/usr/bin/env python3
"""Fractran の最小インタプリタ。

仕様は Esolang wiki (https://esolangs.org/wiki/Fractran) の規則どおり。

1. 分数のリストを先頭から見て、n に掛けると整数になる最初の分数を探す
2. 見つかったら n をその積に置き換え、リストの先頭に戻る
3. どの分数でも整数にならなければ停止する

浮動小数点は使わず、整数の割り算の余りだけで判定する。
ソースは `分子/分母` をカンマか空白で区切って並べる。`#` から行末はコメント。
"""
import argparse
import sys

MAX_STEPS = 1_000_000


def parse(src: str) -> list[tuple[int, int]]:
    """ソースを (分子, 分母) の並びにする。"""
    code = " ".join(line.split("#", 1)[0] for line in src.splitlines())
    fracs = []
    for tok in code.replace(",", " ").split():
        num, den = tok.split("/")
        fracs.append((int(num), int(den)))
    return fracs


def step(prog: list[tuple[int, int]], n: int) -> int | None:
    """1 ステップ進めた n を返す。どの分数も使えなければ None (停止)。"""
    for num, den in prog:
        if n * num % den == 0:
            return n * num // den
    return None


def run(prog: list[tuple[int, int]], n: int):
    """n の移り変わりを順に返す (最初の n は含まない)。"""
    for _ in range(MAX_STEPS):
        n = step(prog, n)
        if n is None:
            return
        yield n
    raise RuntimeError(f"{MAX_STEPS} ステップを超えました (停止しないプログラムかもしれません)")


def factorize(n: int) -> str:
    """n を素因数分解した文字列 (例: 2^3 * 3)。"""
    parts, p = [], 2
    while p * p <= n:
        e = 0
        while n % p == 0:
            n //= p
            e += 1
        if e:
            parts.append(f"{p}^{e}" if e > 1 else str(p))
        p += 1
    if n > 1:
        parts.append(str(n))
    return " * ".join(parts) or "1"


def pow2_exponent(n: int) -> int | None:
    """n が 2 の累乗 (2^1 以上) ならその指数を返す。"""
    return n.bit_length() - 1 if n > 1 and n & (n - 1) == 0 else None


def main():
    parser = argparse.ArgumentParser(description="Fractran interpreter")
    parser.add_argument("program", help="Fractran のソースファイル")
    parser.add_argument("n", type=int, help="最初の整数 (正の整数)")
    group = parser.add_mutually_exclusive_group()
    group.add_argument("--trace", type=int, metavar="K", help="最初の K 個の n を表示して止める")
    group.add_argument("--pow2", type=int, metavar="K",
                       help="途中に現れる 2 の累乗の指数を K 個表示して止める")
    args = parser.parse_args()
    if args.n < 1:
        parser.error("n は正の整数にしてください")

    with open(args.program, encoding="utf-8") as f:
        prog = parse(f.read())

    if args.trace is not None:
        seq = [args.n]
        for n in run(prog, args.n):
            if len(seq) >= args.trace:
                break
            seq.append(n)
        print(", ".join(map(str, seq)))
    elif args.pow2 is not None:
        found = []
        for n in run(prog, args.n):
            e = pow2_exponent(n)
            if e is not None:
                found.append(e)
                if len(found) >= args.pow2:
                    break
        print(", ".join(map(str, found)))
    else:
        final = args.n
        for final in run(prog, args.n):
            pass
        print(f"停止: n = {final} = {factorize(final)}")


if __name__ == "__main__":
    sys.exit(main())
