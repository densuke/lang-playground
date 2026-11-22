# Zig を試す (2026-12-03)

「古今東西 プログラミング言語紹介」2026-12-03 回の実験環境です。

## 使い方

```bash
./run.sh                                              # 対話シェル (bash) に入る
./run.sh bash -c 'cd /work && zig build-exe hello.zig -femit-bin=/tmp/h && /tmp/h'   # Hello World
./run.sh bash -c 'cd /work && zig test fib_test.zig'  # comptime を含むテスト
./run.sh bash -s < demo.sh                            # 全部を順に実行する
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。
`demo/` が `/work` に入ります。`zig build-exe` は既定で作業ディレクトリに実行ファイルを置くので、
`-femit-bin=/tmp/...` で逃がしています。

## 処理系について

Zig 0.17.1 (2026-11-02 リリース、MIT)。ziglang.org の公式配布物 `zig-aarch64-linux-0.17.1.tar.xz` を取得し、
sha256 (公式 index.json の値) と minisign (公式ダウンロードページの公開鍵) で検証して展開します。
ベースは `debian:trixie-slim` を digest で固定。ビルドは不要で、イメージの作成は 1 分ほどです。

**Zig は 1.0 前で、版ごとに言語と標準ライブラリが変わります。** demo は 0.17.1 で動く書き方です。
ネットの古い記事のコード (`std.io.getStdOut()` など) は動きません (`demo/old_hello.zig`)。

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/hello.zig` | Hello World (0.17.1 の書き方。io は main の引数から受け取る) |
| `demo/fib_test.zig` | 同じ関数を実行時とコンパイル時に呼ぶテスト (`zig test`) |
| `demo/table.zig` | 平方数の表をコンパイル時に作る |
| `demo/alloc.zig` | アロケータを引数で渡す (隠れたメモリ確保がない) |
| `demo/comptime_overflow.zig` | comptime で呼んだ関数のあふれが**コンパイルエラー**になる |
| `demo/old_hello.zig` | 古い書き方。0.17.1 では**コンパイルエラー**になる |

クロスコンパイルは `zig build-exe hello.zig -target x86_64-windows` のように `-target` を変えるだけです
(Linux 上で Windows / macOS / WebAssembly 向けを作り、`file` で形式を確かめられます)。
