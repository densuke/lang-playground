#!/usr/bin/env bash
# コンテナの中で流す。例: ./run.sh bash -s < demo.sh
# 生成物でデモの置き場を汚さないよう、作業用ディレクトリにコピーして動かす。
set -u
work=$(mktemp -d)
cp /work/*.m "$work" && cd "$work" || exit 1

mmc --version | head -1
mmc --make hello && ./hello
mmc --make modes && ./modes

# ここから 3 本は、コンパイルが通らないことが見どころ (エラー出力をそのまま見せる)
for bad in bad_type bad_det bad_mode; do
    echo "=== $bad ==="
    mmc --make "$bad"; echo "(mmc の終了コード: $?)"
done
