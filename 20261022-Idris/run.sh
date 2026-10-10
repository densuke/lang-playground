#!/usr/bin/env bash
# Idris の実験環境に入る。container / docker / podman のどれかがあれば動く。
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
rt="$(command -v container || command -v docker || command -v podman)" || {
    echo "コンテナ実行環境がありません (container / docker / podman のいずれか)" >&2
    exit 1
}
# Apple container の builder 既定 (2GB) では Chez のブートストラップが OOM で落ちるため増やす。
build_opts=()
[ "$(basename "$rt")" = container ] && build_opts=(-m 12G -c 4)
# ビルドの出力は普段は見せない。失敗したときだけ出す。
if ! build_log=$("$rt" build ${build_opts[@]+"${build_opts[@]}"} -t lang-idris "$here" 2>&1); then
    printf '%s\n' "$build_log" >&2
    exit 1
fi
# TTY が無い経路 (パイプ・収録スクリプト) でも動くよう、-t は端末のときだけ付ける。
if [ -t 1 ]; then
    exec "$rt" run --rm -it -v "$here/demo:/work" lang-idris "$@"
else
    exec "$rt" run --rm -i -v "$here/demo:/work" lang-idris "$@"
fi
