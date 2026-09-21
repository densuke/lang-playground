#!/usr/bin/env bash
# 収録用 (前半)。版の確認から、金額の編集項目まで。
set -u
step() { printf '\n$ %s\n' "$1"; sleep 2; eval "$1" 2>/dev/null; sleep 3; }
cd /work
step 'cobc --version | head -2'
step "sed -n '5,8p' basics.cob"
step 'cobc -x basics.cob'
step './basics'
printf '\n'
