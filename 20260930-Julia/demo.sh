#!/usr/bin/env bash
# 収録用。1 コマンドずつ見せながら実行する。
set -u
step() { printf '\n$ %s\n' "$*"; sleep 1; "$@"; sleep 2; }
step julia /work/basics.jl
step julia /work/dispatch.jl
step julia /work/extend.jl
printf '\n'
