# コンテナ内で bash -s に流して使う。バイナリは /tmp へ出す (demo/ を汚さない)
set -u
cd /work
# build-exe は既定で作業ディレクトリへ出力するので、-femit-bin で /tmp に逃がす
run() { zig build-exe "$1.zig" -femit-bin="/tmp/$1" 2>&1 && "/tmp/$1"; }
# 失敗が見せ場のもの。コンパイラの出力 (先頭だけ) と終了コードを見せる
fails() { zig build-exe "$1.zig" -femit-bin=/tmp/x > /tmp/e 2>&1; c=$?; head -4 /tmp/e; echo "zig の終了コード: $c"; }

zig version
echo "--- hello (0.17.1 の書き方)"; run hello
echo "--- fib_test (zig test。実行時とコンパイル時の両方で確かめる)"; zig test fib_test.zig 2>&1
echo "--- table (平方数の表をコンパイル時に作る)"; run table
echo "--- alloc (アロケータを引数で渡す)"; run alloc
echo "--- comptime_overflow (あふれをコンパイル時に見つける)"; fails comptime_overflow
echo "--- old_hello (古い記事の書き方は 0.17.1 では通らない)"; fails old_hello
echo "--- クロスコンパイル (どれも Linux 上で作る)"
for t in x86_64-windows aarch64-macos wasm32-wasi; do
    zig build-exe hello.zig -target "$t" -femit-bin="/tmp/h-$t" 2>&1 && file "/tmp/h-$t" | cut -c1-110
done
