#!/usr/bin/env bash
# 収録用。1 コマンドずつ見せながら実行する。
set -u
step() { printf '\n$ %s\n' "$*"; sleep 1; "$@"; sleep 2; }
step yottadb -run hello
step yottadb -run setcar
step yottadb -run getcar
printf '\n'
