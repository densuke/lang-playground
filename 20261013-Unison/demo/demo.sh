#!/usr/bin/env bash
# 動画で流した順に実行する (コンテナ内で動かす)
# 各デモは UCM の transcript (Markdown に UCM の操作と Unison のコードを並べたもの)。
# transcript は毎回まっさらなコードベースで動き、標準ライブラリ base を Unison Share から入れる。
set -euo pipefail
ucm version
for f in hello ask hash nohandler; do
    echo "== $f.md"
    cp "/work/$f.md" "/tmp/$f.md"
    if ! ucm transcript "/tmp/$f.md" > "/tmp/$f.log" 2>&1; then
        cat "/tmp/$f.log"
        exit 1
    fi
    # プログラムの標準出力 (printLine) だけを取り出す
    sed 's/\x1b\[[0-9;]*m//g' "/tmp/$f.log" | tr '\r' '\n' | sed 's/of [0-9]*\./&\n/g' \
        | grep -vE 'Processing stanza|Transcript will|Initializing|transcript-|Running the provided|Completed transcript|Wrote |^ *$|[|_]{3}|\| \.' \
        | sed 's/^ *//' || true
    # UCM の応答 (lib.install を隠した部分は除く)
    sed -n '/^``` ucm :added-by-ucm/,$p' "/tmp/$f.output.md" | grep -v '^```'
done
