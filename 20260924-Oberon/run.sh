#!/usr/bin/env bash
# Oberon の実験環境に入る。container / docker / podman のどれかがあれば動く。
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
rt="$(command -v container || command -v docker || command -v podman)" || {
    echo "コンテナ実行環境がありません (container / docker / podman のいずれか)" >&2
    exit 1
}
# ビルドの出力は普段は見せない。失敗したときだけ出す。
if ! build_log=$("$rt" build -t lang-oberon "$here" 2>&1); then
    printf '%s\n' "$build_log" >&2
    exit 1
fi
# TTY が無い経路 (パイプ・収録スクリプト) でも動くよう、-t は端末のときだけ付ける。
# 空配列の展開は bash 3.2 (macOS 同梱) が set -u で落とすので、分岐で書く。
if [ -t 1 ]; then
    exec "$rt" run --rm -it -v "$here/demo:/work" lang-oberon "$@"
else
    exec "$rt" run --rm -i -v "$here/demo:/work" lang-oberon "$@"
fi
