# Rust を試す (2026-11-16)

「古今東西 プログラミング言語紹介」2026-11-16 回の実験環境です。

## 使い方

```bash
./run.sh                                       # 対話シェル (bash) に入る
./run.sh rustc --edition 2024 /work/hello.rs   # コンパイルしてカレントに hello を作る
./run.sh bash -s < demo.sh                     # 全部を順に実行する
./run.sh bash -c 'rustc --edition 2024 -o /tmp/r /work/result.rs && /tmp/r'   # 1 本だけ動かす
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。
`demo/` が `/work` に入ります。rustc 単体で動かすときは `--edition 2024` を付けます (付けないと 2015 edition)。

## 処理系について

公式イメージ `rust:1.99.1-slim-trixie` (Rust 1.99.1、2026-10-15 リリース。MIT OR Apache-2.0) を、
マニフェストの digest で固定して使います。arm64 / amd64 の両方が配られています。
Debian の apt (trixie) の rustc は 1.85.1 で古めなので、公式イメージのほうが最新に近いです。

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/hello.rs` | Hello World |
| `demo/result.rs` | Result と `?` 演算子の最小例 (動画の実行例) |
| `demo/option_result.rs` | Option / Result / `?` 演算子 (null の代わりに Option を使う) |
| `demo/patterns.rs` | enum と match、ガード、配列の分解 |
| `demo/ownership_move.rs` | 所有権の移動。**コンパイルエラーになる** (E0382) |
| `demo/borrow_conflict.rs` | 借用の衝突。**コンパイルエラーになる** (E0502) |
| `demo/non_exhaustive.rs` | match の網羅漏れ。**コンパイルエラーになる** (E0004) |
| `demo/cargo-demo/` | `cargo run` / `cargo test` が使える最小プロジェクト |
