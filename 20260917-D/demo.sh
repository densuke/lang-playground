#!/usr/bin/env bash
# 収録用。1 コマンドずつ見せながら実行する。
set -u
step() { printf '\n$ %s\n' "$*"; sleep 1; "$@"; sleep 2; }
step ldmd2 -run hello.d
step ldmd2 -run ctfe.d
step ldmd2 -run ctfe_bad.d
step ldmd2 -run arrays.d
step ldmd2 -run contract.d
printf '\n'
