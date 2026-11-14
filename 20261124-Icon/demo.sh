# 各 .icn を icont でコンパイルして動かす (生成物は /tmp/build に置く)。
mkdir -p /tmp/build && cp /work/*.icn /tmp/build/ && cd /tmp/build
icon -V 2>&1 | head -1
for f in hello every fail scan gen cast_every cast_fail cast_gen; do
    echo "=== $f.icn ==="
    icont -s -o "$f" "$f.icn" || exit 1
    "./$f"
done
