#!/usr/bin/env bash
# 収録用。1 コマンドずつ見せながら実行する。
set -u
step() { printf '\n$ %s\n' "$*"; sleep 1; "$@"; sleep 2; }
# clu は pclu (CLU → C) と plink (リンク) と実行をまとめた小さなスクリプト (Dockerfile の隣にある clu)。
step clu complex.clu
step clu iter.clu
step clu signals.clu
printf '\n'
