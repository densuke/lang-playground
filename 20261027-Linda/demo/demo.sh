#!/bin/sh
# 3 本を順に流す。stdin は使わない。
cd /work
mkdir -p /tmp/ebin
erlc -o /tmp/ebin hello.erl prodcons.erl taskbag.erl
for m in hello prodcons taskbag; do
    echo "=== $m"
    erl +pc unicode -noshell -pa /tmp/ebin -eval "$m:run()." -s init stop
done
