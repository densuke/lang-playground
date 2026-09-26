#!/usr/bin/env bash
# 収録用。1 コマンドずつ見せながら実行する。
set -u
step() { printf '\n$ %s\n' "$*"; sleep 1; "$@"; sleep 2; }
step cat hello.thue
step python3 thue.py hello.thue
step cat inc.thue
step python3 thue.py inc.thue
step cat nd.thue
step python3 thue.py --seed 0 nd.thue
step python3 thue.py --seed 1 nd.thue
printf '\n'
