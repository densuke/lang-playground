# Unlambda を試す (2026-08-28)

「古今東西 プログラミング言語紹介」2026-08-28 回 (難解言語枠) の実験環境です。
動画: <https://www.youtube.com/watch?v=jimH3jAlGCw>

## 使い方

```bash
./run.sh sh -c 'unlambda < hello.unl'   # 直接動かす
./run.sh                                # シェルに入る
./run.sh bash -s < demo.sh              # 動画で流した順に実行する
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。

## 処理系について

**Debian の `unlambda` パッケージ** (trixie では 0.1.4.2) をそのまま使っています。
中身は Ørjan Johansen 氏らによる Haskell 実装で、ライセンスは GPL-2+ です
(パッケージ同梱の `/usr/share/doc/unlambda/copyright` より)。

Unlambda には、継続を捕まえる `c` や評価を遅らせる `d` のように挙動の繊細な部品があります。
自作の処理系は静かに間違うので、Thue 回や Fractran 回とは違い、既存の実装を使っています。

言語そのものは 1999 年に David Madore 氏が作ったものです (<https://en.wikipedia.org/wiki/Unlambda>)。
macOS の Homebrew にはパッケージが無いため、コンテナの Debian で動かす形にしました。

## 言語の中身

**変数も関数定義の構文もありません。** 組み込みの関数と、適用を表すバッククォートだけで書きます。

| 記号 | 意味 |
|---|---|
| `` ` `` | 適用。`` `FG `` は「F を G に適用する」 |
| `k` | 片方を捨てる。```` ``kXY ```` は `X` になる |
| `s` | 関数を配る。````` ```sXYZ ````` は ```` ``XZ`YZ ```` になる |
| `i` | 恒等関数。何もしない |
| `.x` | 文字 `x` を印字して、引数をそのまま返す |
| `r` | 改行を印字する (`.` の改行版) |

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/hi.unl` | 動画で紹介した、`Hi` を出す最小の例 |
| `demo/k.unl` | `k` が `.b` を捨てるので `a` だけが出る |
| `demo/s.unl` | `s` が `i` を `.a` と `.b` の両方に配るので `ab` と出る |
| `demo/hello.unl` | 動画で紹介した `Hello, World!`。バッククォートは 14 個 (`r` の分 1 個 + 文字の分 13 個) |
| `demo/hello_short.unl` | `hello.unl` からバッククォートを 1 個減らしたもの |

## 実行結果

````
$ cat hi.unl
``.H.ii

$ unlambda < hi.unl
Hi

$ cat k.unl
```k.a.bi

$ unlambda < k.unl
a

$ cat s.unl
```s.a.bi

$ unlambda < s.unl
ab

$ cat hello.unl
`r`````````````.H.e.l.l.o.,. .W.o.r.l.d.!i

$ unlambda < hello.unl
Hello, World!

$ cat hello_short.unl
`r````````````.H.e.l.l.o.,. .W.o.r.l.d.!i

$ unlambda < hello_short.unl
Hello, World
````

`hi.unl` と `k.unl` と `s.unl` は出力の最後に改行を出さないので、`demo.sh` の側で
表示をそろえるために改行を足しています。

`hello_short.unl` はバッククォートが 1 個足りないだけで、最後の `!` が**黙って消えます**。
エラーは出ません。バッククォートが 1 個足りないと、`.!` は「適用される関数」ではなく
最後の引数として読まれ、印字されないまま終わります。余った `i` は式の外に出て読み捨てられます。

動画では「一つ減らすと `Hello, worl` で終わる」と紹介しましたが、この実験環境で 1 個だけ減らした
ときに実際に消えたのは最後の `!` 1 文字でした。

## つまずきやすい点

**プログラムはファイル名ではなく標準入力から読みます。** `unlambda < hello.unl` と
書いてください。この処理系は引数のファイル名を読まずに標準入力を待つので、
`unlambda hello.unl` と書くと、端末では入力待ちのまま止まったように見えます。

**バッククォートの数を間違えてもエラーになりません。** 上の `hello_short.unl` のように
出力の一部が黙って欠けます。文字を 1 つ足したら、バッククォートも 1 つ足してください。

**適用の向きに注意してください。** バッククォートを前にまとめて、左から順に適用する形で
書きます。```` `.H`.e... ```` のように入れ子の向きを変えると、文字の出る順番が逆になります。

## ライセンス

`demo/` のコードは自由に使ってください。処理系 (`unlambda` パッケージ) は GPL-2+ です。
