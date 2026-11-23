set -u
T=/tmp/bf-demo
mkdir -p "$T" && cp /work/* "$T" && cd "$T"
echo '### 1. 作者本人の hello.b を beef で動かす'
cat hello.b
beef hello.b
echo "beef の終了コード=$?"
echo
echo '### 2. README の対応表を switch に写した 38 行の処理系 (mini.c) で、同じ hello.b を動かす'
gcc -Wall -o mini mini.c && ./mini hello.b
echo "mini の終了コード=$?"
echo
echo '### 3. 足し算 (add.b)。命令以外の文字は無視されるので、日本語のコメントが書ける'
cat add.b
beef add.b; echo
./mini add.b; echo
echo
echo '### 4. 入力を写す (dup.b)。入力が尽きたときの扱いは処理系しだい'
echo 'hello' | beef dup.b
echo 'hello' | ./mini dup.b
echo
echo '### 5. 括弧が閉じていない (beef は実行前に止める)'
echo '[[+]' > bad.b
beef bad.b; echo "beef の終了コード=$?"
