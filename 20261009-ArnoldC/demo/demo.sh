#!/usr/bin/env bash
# 収録用 (前半)。hello world から、吐かれたバイトコードを覗くまで。
#
# 尺は動画のセクションに合わせる。**長すぎると末尾が切れる。**
# 実行結果は終わり際ではなく、読む時間が残る位置に来るよう間を配る。
set -u
step() { printf '\n$ %s\n' "$1"; sleep 1; eval "$1" 2>/dev/null; sleep 2; }
cd /work
step 'cat hello.arnoldc'
step 'arnoldc hello.arnoldc'
step 'ls *.class'
step 'java hello'
sleep 7
printf '\n'
