cd /work
alloy version 2>/dev/null
for f in hello smallscope addressbook temporal; do
  echo "=== $f.als ==="
  # 見つかった命令の一覧 (SAT=インスタンス/反例あり、UNSAT=範囲内に無い)。実行中の表示は NativeCode の雑音を除く
  alloy exec -f -c '*' -t text -o /tmp/$f $f.als 2>&1 | grep -v NativeCode
  # 見つかったインスタンス/反例。組み込みの univ や Int の行は省く
  for t in /tmp/$f/*.txt; do
    [ -e "$t" ] || continue
    echo "--- $(basename "$t" .txt)"
    grep -v -E '^(univ|Int|seq/Int|String|none)=' "$t"
  done
done
