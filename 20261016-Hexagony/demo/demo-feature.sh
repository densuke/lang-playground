#!/usr/bin/env bash
# 収録用 (後半)。作者が最初に出した 32 バイト版と、終了命令の無い真理機械。
#
# 真理機械は入力 0 で `:` が 0 除算になり、Ruby の例外で落ちて止まる。
# トレースバックは長いので /tmp へ逃がし、1 行目だけ見せる。
set -u
step() { printf '\n$ %s\n' "$1"; sleep 1; eval "$1"; sleep "${2:-3}"; }
cd /work
step 'cat hello-ppcg.hxg' 8
step 'hexagony hello-ppcg.hxg; echo' 1.5
step 'cat truth.hxg' 8.5
step 'echo 1 | hexagony truth.hxg | head -c 40; echo' 3
step 'echo 0 | hexagony truth.hxg 2>/tmp/err; echo' 3
step "grep -o 'divided by 0.*' /tmp/err" 7
printf '\n'
