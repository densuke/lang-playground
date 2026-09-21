#!/usr/bin/env bash
# 収録用 (後半)。十進演算と二進浮動小数点の対比。
#
# 尺は動画のセクション (MAIN5) に合わせる。**長すぎると末尾が切れる。**
# 切れるのは決まって最後の実行結果、つまり一番見せたい所になる。
set -u
step() { printf '\n$ %s\n' "$1"; sleep 2; eval "$1" 2>/dev/null; sleep 3; }
cd /work
step "grep -n 'VALUE 0\.' decimal.cob"
step 'cobc -x decimal.cob && ./decimal'
sleep 5
printf '\n'
