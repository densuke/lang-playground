#!/usr/bin/env bash
# 収録用。1 コマンドずつ見せながら実行する。
set -u
step() { printf '\n$ %s\n' "$*"; sleep 1; "$@"; sleep 2; }
step cat hello.wy
step wenyan hello.wy
step wenyan -c hello.wy
step wenyan oneline.wy
step wenyan fibonacci.wy
step wenyan --no-outputHanzi fibonacci.wy
printf '\n'
