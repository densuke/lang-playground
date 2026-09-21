#!/usr/bin/env bash
# 収録用 (後半)。十進演算と二進浮動小数点の対比。
set -u
step() { printf '\n$ %s\n' "$1"; sleep 2; eval "$1" 2>/dev/null; sleep 3; }
cd /work
step "grep -n 'WS-A \|WS-FA ' decimal.cob"
step 'cobc -x decimal.cob'
step "grep -n 'COMPUTE' decimal.cob"
step './decimal'
printf '\n'
