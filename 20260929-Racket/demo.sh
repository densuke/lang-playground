#!/usr/bin/env bash
# 収録用。1 コマンドずつ見せながら実行する。
set -u
step() { printf '\n$ %s\n' "$*"; sleep 1; "$@"; sleep 2; }
step racket /work/basics.rkt
step racket /work/macro.rkt
step racket /work/hello.mylang
printf '\n'
