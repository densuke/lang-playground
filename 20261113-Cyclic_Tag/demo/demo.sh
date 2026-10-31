#!/usr/bin/env bash
# コンテナの中で流す。例: ./run.sh bash -s < demo/demo.sh
set -u
cd /work || exit 1
ct() { python3 ct.py "$@"; }

echo "=== 1. Cook の例: 生成規則 (011, 10, 101)、データ語 1 (esolangs.org の例と同じ)"
ct ct "011,10,101" 1 -n 10

echo
echo "=== 2. 停止する例: 生成規則 (00, 10, 11)、データ語 101 は 121 ステップ後に空になる"
ct ct "00,10,11" 101 -n 200 --every 10
echo "(最後のステップを確認)"
ct ct "00,10,11" 101 -n 200 | tail -3

echo
echo "=== 3. 増え続ける例: Cook の図 2 の規則 (YYY, N) = (111, 0)、データ語 1"
ct ct "111,0" 1 -n 24

echo
echo "=== 4. 計算になっている: Collatz (n 偶数 -> n/2、奇数 -> (3n+1)/2) を巡回タグで"
echo "    規則 (010001,100,100100100,,,) / データ語 = 100 を n 個。1 周 (6 ステップ) ごとの k を読む"
ct ct "010001,100,100100100,,," 100100100 -n 120 --every 6 |
    awk '{ d=$5; sub(/^D=/,"",d); if (d ~ /^(100)+$/) printf "step %3d  Collatz の項 k = %d\n", $2, length(d)/3 }'

echo
echo "=== 5. BCT (Bitwise Cyclic Tag): プログラム 00111、データ語 101 (esolangs.org の例と同じ)"
ct bct 00111 101 -n 12
echo "--- 生成規則 (011,10,101) を BCT にする (0<-10, 1<-11, ;<-0)"
ct tobct "011,10,101"
echo "--- 変換が正しいか: BCT の ; (単独の 0 コマンド) を通った直後のデータ語が、CT の同じステップと一致するか"
python3 - <<'PY'
from ct import run_ct, run_bct, to_bct
rules, data = ["011", "10", "101"], "1"
ct_words = [d for _, _, d in run_ct(rules, data, 30)]
bct_words = [data] + [d for _, c, d in run_bct(to_bct(rules), data, 3000) if c == "0"][:30]
n = min(len(ct_words), len(bct_words))
print(f"{n} ステップぶん比較:", "一致" if ct_words[:n] == bct_words[:n] else "不一致")
PY

echo
echo "=== 6. Rule 110 (Cook が巡回タグで万能性を示した 1 次元セルオートマトン) を 1 セルから"
ct rule110 70 30
