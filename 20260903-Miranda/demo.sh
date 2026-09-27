#!/usr/bin/env bash
# 収録用。1 コマンドずつ見せながら実行する。
set -u
step() { printf '\n$ %s\n' "$*"; sleep 1; "$@"; sleep 2; }
step mira -exec fac.m
step mira -exec squares.m
step mira -exec rev.m
printf '\n'
rm -f ./*.x  # mira が作る中間コードを残さない
