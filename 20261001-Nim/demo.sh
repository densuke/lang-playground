#!/usr/bin/env bash
# 収録用。1 コマンドずつ見せながら実行する。
set -u
step() { printf '\n$ %s\n' "$*"; sleep 1; "$@"; sleep 2; }
step nim c --hints:off -o:/tmp/basics /work/basics.nim
step /tmp/basics
step nim c --hints:off -r -o:/tmp/ct /work/compiletime.nim
step nim c --hints:off -r -o:/tmp/mac /work/macro.nim
printf '\n'
