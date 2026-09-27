# Inform 7 を試す (2026-08-25)

「古今東西 プログラミング言語紹介」2026-08-25 回の実験環境です。
動画: <https://www.youtube.com/watch?v=pHXQWWB1xsU>

## 使い方

```bash
./run.sh                                  # シェルに入る。exit で抜ける
./run.sh i7 diner.ni diner.txt            # diner.ni をコンパイルし、diner.txt の各行を入力して遊ぶ
./run.sh bash -s < demo.sh                # 収録と同じ順に全部動かす
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。
処理系をソースからビルドするので、初回は数分かかります。

## 処理系について

言語の名前は Inform 7 ですが、処理系には別の版番号が付いています。ここで使っているのは
Inform 7 言語の処理系の最新リリース **Inform 10.1.2** (2022 年 8 月 31 日) です。

公式の配布物 (<https://github.com/ganelson/inform/releases>) は GUI アプリだけで、
Linux 向けの deb / rpm は amd64 版しかありません。そこで `Dockerfile` では、公式 README の
Build Instructions どおりに inweb 7.2.0 / intest 2.1.0 / inform 10.1.2 のリリースを
取ってきて、SHA-256 を確かめたうえでソースからビルドしています。Apple Silicon の Mac でも
arm64 のまま動きます。

Debian の `inform` パッケージは Inform 6 で、Inform 7 とは別の言語です。ここでは使いません。

Inform 7 のコンパイラは、ソースを Inform 6 のコードに翻訳します。それを同梱の Inform 6 で
Glulx 形式のゲームにし、同梱の glulxe (画面制御を使わない cheapglk 版) で動かします。
この 3 段をまとめたのが `i7` コマンドです。

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/kitchen.ni` | 動画のいちばん短いプログラム `The Kitchen is a room.` |
| `demo/diner.ni` | 動画の、部屋をつなげて物を置く例 (Diner と lamp) |
| `demo/rules.ni` | `Instead of ...` / `After ...` で、行動に対する規則を書く例 |
| `demo/*.txt` | それぞれのゲームに流し込むプレイヤーの入力 (1 行 1 コマンド) |

## 実行結果

```
$ i7 kitchen.ni kitchen.txt
Inform 7 v10.1.2 has started.
I've now read your source text, which is 5 words long.
I've also read Basic Inform by Graham Nelson, which is 7691 words long.
I've also read English Language by Graham Nelson, which is 2328 words long.
I've also read Standard Rules by Graham Nelson, which is 32164 words long.

  The 5-word source text has successfully been translated. There were 1 room
    and 1 thing.
----

Welcome
An Interactive Fiction
Release 1 / Serial number 160428 / Inform 7 v10.1.2

Kitchen

> look
Kitchen

> jump
You jump on the spot.

> inventory
You are carrying nothing.

>
<end of input>

$ i7 diner.ni diner.txt
Inform 7 v10.1.2 has started.
I've now read your source text, which is 28 words long.
I've also read Basic Inform by Graham Nelson, which is 7691 words long.
I've also read English Language by Graham Nelson, which is 2328 words long.
I've also read Standard Rules by Graham Nelson, which is 32164 words long.

  The 28-word source text has successfully been translated. There were 2 rooms
    and 2 things.
----

Welcome
An Interactive Fiction
Release 1 / Serial number 160428 / Inform 7 v10.1.2

Kitchen
You can see a lamp here.

> examine lamp
A small brass lamp.

> take lamp
Taken.

> south
Diner

> inventory
You are carrying:
  a lamp

> north
Kitchen

>
<end of input>

$ i7 rules.ni rules.txt
Inform 7 v10.1.2 has started.
I've now read your source text, which is 63 words long.
I've also read Basic Inform by Graham Nelson, which is 7691 words long.
I've also read English Language by Graham Nelson, which is 2328 words long.
I've also read Standard Rules by Graham Nelson, which is 32164 words long.

  The 63-word source text has successfully been translated. There were 2 rooms
    and 2 things.
----

Welcome
An Interactive Fiction
Release 1 / Serial number 160428 / Inform 7 v10.1.2

Kitchen
A small kitchen. A door leads south.

You can see a cake here.

> take cake
Taken.

> eat cake
Not here. Cake is for the Diner.

> south
The Diner smells of coffee.

Diner

> eat cake
You eat the cake. Not bad.

> inventory
You are carrying nothing.

>
<end of input>
```

`The Kitchen is a room.` の 1 行だけで、`look` や `jump` や `inventory` を受け付けるゲームに
なっています。動詞の意味や応答の文章は、コンパイラが自動で読み込む Standard Rules に
書かれています。

`The Diner is south of the Kitchen.` と書くだけで、北への道も自動でつながります。
`south` で Diner に移り、`north` で Kitchen に戻れています。

## つまずきやすい点

**`> ` の後ろの入力は、`i7` が差し込んでいます。** glulxe (cheapglk 版) は流し込まれた入力を
画面に出しません。そのままだと応答だけが並んで読みにくいので、`i7` が `.txt` の行を
プロンプトの後ろに書き足しています。最後の `<end of input>` は、入力が尽きたことを示す
glulxe のメッセージです。

**プロジェクトには `uuid.txt` が要ります。** Inform 7 のコンパイラは `.inform` という
ディレクトリ構造を前提にしていて、`uuid.txt` が無いと構文とは関係のないエラーで止まります。
`i7` は一時ディレクトリにこの構造を作ってからコンパイルしています。

**バナーの Serial number は日付から作られます。** 毎回同じ出力になるように、`i7` は
`-fixtime` (2016 年 3 月 28 日のふりをする) を付けてコンパイルしています。
そのため Serial number が `160428` になっています。

**ビルドには clang が要ります。** `gcc` だけの環境では inweb のビルドで止まります。

## ライセンス

`demo/` のコードは自由に使ってください。Inform 本体は Artistic License 2.0 で、
glulxe と cheapglk は MIT License で配布されています (ソースに同梱の `LICENSE` による)。
