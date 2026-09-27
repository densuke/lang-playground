# PostScript を試す (2026-09-02)

「古今東西 プログラミング言語紹介」2026-09-02 回の実験環境です。
動画: <https://www.youtube.com/watch?v=EU2cyulBI7k>

## 使い方

```bash
./run.sh gs -q -dNODISPLAY -dBATCH -dNOPAUSE stack.ps   # 直接動かす
./run.sh                                                 # シェルに入る
./run.sh bash -s < demo.sh                               # 動画で流した順に実行する
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。
処理系は apt で入るので、初回でも 1 分ほどで終わります。

## 処理系について

**Ghostscript** (Debian の `ghostscript` パッケージ、動作確認時は 10.05.1) を使っています。
PostScript と PDF のインタプリタで、macOS なら `brew install ghostscript`、
Debian / Ubuntu なら `apt install ghostscript` で入ります (<https://www.ghostscript.com/>)。

PostScript は 1984 年ごろに Adobe Systems で、John Warnock と Chuck Geschke を中心とする
チームが作ったとされる言語です (<https://en.wikipedia.org/wiki/PostScript>)。
ページ記述言語として知られていますが、条件分岐・ループ・再帰を書けるチューリング完全な
言語で、Forth に似たスタック型の作りをしています。

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/hello.ps` | 動画で見せた Hello World。Wikipedia の PostScript 記事に載っている形そのまま |
| `demo/stack.ps` | 逆ポーランド記法。`3 4 add` で 7 になる、を含む四則演算 |
| `demo/program.ps` | 印刷だけではない例。`for` ループ、再帰の階乗、`ifelse` による分岐 |

## 実行結果

```
$ cat hello.ps
%!PS
/Courier
20 selectfont
72 500 moveto
(Hello world!) show
showpage

$ gs -q -dBATCH -dNOPAUSE -sDEVICE=txtwrite -sOutputFile=- hello.ps
    Hello world!

$ gs -q -dNODISPLAY -dBATCH -dNOPAUSE stack.ps
7
20
3.5

$ gs -q -dNODISPLAY -dBATCH -dNOPAUSE program.ps
1
2
3
4
5
3628800
odd
```

`hello.ps` は「ページに文字を描く」プログラムなので、そのままでは端末に何も出ません。
`txtwrite` デバイスを使うと、ページ上に描かれた文字をテキストとして取り出せます。
先頭の空白は、左端から 72 ポイント離して描いた分を空白で再現したものです。

`stack.ps` と `program.ps` はページを描かず、`=` 演算子でスタックの値を標準出力へ
書き出しています。`2 3 add 4 mul` のように、括弧なしで `(2 + 3) * 4` が書けるのが
逆ポーランド記法の特徴です。

## つまずきやすい点

**`-dBATCH` を付けないと、ファイルを実行し終えたあと対話モード (`GS>`) に入って止まります。**
`demo.sh` のように標準入力から続けてコマンドを流している場合は、残りのコマンドを
PostScript として読み込んでしまいます。`-dNOPAUSE` はページごとの一時停止を止める
オプションで、これも付けておきます。

**コンテナには画面がありません。** 画面に描く既定のデバイスは使えないので、計算だけなら
`-dNODISPLAY`、描いた結果を見たいなら `-sDEVICE=png16m -sOutputFile=out.png` のように
画像やファイルへ書き出します。`demo/` はホストとの共有ディレクトリなので、画像を書き出すと
ホスト側に残ります。

**`txtwrite` の出力は行末が CRLF です。** 画面では気になりませんが、出力をファイルに保存して
比べるときは改行コードの違いに注意してください。

**PostScript の「印刷」は `=` (または `==`) です。** `show` はページに描く命令で、
標準出力には何も出しません。

## ライセンス

`demo/hello.ps` は Wikipedia の PostScript 記事 (<https://en.wikipedia.org/wiki/PostScript>)
に掲載されている Hello World をそのまま使っています。それ以外の `demo/` のコードは
自由に使ってください。

Ghostscript 本体は、Debian パッケージの copyright ファイルによると AGPL-3.0 以降です。
詳しくは <https://www.ghostscript.com/> を参照してください。
