#!/usr/bin/env bash
# 動画で流した順に実行する (コンテナ内で動かす)
set -euo pipefail
koka --version --console=raw | head -1
for f in hello ask perceus; do
    echo "== $f.kk"
    koka -v0 -e /work/$f.kk 2>/dev/null | grep -vE '^(vfs|compile|linking|created) *:?'
done
echo "== show-reuse.sh"
bash /work/show-reuse.sh
