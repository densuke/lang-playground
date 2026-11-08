# Lazy K を試す (2026-11-20)

「古今東西 プログラミング言語紹介」2026-11-20 回 (esolang 枠・リクエスト) の実験環境です。

## 使い方

```bash
./run.sh                                         # シェルに入る (lazy / guile が使える)
printf 'stressed' | ./run.sh lazy /opt/lazyk/eg/reverse.lazy    # 入力を反転 (Jot 記法のプログラム)
./run.sh lazy -e 'SII(SII)'                      # 式を直接渡す (-e)。これは止まらない
./run.sh bash -s < demo.sh                       # 全部を順に実行する (2 秒ほど)
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。
初回だけビルドします (作者の配布物を取得してコンパイル、1 分ほど)。

## 処理系について

作者 Ben Rudiak-Gould 自身の配布物 (2002 年の Esoteric Awards 提出物) を、
`esoteric.sange.fi` の原文のまま取得して使います (`src/SHA256SUMS` で検証)。

- `lazy.cpp` ... インタプリタ (C++)。ファイル先頭に "Distributed under the GPL" (版の指定なし)
- `lazier.scm` ... ラムダ式 (Scheme 記法) から Lazy K へのコンパイラ。同じく GPL と明記
- `prelude.scm` / `prelude-numbers.scm` / `eg/*` ... 付属の定義と例題。許諾の記述が無いものがあるので、
  このリポジトリには入れず、ビルド時に取得する

2002 年のコードなので、そのままでは現代の環境で動かない 3 点だけ直しています。

- `lazy.cpp`: Windows 専用の `io.h` / `setmode` を外し、`operator new(unsigned)` を `unsigned long` に、
  一時オブジェクトのアドレス取得を関数経由に (`src/lazy.patch`。`-b` は POSIX では何もしない)
- `lazier.scm` / `prelude.scm`: Guile 3 が評価される `()` を構文エラーにするので、`'()` に直す (`sed` 3 箇所)

アルゴリズムには触っていません。Debian の apt に Lazy K は無いため、配布物をビルドしています。
別実装に irori/lazyk (C、MIT) があります (本環境では使っていません)。

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo.sh` | 下の例を順に実行する (9 項目) |
| `demo/ski-trace.scm` | SKI の簡約を 1 手ずつ表示 (自作の小さな簡約器、最左最外。遅延評価で `KI(SII(SII))` が止まること、`SII(SII)` が止まらないこと) |
| `demo/double.scm` | `lazier.scm` でラムダ式を 4 記法 (CC / Unlambda / Iota / Jot) に変換し、入力の各文字を 2 回ずつ出す `dup` を作る |
| `/opt/lazyk/eg/*` (コンテナ内) | 作者の例題: reverse / rot13 / ab / fib / primes / quine / unlambda (Lazy K で書かれた Unlambda 処理系) |
