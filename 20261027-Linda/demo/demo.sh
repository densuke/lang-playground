#!/bin/sh
# 引数なしなら 3 本を順に流す。引数 (hello / prodcons / taskbag) があればそれだけ。stdin は使わない。
cd /work
mkdir -p /tmp/ebin
erlc -o /tmp/ebin hello.erl prodcons.erl taskbag.erl
[ "$#" -eq 0 ] && set -- hello prodcons taskbag
for m in "$@"; do
    echo "=== $m"
    erl +pc unicode -noshell -pa /tmp/ebin -eval "$m:run()." -s init stop
done
