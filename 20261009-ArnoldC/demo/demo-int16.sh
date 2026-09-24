#!/usr/bin/env bash
# 収録用。リテラルだけが 16bit に切り詰められることを見せる。
#
# 変数は 32bit の int スロットなので 32767 + 1 は 32768 になる。
# 一方でリテラルは sipush で埋め込まれるため、書いた時点で化ける。
set -u
step() { printf '\n$ %s\n' "$1"; sleep 1; eval "$1" 2>/dev/null; sleep 2; }
cd /work
step 'arnoldc addition.arnoldc && java addition'
step 'arnoldc literal.arnoldc && java literal'
step 'javap -c literal | grep sipush | head -5'
sleep 8
printf '\n'
