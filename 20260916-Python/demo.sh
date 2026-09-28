#!/usr/bin/env bash
# 収録用。1 コマンドずつ見せながら実行する。
set -u
step() { printf '\n$ %s\n' "$*"; sleep 1; "$@"; sleep 2; }
step python3 --version
step python3 hello.py
step python3 swap.py
step python3 indent.py
step python3 bad_indent.py
step python3 braces.py
printf '\n'
