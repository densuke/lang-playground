#!/usr/bin/env bash
# 収録用。1 コマンドずつ見せながら実行する。
set -u
step() { printf '\n$ %s\n' "$*"; sleep 1; "$@"; sleep 2; }
step cat add.frac
step python3 fractran.py add.frac 648
step cat primegame.frac
step python3 fractran.py primegame.frac 2 --trace 6
step python3 fractran.py primegame.frac 2 --pow2 10
printf '\n'
