# LISP を試す (2026-10-05)

「古今東西 プログラミング言語紹介」2026-10-05 回の実験環境です。

## 使い方

```bash
./run.sh                                     # 対話環境 (sbcl) に入る
./run.sh sbcl --script /work/basics.lisp     # 直接動かす
./run.sh bash -s < demo.sh                   # 全部を順に実行する
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。
処理系は apt で入るので、初回でも 1 分ほどで終わります。

## 処理系について (なぜ SBCL か)

この回の主題は **1958 年に MIT で生まれた原典の LISP** (LISP 1.5 まで) です。
ところが原典の LISP は IBM 704 / 7090 の上で動いていた処理系で、いま手軽に動くものがありません。
SIMH の IBM 7094 シミュレータに当時のファイルを載せれば動くという記録はありますが、
準備が重いので今回は導入していません。

そこで **Common Lisp の処理系 SBCL** を使います。Common Lisp は LISP 1.5 から
MacLisp などを経て 1984 年に本 (CLtL) としてまとまり、1994 年に ANSI 規格になった子孫です。
原典にある `car` / `cdr` / `cons` / `cond` / `atom` / `eval` と再帰だけで書けば、
ほぼ当時の考え方のまま動きます。

版は Debian trixie の apt が配る **SBCL 2.5.2** です (本家の最新は 2.6.8)。

```
$ ./run.sh sbcl --version
SBCL 2.5.2.debian
```

**原典との違い** (このコードで気になる範囲だけ)

- 原典の論文は関数を `car[x]` のような M 式で書き、S 式はデータ用でした。実際には S 式で書くのが定着しました
- Common Lisp では偽も空リストも `nil`、真は `t` です

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/basics.lisp` | Hello World・フィボナッチ。ループ構文を使わず `cond` と再帰だけ |
| `demo/list.lisp` | `cons` / `car` / `cdr`。1960 年の論文にある `ff` 関数 |
| `demo/eval.lisp` | コードはデータ。リストとして組み立てた式を `eval` で実行する |

## 実行結果

```
$ ./run.sh sbcl --script /work/basics.lisp

"Hello, world!" 
(0 1 1 2 3 5 8 13 21 34) 

$ ./run.sh sbcl --script /work/list.lisp

(A B C) 
A 
(B C) 
B 
A 
3 

$ ./run.sh sbcl --script /work/eval.lisp

(+ 2 3 4) 
9 
24 
```

`eval.lisp` では `(+ 2 3 4)` という**ただのリスト**を作り、評価すると 9 になります。
先頭の `+` を `*` に差し替えるだけで 24 になります。プログラムとデータが同じ形をしている
ことが LISP の中心です。

(Apple container は実行のたびに `[0/6] ... Starting container` という進捗を標準エラーへ出します。
上の出力からは省いています。)

## つまずきやすい点

**`print` は改行してから表示します。** 出力の先頭に空行が入り、文字列は `"` 付きで出ます。
読み戻せる形で出す関数だからです。人向けに出すなら `princ` や `format` を使います。

**`cond` の最後の `t` は「それ以外」です。** 条件に `t` (真) を置くと必ず当たります。

**`'a` は `(quote a)` の略です。** 付け忘れると `a` を変数として評価しにいき、エラーになります。

**記号は大文字で表示されます。** `'a` は `A` と出ます。読み込み時に大文字へそろえるためです。

## ライセンス

`demo/` のコードは自由に使ってください。SBCL 本体は寛容なライセンスのオープンソースです (sbcl.org)。
