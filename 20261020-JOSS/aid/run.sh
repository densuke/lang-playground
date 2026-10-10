#!/usr/bin/env bash
# AID (JOSS の末裔) を simh 上の TOPS-10 で動かす。container / docker / podman のどれかがあれば動く。
# 使い方: ./run.sh              対話 (telnet で入る)
#         ./run.sh aid-demo     demo/ の台本を非対話で流す
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
img="$here/images"
rt="$(command -v container || command -v docker || command -v podman)" || {
    echo "コンテナ実行環境がありません (container / docker / podman のいずれか)" >&2
    exit 1
}

# 版権物はリポジトリに入れず、初回だけここへ取得して sha256 を確かめる
fetch() { # url file sha256
    [ -f "$img/$2" ] || curl -fL --progress-bar -o "$img/$2" "$1"
    echo "$3  $img/$2" | shasum -a 256 -c - >/dev/null || { echo "sha256 が違います: $2" >&2; rm -f "$img/$2"; exit 1; }
}
mkdir -p "$img"
fetch https://obsolescence.dev/pidp10-sw/tops603ka.zip tops603ka.zip \
    70fbf55544bb50dd6b9216cbad0bd037cb41c1fd9570ea6e94dd13735f61599d
fetch https://pdp-10.trailing-edge.com/tapes/bb-x130a-sb.tap.bz2 bb-x130a-sb.tap.bz2 \
    929b757b077a700b9090d025df5f516f6357c6e2833d9ed195c090088fa83ec5

if ! build_log=$("$rt" build -t lang-joss-aid "$here" 2>&1); then
    printf '%s\n' "$build_log" >&2
    exit 1
fi
args=(-v "$img:/images:ro" -v "$here/demo:/work")
if [ -t 1 ]; then flags=(--rm -it); else flags=(--rm -i); fi
exec "$rt" run "${flags[@]}" "${args[@]}" lang-joss-aid "$@"
