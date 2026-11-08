# 各 .sim を C 経由でコンパイルして動かす (生成物は /tmp/build に置く)。
mkdir -p /tmp/build && cp /work/*.sim /tmp/build/ && cd /tmp/build
for f in hello classes coroutine bank shapes coro cars; do
    echo "=== $f.sim ==="
    cim "$f.sim" > "$f.log" 2>&1 || { cat "$f.log"; exit 1; }
    "./$f"
done
