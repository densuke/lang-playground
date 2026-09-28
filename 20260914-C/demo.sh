#!/usr/bin/env bash
# 収録用。1 コマンドずつ見せながら実行する。
set -u
step() { printf '\n$ %s\n' "$*"; sleep 1; "$@"; sleep 2; }
step cc -o /build/hello hello.c
step /build/hello
step cc -o /build/pointer pointer.c
step /build/pointer
step cc -Wall -o /build/assign assign.c
step /build/assign
printf '\n'
