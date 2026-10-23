#!/usr/bin/env bash
# コンテナの中で流す。例: ./run.sh bash -s < demo.sh
# 生成物でデモの置き場を汚さないよう、作業用ディレクトリにコピーして動かす。
set -u
work=$(mktemp -d)
cp /work/* "$work" && cd "$work" || exit 1
l2b() { perl lam2blc.pl "$@"; }

echo "=== 1. 恒等関数 \\x.x を BLC にする (添字は \\.1)"
l2b -s id.lam
echo "プログラムを 0010 の 4 ビットだけにして、入力をそのまま返す (cat になる)"
(l2b -B id.lam; echo "Hello, BLC") | tromp

echo "=== 2. \\x y z. z x y (ペア) -> ラムダ式から BLC へ"
printf '\\x y z. z x y' | l2b -s
echo "(ページに載っている 00 00 00 01 01 10 1110 110 と同じ)"

echo "=== 3. 文字列を出す: 入力を無視して Hi を返す"
echo -n "ビット数: "; l2b hi.lam | wc -c
(l2b -B hi.lam; echo -n "x") | tromp; echo

echo "=== 4. 自己解釈器 U のビット数"
echo -n "U: "; l2b -d uni.dbj | wc -c
echo "U を U の上で動かす: 万能機械の入力に U の符号 + 恒等関数 + データ(ビット列)"
echo "(データ 0100100001101001 = 'Hi' のビット列をそのまま返す)"
(l2b -d uni.dbj; l2b id.lam; echo -n 0100100001101001) | tromp -b; echo

echo "=== 5. 132 ビットの quine (Q の符号を 2 回並べた入力から、同じものが出る)"
q=$(l2b -d quine.dbj)
echo -n "Q のビット数: "; echo -n "$q" | wc -c
in="$q$q"
out=$(echo -n "$in" | tromp -b)
echo "入力 = 出力 ? $([ "$in" = "$out" ] && echo はい || echo いいえ)"

echo "=== 6. 167 ビットの素数列プログラム (primes.blc) の出力の先頭 70 ビット"
head -c 20 /opt/blc/primes.blc; echo " ... (全 $(wc -c < /opt/blc/primes.blc) ビット)"
tromp -b < /opt/blc/primes.blc | head -c 70; echo

echo "=== 7. Brainfuck インタプリタ (bf.Blc) で Hello World"
echo -n "bf.Blc: "; wc -c < /opt/blc/bf.Blc
cat /opt/blc/bf.Blc /opt/blc/hw.bf | tromp
