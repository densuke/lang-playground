# Miranda を試す (2026-09-03)

「古今東西 プログラミング言語紹介」2026-09-03 回の実験環境です。
動画: <https://www.youtube.com/watch?v=_f1h1xLnN5c>

## 使い方

```bash
./run.sh                          # 対話環境 (mira) に入る。/quit で抜ける
./run.sh mira -exec squares.m     # 直接動かす
./run.sh bash -s < demo.sh        # 収録と同じ順に全部動かす
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。
処理系をソースからビルドするので、初回は apt だけの環境より少し時間がかかります。

## 処理系について

David Turner の **Miranda 2.068** を使っています。Miranda は 2020 年に BSD ライセンスで
公開されました。いまのソースは Codeberg の <https://codeberg.org/DATurner/miranda> で
保守されていて、2.068 はそこで 2026 年 8 月 31 日に出たリリースです。

公式サイト (<https://www.cs.kent.ac.uk/people/staff/dat/miranda/>) のダウンロードページに
あるソースは 2020 年 1 月の 2.066 です。Codeberg 版の `README.md` には、2.066 は
そのままではコンパイルできないと書かれているので、Codeberg のリリースを使っています。

Debian にはパッケージが無いので、`Dockerfile` ではリリースの tarball を取ってきて、
リリースノートに載っている SHA-256 と照合してから `make install` でビルドしています。

`mira -exec ファイル名` は、スクリプトの中の `main` を評価して、その文字列を出力します。

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/fac.m` | 動画の `fac n = product [1..n]`。1 から 10 までの階乗と、多倍長整数になる 30 の階乗 |
| `demo/squares.m` | 動画の `squares = [ n * n \| n <- [1..] ]`。終わりのない列から先頭 10 個を取る |
| `demo/rev.m` | パターンマッチによるリストの反転 (`rev [] = []` / `rev (a:x) = rev x ++ [a]`) |

## 実行結果

```
$ mira -exec fac.m
[1,2,6,24,120,720,5040,40320,362880,3628800]
265252859812191058636308480000000

$ mira -exec squares.m
[1,4,9,16,25,36,49,64,81,100]

$ mira -exec rev.m
[5,4,3,2,1]
adnariM
```

`squares` は `[1..]` から作った終わりのないリストですが、`take 10` が必要とする 10 個だけが
計算されるので、すぐに終わります。

## つまずきやすい点

**`mira` はスクリプトの隣に `.x` ファイルを作ります。** `fac.m` を動かすと、コンパイル済みの
中間コード `fac.x` が `demo/` にできます。`demo.sh` は最後にこれを消しています。
`./run.sh mira -exec ...` で直接動かしたときは残るので、気になる場合は消してください
(`demo/.gitignore` で Git の管理からは外しています)。

**`./run.sh mira ファイル名` は対話環境に入ります。** `-exec` を付けずに動かすと、スクリプトを
読み込んだあと標準入力から式を待ちます。`./run.sh bash -s < demo.sh` のように標準入力が
パイプになっていると、`demo.sh` の残りを Miranda の式として読んでしまいます。
デモでは必ず `-exec` を付けています。

**最適化オプションを付けてビルドしないでください。** ソースに同梱の `README` によると、
ガーベジコレクタは C のスタックを走査してヒープへのポインタを探す作りで、強い最適化を
かけると `impossible event` やセグメンテーション違反で落ちることがあります。`Dockerfile` では
`Makefile` の既定どおり最適化なしでビルドしています。

## ライセンス

`demo/` のコードは自由に使ってください。Miranda 本体は BSD 2 条項ライセンスで配布されています
(ソースに同梱の `miralib/COPYING` による)。Miranda は Research Software Limited の商標です。
