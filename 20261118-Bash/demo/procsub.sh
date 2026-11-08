#!/usr/local/bin/bash
# プロセス置換: コマンドの出力をファイルのように渡す
diff <(printf 'a\nb\nc\n') <(printf 'a\nB\nc\n') && echo same || echo "差分あり (rc=$?)"
echo "---"
# パイプと違い、while の中の変数が残る (サブシェルにならない)
count=0
while read -r line; do count=$((count + 1)); done < <(printf 'x\ny\nz\n')
echo "行数: $count"
# 比較: パイプだとサブシェルなので 0 のまま
count=0
printf 'x\ny\nz\n' | while read -r line; do count=$((count + 1)); done
echo "パイプ版: $count"
