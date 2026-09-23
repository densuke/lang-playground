# Racket を試す (2026-09-29)

「古今東西 プログラミング言語紹介」2026-09-29 回の実験環境です。

## 使い方

```bash
./run.sh                                # 対話環境 (racket) に入る
./run.sh racket /work/basics.rkt        # 直接動かす
./run.sh racket /work/hello.mylang      # 自作言語で書いたファイルを動かす
./run.sh bash -s < demo.sh              # 動画で流した順に実行する
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。

## 処理系について

本家 **Racket 8.16** です。もとは PLT Scheme という名前で、2010 年に改名しました。
「プログラミング言語を作るための言語」を名乗っており、ファイルの 1 行目に書く `#lang` で
使う言語そのものを選びます。

```
$ ./run.sh
Welcome to Racket v8.16 [cs].
> (define (add1* x) (+ x 1))
> (map add1* '(1 2 3))
'(2 3 4)
```

GUI の開発環境 DrRacket もありますが、このイメージには入れていません
(X が要るので重くなります)。手元に入れるなら公式インストーラが楽です。

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/basics.rkt` | Hello World・フィボナッチ・`match` によるパターンマッチ |
| `demo/macro.rkt` | マクロ。**既存の `unless` と同じものを自作し、言語に無い `while` を足す** |
| `demo/hello.mylang` | **自作言語で書いたファイル。** 括弧を使わず `1 + 2` と書く |
| `demo/mylang/main.rkt` | 自作言語の語彙 (使える名前をここで決める) |
| `demo/mylang/lang/reader.rkt` | 自作言語の読み方 (1 行を 1 つの式として読む) |

## 実行結果

```
$ ./run.sh racket /work/basics.rkt
Hello, world!
(0 1 1 2 3 5 8 13 21 34)
2 要素: 1 2
数

$ ./run.sh racket /work/macro.rkt
1 は 2 より大きくない
i = 0
i = 1
i = 2

$ ./run.sh racket /work/hello.mylang
3
42
17
```

`hello.mylang` の 1 行目は `#lang mylang` です。**2 行目から先に括弧は 1 つもありません。**
`1 + 2` のような中置の式を `reader.rkt` が読み取り、Racket の式に組み直しています。
使えるのは `+` と `*` だけ (`*` が先)。試しに `5 - 1` を足すとエラーになります。
引き算は許していないからです。

## つまずきやすい点

**`#lang` を書き忘れると読めません。** 1 行目に何の言語かを書くところから始まります。

**マクロと関数は別物です。** `unless` を関数で書くと引数が先に評価されてしまうので、
「評価しない」ことを表現するにはマクロが要ります。

**`'(1 2 3)` のクォートは「評価しない」という印です。** 付け忘れると `1` を関数として
呼びに行って落ちます。

**`#lang mylang` が動くのは `PLTCOLLECTS` のおかげです。** `#lang mylang` は
`mylang/lang/reader.rkt` を collection から探します。Dockerfile で `PLTCOLLECTS=/work:` を
設定し、`/work` (= `demo/`) を collection の置き場にしています。コンテナの外で動かすときは
`PLTCOLLECTS="$PWD/demo:" racket demo/hello.mylang` のように同じ設定を渡してください。

## ライセンス

`demo/` のコードは自由に使ってください。Racket 本体は MIT / Apache 2.0 のデュアルです。
