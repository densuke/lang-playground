#!/usr/local/bin/bash
# プロセス置換: コマンドの出力をファイルのように渡す
diff <(printf 'a\nb\nc\n') <(printf 'a\nB\nc\n') || echo "差分あり"
echo "---"
count=0
while read -r line; do count=$((count + 1)); done < <(printf 'x\ny\nz\n')
echo "プロセス置換: $count"
count=0
printf 'x\ny\nz\n' | while read -r line; do count=$((count + 1)); done
echo "パイプ: $count"
