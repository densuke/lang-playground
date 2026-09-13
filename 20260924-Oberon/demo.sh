#!/usr/bin/env bash
# 収録用。1 コマンドずつ見せながら実行する。
set -u
step() { printf '\n$ %s\n' "$*"; sleep 1; "$@"; sleep 2; }
step voc -m Hello.Mod
step ./Hello
step voc -m Fib.Mod
step ./Fib
step voc -m Shapes.Mod
step ./Shapes
printf '\n'
