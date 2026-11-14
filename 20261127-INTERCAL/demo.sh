set -u
# -b は「ランダムな E774 (コンパイラの気まぐれな失敗) を出さない」指定。デモを毎回同じ結果にするため
T=/tmp/ick-demo
mkdir -p "$T" && cp /work/*.i "$T" && cd "$T"
echo '### 1. Hello, World! (14 文字ぶんの配列を 17 行で組み立てる。PLEASE は 5 行)'
cat hello.i
echo '--- コンパイル (ick) と実行'
ick -b hello.i && ./hello
echo
echo '### 2. 数値は (拡張) ローマ数字で出る (#1990 / #4 / #2026)'
cat roman.i
ick -b roman.i && ./roman
echo
echo '### 3. PLEASE が足りない (全 16 行が DO)'
ick -b rude.i; echo "ick の終了コード=$?"
echo
echo '### 4. PLEASE が多すぎる (全 16 行が PLEASE)'
ick -b servile.i; echo "ick の終了コード=$?"
echo
echo '### 5. COME FROM (1 の直後に COME FROM へ飛ぶ。間の READ OUT (A を出す文) は飛ばされる)'
cat comefrom.i
ick -b comefrom.i && ./comefrom
echo '--- COME FROM の行だけ取ると (間の READ OUT が実行されて A も出る)'
grep -v 'COME FROM' comefrom.i > nocome.i
ick -b nocome.i && ./nocome
