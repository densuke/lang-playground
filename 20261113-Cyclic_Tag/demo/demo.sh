#!/usr/bin/env bash
# コンテナの中で流す。例: ./run.sh bash -s < demo/demo.sh
set -u
cd /work || exit 1
ct() { python3 ct.py "$@"; }

echo "=== 1. BCT (Bitwise Cyclic Tag): プログラム 00111、データ語 101 (esolangs.org の例と同じ)"
ct bct 00111 101 -n 12

echo
echo "=== 2. 0 だけのプログラム: 先頭のビットを 1 つずつ消すだけ。データ語が空になると停止"
ct bct 0 1011

echo
echo "=== 3. 停止する例: 生成規則 (00, 10, 11) を BCT にしたプログラム、データ語 101"
ct tobct "00,10,11"
ct bct "$(ct tobct "00,10,11")" 101 -n 5000 --quiet

echo
echo "=== 4. 増え続ける例: 生成規則 (111, 0) を BCT にしたプログラム、データ語 1 (10 ステップごと)"
ct tobct "111,0"
ct bct "$(ct tobct "111,0")" 1 -n 60 --every 10

echo
echo "=== 5. BCT の土台 (Cyclic Tag System): 生成規則 (011, 10, 101)、データ語 1 (esolangs.org の例と同じ)"
ct ct "011,10,101" 1 -n 6
echo "--- 生成規則を BCT にする (0 <- 10, 1 <- 11, 規則の終わり <- 0)"
ct tobct "011,10,101"
echo "--- 変換が正しいか: BCT の 0 だけの命令 (規則の終わり) を通った直後のデータ語が、元の規則の同じステップと一致するか"
python3 - <<'PY'
from ct import run_ct, run_bct, to_bct
rules, data = ["011", "10", "101"], "1"
ct_words = [d for _, _, d in run_ct(rules, data, 30)]
bct_words = [data] + [d for _, c, d in run_bct(to_bct(rules), data, 3000) if c == "0"][:30]
n = min(len(ct_words), len(bct_words))
print(f"{n} ステップぶん比較:", "一致" if ct_words[:n] == bct_words[:n] else "不一致")
PY

echo
echo "=== 6. 計算になっている: Collatz (k が偶数なら k/2、奇数なら (3k+1)/2) を BCT で"
python3 collatz_bct.py 3
python3 collatz_bct.py 7

echo
echo "=== 7. Rule 110 (巡回タグが万能性の証明に使われた 1 次元セルオートマトン) を 1 セルから"
echo "    (時空図の雰囲気だけ。BCT をこの上で動かす実装ではない)"
ct rule110 70 30
