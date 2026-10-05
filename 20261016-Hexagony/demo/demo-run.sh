#!/usr/bin/env bash
# 収録用 (前半)。六角形に並べた Hello World と、1 行に詰めた同じプログラム。
#
# 尺は動画のセクションに合わせる。待ちは台詞の位置に合わせてある (MAIN3)。
set -u
step() { printf '\n$ %s\n' "$1"; sleep 1; eval "$1" 2>/dev/null; sleep "${2:-3}"; }
cd /work
step 'cat hello.hxg; echo' 6
step 'hexagony hello.hxg; echo' 1.5
step 'cat hello-compact.hxg; echo' 5.5
step 'hexagony hello-compact.hxg; echo' 10
printf '\n'
