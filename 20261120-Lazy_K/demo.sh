set -u
L=/opt/lazyk
echo '### 1. 何もしないプログラム (空) = 恒等関数 = cat'
echo 'hello' | lazy -e ''
echo
echo '### 2. 入力を反転 (作者の reverse.lazy は Jot 記法・0 と 1 が 1078 個)'
printf 'stressed' | lazy $L/eg/reverse.lazy; echo
echo
echo '### 3. rot13 を 2 回合成 (lazy の引数を並べると合成になる)'
echo 'Hello, Lazy K' | lazy $L/eg/rot13.lazy
echo 'Hello, Lazy K' | lazy $L/eg/rot13.lazy $L/eg/rot13.lazy
echo
echo '### 4. 無限出力 (入力を無視して ABAB... を出し続ける。head で切る)'
lazy $L/eg/ab.lazy | head -c 40; echo
echo
echo '### 5. フィボナッチ (星の行) と素数 (出力が貯まるので stdbuf で行バッファ)'
lazy $L/eg/fib.lazy | head -n 8
timeout -s INT 2 stdbuf -o0 lazy $L/eg/primes.lazy | head -c 150; echo
echo
echo '### 6. SKI の簡約を 1 手ずつ表示 (遅延評価の見せ場)'
guile --no-auto-compile /work/ski-trace.scm
echo
echo '### 7. ラムダ式から Lazy K へ (lazier.scm) と、できた dup の実行'
guile --no-auto-compile /work/double.scm
echo 'hello' | lazy /tmp/dup.lazy
echo
echo '### 8. 終了コードで値を返す (出力リストの 256 以上は終端、256 を引いた値が終了コード)'
guile --no-auto-compile -c '
(load "/opt/lazyk/lazier.scm") (load "/opt/lazyk/prelude.scm") (load "/opt/lazyk/prelude-numbers.scm")
(lazy-def (quote main) (quote (lambda (input) (k (+ 256 7)))))
(with-output-to-file "/tmp/exit7.lazy" (lambda () (print-as-unlambda (laze (quote main)))))'
lazy /tmp/exit7.lazy; echo "exit=$?"
echo
echo '### 9. Lazy K で書かれた Unlambda インタプリタ (作者の unlambda.lazy) に Unlambda を食わせる'
echo '`r````````````.H.e.l.l.o.,. .w.o.r.l.di' | lazy $L/eg/unlambda.lazy
