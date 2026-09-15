#!/usr/bin/env bash
# 収録用。1 コマンドずつ見せながら実行する。
set -u
step() { printf '\n$ %s\n' "$*"; sleep 1; "$@"; sleep 2; }
# Grass は改行を出さないので、実行のあとに 1 行空ける。
run() { printf '\n$ grass %s\n' "$1"; sleep 1; grass "$1"; printf '\n'; sleep 2; }
step cat /work/w.grass
run /work/w.grass
step cat /work/succ.grass
run /work/succ.grass
run /work/helloworld.grass
printf '\n'
