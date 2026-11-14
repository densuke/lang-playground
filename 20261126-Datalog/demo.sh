# コンテナ内で bash -s に流して使う。出力は /tmp へ (demo/ を汚さない)
set -u
cd /work
souffle --version | head -3
echo "--- ancestor (右再帰)"; souffle ancestor.dl -D-
echo "--- left_recursion (左再帰でも止まる)"; souffle left_recursion.dl -D-
echo "--- reachability (循環のあるグラフ + 否定)"; souffle reachability.dl -D-
echo "--- diverge (止まらない。3 秒で打ち切る)"
timeout 3 souffle diverge.dl -D- > /tmp/diverge.out 2>&1; echo "souffle の終了コード: $? (124 = timeout が打ち切った)"
echo "3 秒間に出た行数: $(wc -l < /tmp/diverge.out) (固定点に届かないので何も出ない)"
echo "--- not_stratified (否定が再帰の中。拒否されるのが見せ場)"
souffle not_stratified.dl -D- 2>&1; echo "souffle の終了コード: $?"
