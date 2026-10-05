# Hexagony を試す (2026-10-16)

「古今東西 プログラミング言語紹介」2026-10-16 回 (esolang 枠) の実験環境です。

Hexagony は Martin Ender (当時の名前は Martin Büttner) が 2015 年 9 月に公開した esolang です。
ソースコードが**正六角形**に並べ直され、命令ポインタがその上を動きます。メモリも別の六角形の
格子で、値を持つのはマスではなく**辺**です。名前は "hexagon" と "agony" (苦痛) を合わせたものです。

処理系は作者の Ruby 製リファレンス実装 (`m-ender/hexagony`) を、コミット `b674f59a` に固定して
取り込んでいます。

## 使い方

```bash
./run.sh                                  # シェルに入る
./run.sh hexagony /work/hello.hxg         # Hello, World!
./run.sh sh /work/demo.sh                 # 収録用デモを順に流す
./run.sh hexagony -g 4                    # 一辺 4 の空の六角形を出す (書き始めの雛形)
./run.sh sh -c 'echo 7 | hexagony /work/prime.hxg'   # 素数判定 (1 なら素数)
```

`hexagony` は `ruby /opt/hexagony/interpreter.rb` のラッパーです。`-d` で `` ` `` を付けた命令の
デバッグ表示、`-D` で 1 命令ごとの詳細表示になります。

## demo/ の中身

| ファイル | 内容 |
|---|---|
| `hello.hxg` | 公式の Hello World (六角形に整形した形) |
| `hello-compact.hxg` | 同じプログラムを 1 行に詰めた形。出力は同じ |
| `hello-ppcg.hxg` | 作者が Code Golf SE で公開した 32 バイト版 |
| `truth.hxg` | 真理機械 (esolangs.org 掲載の 6 文字版)。0 なら 0 を出して終わり、1 なら 1 を出し続ける |
| `prime.hxg` | 公式の素数判定 (compact 版) |
| `demo.sh` | 上を順に流すスクリプト |

## 空白は飾り

処理系はまず空白をすべて捨て、残りの文字数を「中心付き六角数」(1, 7, 19, 37, 61 …) まで
`.` (何もしない命令) で埋めて、正六角形に並べ直します。だから次の 2 つは同じプログラムです。

```
   H ; e ;
  l ; d ; *
 ; r ; o ; W
l ; ; o ; * 4
 3 3 ; @ . >
  ; 2 3 < \
   4 ; * /
```

```
H;e;l;d;*;r;o;Wl;;o;*433;@.>;23<\4;*/
```

## 実測でわかったこと

### 真理機械は「0 で割って」止まる

`truth.hxg` (`?!':)!`) には終了命令 `@` がありません。入力 0 のときは `:` (割り算) で 0 除算が
起き、Ruby の例外で処理系ごと落ちて止まります。標準出力には `0` が出ます。

```
$ echo 0 | hexagony truth.hxg
/opt/hexagony/hexagony.rb:114:in 'Integer#/': divided by 0 (ZeroDivisionError)
...
0
```

仕様で決まった止まり方ではなく、ゴルフ (最短コード) の世界でよく使われる手です。
