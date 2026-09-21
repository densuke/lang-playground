#!/usr/bin/env bash
# 収録用 (前半)。版の確認から、金額の編集項目まで。
#
# 尺は動画のセクション (MAIN3) に合わせる。**長すぎると末尾が切れる。**
# 実行結果は終わり際ではなく、読む時間が残る位置に来るよう間を配る。
set -u
step() { printf '\n$ %s\n' "$1"; sleep 1; eval "$1" 2>/dev/null; sleep 2; }
cd /work
step 'cobc --version | head -2'
step "sed -n '5,8p' basics.cob"
step 'cobc -x basics.cob && ./basics'
sleep 9
printf '\n'
