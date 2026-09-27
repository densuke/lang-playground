#!/usr/bin/env bash
# 収録用。1 コマンドずつ見せながら実行する。
set -u
step() { printf '\n$ %s\n' "$*"; sleep 1; "$@"; sleep 2; }
# pli はコンパイル・リンク・実行をまとめた小さなスクリプト (Dockerfile の隣にある pli)。
step pli hello.pli
step cat keywords.pli
step pli keywords.pli
step pli onunit.pli
printf '\n'
