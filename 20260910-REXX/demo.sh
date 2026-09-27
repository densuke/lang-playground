#!/usr/bin/env bash
# 収録用。1 コマンドずつ見せながら実行する。
set -u
step() { printf '\n$ %s\n' "$*"; sleep 1; "$@"; sleep 2; }
step rexx /work/hello.rexx
step cat /work/parse.rexx
step rexx /work/parse.rexx
step rexx /work/decimal.rexx
printf '\n'
