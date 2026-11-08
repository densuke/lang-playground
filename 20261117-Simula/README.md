# Simula を試す (2026-11-17)

「古今東西 プログラミング言語紹介」2026-11-17 回の実験環境です。

## 使い方

```bash
./run.sh                                   # シェルに入る (cim が使える)
./run.sh bash -c 'cd /tmp && cp /work/*.sim . && cim hello.sim && ./hello'   # 1 本をコンパイルして動かす
./run.sh bash -s < demo.sh                 # 全部を順に実行する
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。
初回はソースからのビルドで 30 秒ほどかかります。

`cim` は `.o` と実行ファイルをカレントディレクトリへ書き出すので、上のように `/tmp` へコピーして動かすと `demo/` が汚れません。

## 処理系について

GNU Cim 5.1 (2014-05-18)。Simula 67 のコンパイラで、Simula を C に変換して gcc に渡します (GPL)。
`ftp.gnu.org/gnu/cim/cim-5.1.tar.gz` を sha256 で検証してソースからビルドします。
Debian には現行の cim パッケージがありません (woody の 3.36 が最後)。
arm64 / amd64 のどちらでも動きます (確認は arm64)。

Cim が同梱する事前生成 C に別ディレクトリ前提の include パスがあり、新しい環境では
そのままビルドできないので Dockerfile で 1 行直しています。

## 注意 (Simula で書くとき)

- `name` `label` `step` などは予約語なので変数名にできません
- コメントは `!` から最初の `;` まで。日本語は文字列やコードには置けず、コメントの中だけ
- 仮想手続きの宣言は、Cim では `VIRTUAL: PROCEDURE area IS REAL PROCEDURE area;;` と `;` が 2 つ必要でした
- 参照の代入は `:-`、値の代入は `:=`

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/hello.sim` | Hello World |
| `demo/classes.sim` | クラス・継承・仮想手続き・`IS` による型判別 |
| `demo/coroutine.sim` | `DETACH` / `RESUME` で 2 つのコルーチンを交互に動かす |
| `demo/bank.sim` | `SIMULATION` クラスによる離散事象シミュレーション (窓口 1 つの銀行) |
| `demo/shapes.sim` | クラス・接頭クラス (継承に当たる)・仮想手続きの最小例 (動画で端末に出した短い版) |
| `demo/coro.sim` | `DETACH` / `RESUME` の最小例 (動画で端末に出した短い版) |
| `demo/cars.sim` | `SIMULATION` と `Hold` の最小例。車 2 台が入って出る (動画で端末に出した短い版) |
