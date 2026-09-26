#!/usr/bin/env bash
# 収録用。1 コマンドずつ見せながら実行する。
set -u
step() { printf '\n$ %s\n' "$*"; sleep 1; "$@"; sleep 2; }
step runghc /work/Lazy.hs
step runghc /work/TypeClass.hs
step runghc /work/Adt.hs
printf '\n'
