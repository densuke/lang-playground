#!/usr/bin/env bash
# 収録用。1 コマンドずつ見せながら実行する。
set -u
step() { printf '\n$ %s\n' "$*"; sleep 1; "$@"; sleep 2; }
step gosh hello.scm
step gosh tail.scm
step gosh counter.scm
printf '\n'
