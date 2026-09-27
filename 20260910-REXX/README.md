# REXX を試す (2026-09-10)

「古今東西 プログラミング言語紹介」2026-09-10 回の実験環境です。
動画: <https://www.youtube.com/watch?v=Qoc-Pikrr0M>

## 使い方

```bash
./run.sh rexx /work/hello.rexx   # 直接動かす
./run.sh                         # シェルに入る
./run.sh bash -s < demo.sh       # 動画で流した順に実行する
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。
処理系は apt で入るので、初回でも 1 分ほどで終わります。

## 処理系について

**Regina REXX** (Debian の `regina-rexx` パッケージ、動作確認時は 3.9.5) を使っています。
オープンソースの REXX 実装で、macOS なら `brew install regina-rexx` でも入ります。
ほかにオブジェクト指向を足した ooRexx、Java バイトコードへコンパイルする NetRexx などの
実装もあります (<https://en.wikipedia.org/wiki/Rexx>)。

REXX は IBM ハーズリー研究所の Mike Cowlishaw が 1979 年 3 月 20 日に書き始めた言語です。
最初の名前は REX で、1982 年の商標調査で Rex-80 という無関係の製品が見つかったため、
X を足して REXX になりました。どちらも作者本人の 40 周年講演資料で確認できます
(<https://www.rexxla.org/presentations/2019/Rexx40.pdf>)。

## 入っているもの

動画の制作時にファクトチェック用のコンテナで実行を確かめたコード (`check.rexx`) を、
テーマごとに 3 本へ分けたものです。

| ファイル | 内容 |
|---|---|
| `demo/hello.rexx` | Hello World。出力は `say` だけ |
| `demo/parse.rexx` | `parse var` で、区切り文字を並べるだけで日付を分解する |
| `demo/decimal.rexx` | `0.1 + 0.2` が `0.3` になる。十進のまま計算している |

## 実行結果

```
$ rexx /work/hello.rexx
Hello, world!

$ cat /work/parse.rexx
/* REXX らしい PARSE。区切り文字を並べるだけで文字列を切り分ける */
line = "2026-09-10 REXX"
parse var line yyyy '-' mm '-' dd ' ' name
say "年:" yyyy "月:" mm "日:" dd "言語:" name

$ rexx /work/parse.rexx
年: 2026 月: 09 日: 10 言語: REXX

$ rexx /work/decimal.rexx
0.3
```

`parse var line yyyy '-' mm '-' dd ' ' name` は「`line` を、`-` の手前まで `yyyy` に、
次の `-` の手前まで `mm` に、空白の手前まで `dd` に、残りを `name` に入れる」という意味です。
正規表現とは考え方が違い、区切り文字や桁位置を順に並べて書きます。

`decimal.rexx` は、二進の浮動小数点で計算する多くの言語なら `0.30000000000000004` に
なるところです (Python の `print(0.1 + 0.2)` など)。REXX は数も文字列として持ち、
十進のまま計算するのでずれません。

## つまずきやすい点

**Regina の `rexx` にはパス付きでファイルを渡してください。** `rexx hello.rexx` のように
ファイル名だけを渡すと、カレントディレクトリにあっても
`Error 3.1: Failure during initialization: Program was not found` になります。
`rexx ./hello.rexx` か `rexx /work/hello.rexx` なら動きます。`demo.sh` では
`/work/` から書いています。

**変数の宣言はありません。** 値を入れていない変数は、自分の名前を大文字にした文字列として
扱われます。綴りを間違えてもエラーにならず、その名前がそのまま出力されるので注意してください。

**日本語を含むソースは UTF-8 ロケールで動かしています。** この `Dockerfile` では
`locales` を入れて `en_US.UTF-8` を生成し、`LANG` に設定しています。

## ライセンス

`demo/` のコードは自由に使ってください。Regina REXX 本体は、Debian パッケージの
copyright ファイルによると LGPL-2.0 以降です。
