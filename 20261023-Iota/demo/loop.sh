#!/bin/sh
# 発散する式は止まらない。10 秒で打ち切って様子を見る (124 = timeout、137 = KILL)。
# 1. (SII)(SII) の Iota 訳 (Barker のページの例)
# 2. Mike Stay の 27 記号の式 (esolangs.org 記載。正規形を持たない最短の式)
for p in '****i*i*i*ii*ii*ii***i*i*i*ii*ii*ii' '*i***i*i*i*ii**i*i*i*ii*iii'; do
    echo "--- $p"
    timeout 10 guile --no-auto-compile -c "(load \"iota.scm\") (iota-eval \"$p\") (display \"returned\")" >/tmp/out 2>&1
    echo "exit=$? 出力: $(head -c 200 /tmp/out)"
done
