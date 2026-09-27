# Scheme を試す (2026-08-20)

「古今東西 プログラミング言語紹介」2026-08-20 回の実験環境です。
動画: <https://www.youtube.com/watch?v=0rFm3xUnjXs>

## 使い方

```bash
./run.sh                        # 対話環境 (gosh) に入る
./run.sh gosh hello.scm         # 直接動かす
./run.sh bash -s < demo.sh      # 収録と同じ順に全部動かす
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。
処理系は apt で入るので、初回でも 1 分ほどで終わります。

## 処理系について

動画で紹介した **Gauche** (`gosh`) を使っています。Debian trixie の `gauche` パッケージが
0.9.15 系 (`gosh -V` の表示は `0.9.15-p2`) で、動画で案内した公式配布の 0.9.15 と同じ系列です。
公式のダウンロードページでは R7RS (small / large) への対応が明記されています
(<https://practical-scheme.net/gauche/download.html>)。

Scheme そのものは、Gerald Jay Sussman と Guy L. Steele が 1975 年 12 月のメモ
"SCHEME: An Interpreter For Extended Lambda Calculus" (AIM-349) で発表した Lisp の方言です
(<https://research.scheme.org/lambda-papers/>)。

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/hello.scm` | 動画で見せた Hello World・`cube`・再帰の `fact`。`(fact 30)` で多倍長整数も出る |
| `demo/tail.scm` | 末尾呼び出しの再帰と名前付き `let` で 1000 万回まわす |
| `demo/counter.scm` | 字句スコープ。`make-counter` が作るカウンタはそれぞれ自分の `count` を持つ |

## 実行結果

```
$ gosh hello.scm
Hello, World!
27
120
265252859812191058636308480000000

$ gosh tail.scm
10000000
50000005000000

$ gosh counter.scm
(a 3 b 1)
```

`tail.scm` の `count-up` は、自分自身の呼び出しが最後の処理 (末尾位置) にあるので、
呼び出しがスタックに積み上がらずループと同じように動きます。Scheme は、この末尾呼び出しの
最適化を処理系に義務づけた最初の言語とされています。

`counter.scm` では `a` を 3 回、`b` を 1 回呼んでいます。`count` はそれぞれの `lambda` が
作られたときの `let` の中にあるので、2 つのカウンタは互いに影響しません。

## つまずきやすい点

**`display` は改行しません。** 1 行ずつ出したいときは `(newline)` を続けて書きます。

**末尾位置でない再帰は積み上がります。** `hello.scm` の `fact` は `(* n (fact (- n 1)))` と、
再帰の結果に掛け算が残っているので末尾呼び出しではありません。深い再帰をループの代わりに
使いたいときは、`tail.scm` のように途中の結果を引数 (`acc`) で持ち回る形に書き換えます。

## ライセンス

`demo/` のコードは自由に使ってください。Gauche 本体は BSD ライセンスで配布されています
(Debian パッケージの `copyright` ファイルの記載による)。詳しくは
<https://practical-scheme.net/gauche/> を参照してください。
