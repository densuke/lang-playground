#!/usr/bin/env bash
# 収録用。1 コマンドずつ見せながら実行する。
set -u
step() { printf '\n$ %s\n' "$*"; sleep 1; "$@"; sleep 2; }
step lua5.4 /work/basics.lua
step lua5.4 /work/meta.lua
step lua5.4 /work/coro.lua
printf '\n'
