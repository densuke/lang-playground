# Unison を試す (2026-10-13)

「古今東西 プログラミング言語紹介」2026-10-13 回の実験環境です。

## 使い方

```bash
./run.sh                                  # UCM (Unison Codebase Manager) に入る
./run.sh ucm transcript /work/hello.md    # transcript を 1 本流す
./run.sh bash /work/demo.sh               # 動画で流した順に実行する
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。

## 処理系について

本家 (unisonweb/unison) の公式リリース **UCM 1.5.0** です。Dockerfile の `UCM_VERSION` で
版を固定しています。linux-arm64 / linux-x64 の両方のバイナリが配られているので、
Apple silicon の Mac でもそのまま動きます。

```
$ ./run.sh ucm version
unison version: release/1.5.0 (built on 2026-09-29)
```

## Unison はテキストファイルで動かさない

Unison のコードは「コードベース」というデータベースに入ります。`.u` ファイルは
下書きで、UCM が読み込んで `add` したものがコードベースに入ります。

ここでは対話操作の代わりに **transcript** を使います。Markdown に UCM の操作
(` ```ucm `) と Unison のコード (` ```unison `) を並べておくと、UCM が上から順に
実行して結果を `*.output.md` に書き出します。transcript は毎回まっさらな
コードベースで動き、最初に標準ライブラリ `@unison/base` を Unison Share から入れます
(**ネットワークが要ります**)。

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/hello.md` | Hello World・フィボナッチ |
| `demo/ask.md` | 自前のアビリティ `Ask` と、差し替え可能な 2 つのハンドラ |
| `demo/hash.md` | 名前ではなくハッシュで定義を区別する。同じ中身なら同じハッシュ、改名しても呼び出し側は壊れない |
| `demo/nohandler.md` | ハンドラ無しでアビリティを使うと型エラーになる |
| `demo/demo.sh` | 上をまとめて流す |

## 実行結果 (抜粋)

```
== hash.md
scratch/main> names double

  'double':
  Hash          Kind   Names
  #hmt4gnn927   Term   double

  + twice : Nat -> Nat
      (also named double)

scratch/main> names twice

  'twice':
  Hash          Kind   Names
  #hmt4gnn927   Term   double, twice

scratch/main> move.term double timesTwo

  Done.

scratch/main> view quad

  quad : Nat -> Nat
  quad n = timesTwo (timesTwo n)
```

`double x = x * 2` と `twice y = y * 2` は、名前も引数名も違うのに**同じハッシュ**になります。
`double` を `timesTwo` に改名すると、`quad` の本文も新しい名前で表示されます。
`quad` が持っているのは名前ではなくハッシュなので、改名で壊れません。
