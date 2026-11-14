#!/usr/bin/env bash
# cast を 2 本とも録る。run.sh が毎回呼ぶ container build を避けるため、
# 構築済みのイメージ lang-swift を直接 container run で動かす (イメージは ./run.sh で一度作っておく)。
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
out="${1:?出力先の assets ディレクトリ}"
shift
for name in ${@:-run feature}; do
    asciinema rec --overwrite --idle-time-limit 25 --window-size 68x16 \
        -c "container run --rm -it -v $here/demo:/work lang-swift bash -c \"\$(cat $here/rec-$name.sh)\"" \
        "$out/$name.cast"
done
