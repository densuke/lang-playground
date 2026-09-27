#!/usr/bin/env bash
# 収録用。1 コマンドずつ見せながら実行する。
set -u
step() { printf '\n$ %s\n' "$*"; sleep 1; "$@"; sleep 2; }
step i7 kitchen.ni kitchen.txt
step i7 diner.ni diner.txt
step i7 rules.ni rules.txt
printf '\n'
