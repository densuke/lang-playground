#!/usr/bin/env bash
# 収録用。1 コマンドずつ見せながら実行する。
set -u
step() { printf '\n$ %s\n' "$*"; sleep 1; "$@"; sleep 2; }
step gnatmake -q -D /build -o /build/hello hello.adb
step /build/hello
step gnatmake -q -D /build -o /build/types types.adb
step /build/types
step gnatmake -q -D /build -o /build/types_bad types_bad.adb
step gnatmake -q -gnata -D /build -o /build/contract contract.adb
step /build/contract
printf '\n'
