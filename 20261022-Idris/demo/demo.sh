# 版を見る
idris2 --version
# Hello World
idris2 --build-dir /tmp/b /work/hello.idr --exec main
# 長さ付きベクトル。append の型は Vect (n + m) a 、firstOf は空でない Vect だけ受け取る
printf ":t append\n:t firstOf\n:q\n" | idris2 --no-banner --build-dir /tmp/b /work/vect.idr
idris2 --build-dir /tmp/b /work/vect.idr --exec main
# 長さが合わないと型エラー (コンパイルが通らない)
idris2 --build-dir /tmp/b --check /work/bad_length.idr || echo "exit=$?"
# 全域性チェック (total) 。n = 0 の場合の抜けを検出する
idris2 --build-dir /tmp/b --check /work/bad_total.idr || echo "exit=$?"
