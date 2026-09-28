#!/usr/bin/env bash
# 収録用。1 コマンドずつ見せながら実行する。
set -u
step() { printf '\n$ %s\n' "$*"; sleep 1; "$@"; sleep 2; }
step occam hello.occ
step occam seq.occ
step cat par_video.occ
step occam par_video.occ
step cat channel.occ
step occam channel.occ
printf '\n'
