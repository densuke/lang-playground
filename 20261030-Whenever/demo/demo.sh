#!/bin/sh
cd /work
echo '=== Hello, world! (1 行)'; ./wh 1 hello.we
echo; echo '=== 2 行版: 2 行目は defer(1) で 1 行目が済むまで待つ'
for s in 1 2 4; do ./wh $s hello2.we | tr '\n' ' '; echo "(seed=$s)"; done
echo; echo '=== defer 無し: 4 行を書いた順に出す保証は無い (seed を変えると順序が変わる)'
for s in 1 2 4; do ./wh $s unordered.we | tr '\n' ' '; echo "(seed=$s)"; done
echo; echo '=== 99 Bottles の縮小版 (3 本)'; ./wh 1 bottles.we
echo; echo '=== Fibonacci (仕様ページの例、上限を 100 から 10 に縮小)'; ./wh 1 fib.we | tr '\n' ' '; echo
