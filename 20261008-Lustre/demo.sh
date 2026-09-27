# 動画で流す順に実行する。 ./run.sh bash -c "$(cat demo.sh)"
set -e
cd /work
lv6 --version
# カウンタ。reset を f f f t f f と与える
printf 'f\nf\nf\nt\nf\nf\n' | lv6 counter.lus -n counter -exec 2>/dev/null | grep outs
# フィボナッチ。入力の無いノードは止まらないので先頭だけ見る
lv6 fib.lus -n fib -exec | grep outs | head -n 10
# 因果ループはコンパイル時に弾かれる
lv6 bad.lus -n bad 2>&1 | grep -A1 '^Error' || true
# C を生成してコンパイル・実行 (生成物は /tmp に置く)
cd /tmp && cp /work/counter.lus .
lv6 counter.lus -n counter -2c 2>/dev/null >/dev/null && sh counter.sh >/dev/null 2>&1
printf 'f\nf\nt\nf\n' | ./counter.exec | grep -v '^#' | grep .
