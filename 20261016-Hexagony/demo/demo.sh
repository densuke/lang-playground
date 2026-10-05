#!/bin/sh
# 収録用: Hello World の 3 つの書き方と、真理機械・素数判定を順に流す。
cd /work
for f in hello.hxg hello-compact.hxg hello-ppcg.hxg; do
    echo "--- $f"; hexagony "$f"; echo
done
echo "--- truth.hxg (入力 0 / 1)"
echo 0 | hexagony truth.hxg 2>/dev/null; echo " [exit=$?]"
echo 1 | hexagony truth.hxg | head -c 20; echo
echo "--- prime.hxg"
for n in 2 7 9 97 100; do printf '%s => ' "$n"; echo "$n" | hexagony prime.hxg; echo; done
