set -u
O=/tmp/out
tsc --version
echo '--- errors.ts: 型エラーを実行前に捕まえる (tsc --noEmit) ---'
tsc --noEmit --pretty false errors.ts
echo "終了コード: $?"
echo '--- infer.ts: 推論された型を .d.ts に書き出す ---'
tsc --declaration --emitDeclarationOnly --outDir $O --pretty false infer.ts && cat $O/infer.d.ts
echo '--- structural.ts: 形が合えば通る。y が無いものは通らない ---'
tsc --noEmit --pretty false structural.ts
echo '--- erase.ts: 型を消すと JavaScript になる ---'
tsc --outDir $O --pretty false erase.ts && cat $O/erase.js
echo '--- 出力された JavaScript を node で動かす ---'
node $O/erase.js
echo '--- 型を剥がして node が .ts を直接実行する (型の検査はしない) ---'
node --version
node erase.ts
