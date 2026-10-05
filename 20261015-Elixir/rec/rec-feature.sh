#!/usr/bin/env bash
# agg は idle_time_limit (2秒) で無音区間を詰めるため、見えない制御列を 1 秒ごとに出して
# 収録時の待ちをそのまま再生尺に残す (get_duration と描画尺を一致させる)。
# イメージは事前に ./run.sh でビルド済みとし、収録では build を挟まず直接起動する (起動時間のぶれを抑える)。
(while :; do printf '\033[?25h'; sleep 1; done) & ka=$!
here="$(cd "$(dirname "$0")/.." && pwd)"
container run --rm -it -v "$here/demo:/work" lang-elixir bash -c "$(cat $here/rec/inner-feature.sh)"
kill $ka
