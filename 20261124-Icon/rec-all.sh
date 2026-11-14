#!/usr/bin/env bash
# 収録 (run.cast / feature.cast) をまとめて行う。使い方: rec-all.sh <出力先ディレクトリ> [run|feature]
set -eu
here="$(cd "$(dirname "$0")" && pwd)"
out="$1"; which="${2:-both}"
rec() {  # <名前> <最初のプロンプトの秒数>
    asciinema rec --overwrite --idle-time-limit 30 --window-size 68x16 \
        -c "container run --rm -it -v $here/demo:/work lang-icon bash -c \"\$(cat $here/rec-$1.sh)\"" "$out/$3"
    python3 "$here/align-cast.py" "$out/$3" "$2"
}
[ "$which" != feature ] && rec run "$RUN_T" run.cast
[ "$which" != run ] && rec feature "$FEAT_T" feature.cast
