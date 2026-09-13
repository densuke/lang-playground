#!/usr/bin/env bash
# 収録用。1 コマンドずつ見せながら実行する。
set -u
step() { printf '\n$ %s\n' "$*"; sleep 1; "$@"; sleep 2; }
step poly --script /work/Basics.sml
step poly --script /work/Exhaustive.sml
step poly --script /work/Dict.sml
printf '\n'
