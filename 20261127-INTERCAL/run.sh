#!/usr/bin/env bash
# INTERCAL の実験環境に入る。container / docker / podman のどれかがあれば動く。
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
rt="$(command -v container || command -v docker || command -v podman)" || {
    echo "コンテナ実行環境がありません (container / docker / podman のいずれか)" >&2
    exit 1
}
# ビルドの出力は普段は見せない。失敗したときだけ出す。
if ! build_log=$("$rt" build -t lang-intercal "$here" 2>&1); then
    printf '%s\n' "$build_log" >&2
    exit 1
fi
# 入力か出力が端末でない経路 (パイプ・リダイレクト・収録スクリプト) でも動くよう、-t は両方が端末のときだけ付ける。
if [ -t 0 ] && [ -t 1 ]; then
    exec "$rt" run --rm -it -v "$here/demo:/work" lang-intercal "$@"
else
    exec "$rt" run --rm -i -v "$here/demo:/work" lang-intercal "$@"
fi
