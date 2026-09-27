#!/usr/bin/env bash
# 収録用。1 コマンドずつ見せながら実行する。
set -u
step() { printf '\n$ %s\n' "$*"; sleep 1; "$@"; sleep 2; }
# Hello World は末尾に改行を出さないので、実行のあとに 1 行空ける。
run() { printf '\n$ malbolge %s\n' "$1"; sleep 1; malbolge "$1" < /dev/null; printf '\n'; sleep 2; }
step cat hello.mb
run hello.mb
# 先頭の 1 文字を消しただけ。番地が 1 つずつずれて、全部が別の命令になる。
step cat shifted.mb
run shifted.mb
printf '\n'
