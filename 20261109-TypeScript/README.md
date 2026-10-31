# TypeScript を試す (2026-11-09)

「古今東西 プログラミング言語紹介」2026-11-09 回の実験環境です。

```bash
./run.sh                          # シェルに入る (tsc と node が使える)
./run.sh tsc --noEmit errors.ts   # 型エラーを見る
./run.sh bash -s < demo.sh        # 全部を順に実行する
```

処理系は TypeScript 7.0.2 (Go 製ネイティブ版、2026-07-08 公開、2026-10-31 時点の npm `latest`)。
公式 node イメージ 26.12.1 (digest 固定) に、`package-lock.json` で版と integrity を固定して `npm ci` で入れています。
`tsc` の出力を見るだけなら node は要りませんが、型を剥がして `.ts` を直接動かす Node.js の機能も demo で見せるため node イメージを使っています。
ベースの node イメージを取得済みなら、ビルドは約 15 秒です (初回のベース取得は別に数分かかります)。

TypeScript 7 は、カレントに `tsconfig.json` があるとファイルを指定した `tsc` がエラーになります (`--ignoreConfig` が要る)。
このため demo には `tsconfig.json` を置かず、フラグだけで動かしています。

| ファイル | 内容 |
|---|---|
| `demo/errors.ts` | 型エラーをコンパイル時に捕まえる (引数の型・数、タイプミス、別の型の代入) |
| `demo/infer.ts` | 型推論 (`.d.ts` に推論結果を書き出して見る。`typeof` による型の絞り込み) |
| `demo/structural.ts` | 構造的部分型 (形が合えば渡せる、足りなければ通らない) |
| `demo/erase.ts` | 型だけ消えて JavaScript になる (`tsc` の出力と、Node.js が `.ts` を直接実行する場合) |
| `demo.sh` | 上の 4 つを順に実行する |

ライセンス: TypeScript は Apache-2.0。demo のコードはこの回のために書いたものです。
