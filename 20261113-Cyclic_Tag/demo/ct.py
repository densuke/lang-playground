#!/usr/bin/env python3
"""Cyclic Tag System / Bitwise Cyclic Tag (BCT) / Rule 110 の小さな実行器 (このリポジトリのオリジナル)。

  ct.py ct  "011,10,101" 1        生成規則 (カンマ区切り、空語可) とデータ語
  ct.py bct 00111 101             BCT プログラム (ビット列) とデータ語
  ct.py rule110 [幅] [世代数]     Rule 110 を 1 セルから走らせる
  ct.py tobct "011,10,101"        生成規則を BCT プログラムへ変換 (0<-10, 1<-11, ;<-0)

オプション: -n 最大ステップ (既定 40)  --every K  K ステップごとに表示  --quiet  最後だけ表示
仕様 (Cook 2004, esolangs.org): データ語の先頭 d を読んで消す。d が 1 なら現在の生成規則を末尾に付ける。
規則は巡回する。データ語が空になったら停止。
"""
import sys


def step_ct(rules, i, data):
    """1 ステップ進める。戻り値は (次の規則番号, 新しいデータ語)。"""
    head, rest = data[0], data[1:]
    return (i + 1) % len(rules), rest + (rules[i] if head == "1" else "")


def run_ct(rules, data, limit):
    """停止するか limit に達するまでの (ステップ, 規則番号, データ語) を yield する。"""
    i = 0
    for n in range(limit + 1):
        yield n, i, data
        if not data:
            return
        i, data = step_ct(rules, i, data)


def run_bct(program, data, limit):
    """BCT を 1 コマンドずつ進める。 (ステップ, 実行したコマンド, データ語) を yield する。"""
    pc, n = 0, 0
    yield n, "", data
    while data and n < limit:
        cmd = program[pc % len(program)]
        if cmd == "0":
            data, shown = data[1:], "0"
            pc += 1
        else:
            x = program[(pc + 1) % len(program)]
            shown = "1" + x
            if data[0] == "1":
                data += x
            pc += 2
        n += 1
        yield n, shown, data


def to_bct(rules):
    """生成規則を BCT プログラムにする。"""
    return "".join("".join({"0": "10", "1": "11"}[c] for c in r) + "0" for r in rules)


def rule110(width, gens):
    """Rule 110 の時空図を文字列の行で返す (周期境界、中央でなく右端の 1 セルから)。"""
    table = {(1, 1, 1): 0, (1, 1, 0): 1, (1, 0, 1): 1, (1, 0, 0): 0,
             (0, 1, 1): 1, (0, 1, 0): 1, (0, 0, 1): 1, (0, 0, 0): 0}
    row = [0] * (width - 1) + [1]
    for _ in range(gens):
        yield "".join("#" if c else "." for c in row)
        row = [table[(row[k - 1], row[k], row[(k + 1) % width])] for k in range(width)]


def main(argv):
    opts = {"-n": 40, "--every": 1}
    flags = set()
    args = []
    it = iter(argv)
    for a in it:
        if a in opts:
            opts[a] = int(next(it))
        elif a == "--quiet":
            flags.add(a)
        else:
            args.append(a)
    if not args:
        sys.exit(__doc__)
    mode, rest = args[0], args[1:]
    every = opts["--every"]
    if mode == "rule110":
        width = int(rest[0]) if rest else 64
        gens = int(rest[1]) if len(rest) > 1 else 32
        print("\n".join(rule110(width, gens)))
    elif mode == "tobct":
        print(to_bct(rest[0].split(",")))
    elif mode == "ct":
        rules = rest[0].split(",")
        last = None
        for n, i, d in run_ct(rules, rest[1], opts["-n"]):
            last = (n, i, d)
            if "--quiet" not in flags and n % every == 0:
                print(f"step {n:3d}  i={i}  P={rules[i] or '(empty)':<10} D={d or '(empty)'}")
        n, i, d = last
        print("halt: データ語が空になった" if not d else f"(-n {opts['-n']} で打ち切り: 長さ {len(d)})")
    elif mode == "bct":
        last = None
        for n, c, d in run_bct(rest[0], rest[1], opts["-n"]):
            last = (n, c, d)
            if "--quiet" not in flags and n % every == 0:
                print(f"step {n:3d}  cmd={c or '-':<3} D={d or '(empty)'}")
        print("halt: データ語が空になった" if not last[2] else f"(-n {opts['-n']} で打ち切り: 長さ {len(last[2])})")
    else:
        sys.exit(__doc__)


if __name__ == "__main__":
    main(sys.argv[1:])
