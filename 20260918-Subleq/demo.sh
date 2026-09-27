#!/usr/bin/env bash
# 収録用。1 コマンドずつ見せながら実行する。
set -u
step() { printf '\n$ %s\n' "$*"; sleep 1; "$@"; sleep 2; }
# 出力の末尾に改行が無いものもあるので、表示をそろえるため改行を 1 つ足す。
run() {
    printf '\n$ python3 subleq.py %s\n' "$1"; sleep 1
    printf '%s\n' "$(python3 subleq.py "$1")"; sleep 2
}
step cat hi.sq
run hi.sq
step cat add.sq
run add.sq
step cat hello.sq
run hello.sq
printf '\n'
