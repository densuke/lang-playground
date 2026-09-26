#!/usr/bin/env bash
# 収録用。1 コマンドずつ見せながら実行する。
# bwbasic は END のあと対話プロンプトに戻るので、入力を /dev/null にして終わらせる。
set -u
step() { printf '\n$ %s\n' "$*"; sleep 1; "$@" </dev/null; sleep 2; }
step bwbasic /work/hello.bas
step bwbasic /work/fib.bas
step bwbasic /work/goto.bas
printf '\n'
