#!/usr/bin/env bash
# perceus.kk を C へ変換し、inc-all の中で「参照が 1 本なら古いセルを再利用」する箇所を見せる
set -euo pipefail
koka -v0 -O2 -c --outputdir=/tmp/out /work/perceus.kk >/dev/null 2>&1
grep -E 'is_unique|_reuse\(|reuse_null' /tmp/out/perceus.c | head -4
