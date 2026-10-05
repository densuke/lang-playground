# Elixir を試す (2026-10-15)

「古今東西 プログラミング言語紹介」2026-10-15 回の実験環境です。

## 使い方

```bash
./run.sh                                # 対話環境 (iex) に入る
./run.sh elixir /work/hello.exs         # 直接動かす
./run.sh bash -s < demo.sh              # 全部を順に実行する
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。

## 処理系について (なぜ公式イメージか)

公式イメージ `elixir:1.20.4-slim` を使います。arm64 / amd64 の両方が配られています。
Debian の apt でも入りますが、trixie (stable) の版は 1.18.3 と古めです。
公式イメージなら最新の 1.20.4 がそのまま動きます。

```
$ ./run.sh elixir --version
Erlang/OTP 29 [erts-17.1] [source] [64-bit] [smp:5:4] [ds:5:4:10] [async-threads:1] [jit]

Elixir 1.20.4 (compiled with Erlang/OTP 29)
```

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/hello.exs` | Hello World・パイプ演算子 `\|>` |
| `demo/match.exs` | パターンマッチ。関数の頭と `case` で場合分けする |
| `demo/process.exs` | 軽量プロセスとメッセージ。10 万個のプロセスも作る |

## 実行結果

```
$ ./run.sh elixir /work/hello.exs
Hello, world!
Elixir Is Fun
[4, 16, 36, 64, 100]

$ ./run.sh elixir /work/match.exs
[0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
value = 42
読めない: :enoent

$ ./run.sh elixir /work/process.exs
受信: 1
受信: 4
受信: 9
100000 プロセスの合計: 5000050000
```

`受信:` の順番は保証されません。3 つのプロセスがそれぞれ独立に返事をするためです。

(Apple container は実行のたびに進捗を標準エラーへ出します。上の出力からは省いています。)

## つまずきやすい点

**`.exs` と `.ex` は使い道が違います。** `.exs` はスクリプト用、`.ex` はコンパイルして使う用です。公式ガイドによると、扱いそのものは同じです。
ここでは `elixir` コマンドでそのまま動く `.exs` を使っています。

**`iex` は Ctrl+C を 2 回押すと抜けます。** 1 回目で選択メニューが出ます。

**`IO.puts` と `IO.inspect` の違い。** `IO.puts` は文字列を出します。リストなどは `IO.inspect` で出します。
`IO.inspect` は受け取った値をそのまま返すので、パイプの途中に挟んで中身を覗けます。

## ライセンス

`demo/` のコードは自由に使ってください。Elixir 本体は Apache License 2.0 です。
