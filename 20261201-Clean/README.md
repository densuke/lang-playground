# Clean を試す (2026-12-01)

「古今東西 プログラミング言語紹介」2026-12-01 回の実験環境です。

## 使い方

```bash
./run.sh                                                   # 対話シェル (bash) に入る
./run.sh bash -c 'cd /tmp && cp /work/hello.icl . && clm -ms hello -o hello && ./hello'
./run.sh bash -s < demo.sh                                 # 全部を順に実行する
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。
`demo/` が `/work` に入ります。Clean は `Clean System Files/` というフォルダにコンパイル結果を置くので、
`/work` に直接コンパイルすると `demo/` に生成物が出ます (`demo/.gitignore` で無視しています)。
作業コピーを `/tmp` に作ってからコンパイルすると汚れません。

## 処理系について

Clean 3.1 (公式の従来配布。BSD-2-Clause) を、sha256 を検証して `debian:trixie-slim` (digest 固定) に展開し、
`make` でライブラリを組み立てます。tarball はアーキテクチャで選びます (arm64 は `clean3.1_64_arm.tar.gz`、
amd64 は `clean3.1_64.tar.gz`)。**動かして確認したのは Linux/arm64 だけで、amd64 は未確認です。**
`clm` はコンパイルしたあとリンクに gcc を使うので、gcc も入れています。
`clm` を 1 回呼ぶとコンパイルからリンクまで済み、`./実行ファイル名` で動きます。

プログラムは `Start` の右辺を評価します (`main` はありません)。実行ファイルは、結果のあとに
標準エラーへ `Execution: ... Garbage collection: ... Total: ...` (秒) を出します。消したいときは `2>/dev/null`。

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/hello.icl` | `Start = "Hello World!"`。結果は値として (文字列は引用符つきで) 表示される |
| `demo/squares.icl` | リストの内包表記と、終わりのないリスト `[1..]` の遅延評価 |
| `demo/nfib.icl` | 再帰関数 (`nfib 38`)。実行時間も測れる |
| `demo/write_file.icl` | ユニーク型 `*File`。ファイルへ書いて、読み戻す |
| `demo/shared_file.icl` | 同じ `*File` を 2 か所で使う。**型検査でエラーになる** (ユニーク性を破る) |

## 実行結果 (Clean 3.1 / linux-arm64 / Apple container。`./run.sh bash -s < demo.sh`)

```
clm - Clean make - version 3.1
--- hello (Start の式を評価する。main は無い)
"Hello World!"
--- squares (内包表記と、終わりのないリストの遅延評価)
([1,4,9,16,25,36,49,64,81,100],[4,16,36,64,100,144,196,256,324,400])
--- nfib (コンパイルして実行時間を測る)
Execution: 0.13  Garbage collection: 0.00  Total: 0.13
126491971
--- write_file (*File を使って書いて、読み戻す)
"abc"
--- shared_file (ユニーク性を破る。型検査で拒否されるのが見せ場)
Uniqueness error [shared_file.icl,7,file]" demanded attribute cannot be offered by shared object
Uniqueness error [shared_file.icl,5,Start]:attribute at position indicated by ^ could not be coerced *(^ File,u:File)
Compiling shared_file
clm の終了コード: 1
```

(`time` の出力と `Execution` の行は標準エラーで、端末では順序が前後します。上は読みやすく並べ直してあります。)

## つまずきやすい点

- `clm` のオプションは module 名の**前**に置きます (`clm -ms hello -o hello`)。後ろに置くと使い方が表示されて失敗します。
- 実行ファイルに `-nt` を渡すと時間の表示が消え、`-nr` を渡すと結果の表示が消えます。
- `Start :: *World -> *World` の形では、`65536` という数が結果として表示されました (`-nr` で消えます。なぜ 65536 なのかは調べていません)。
  demo の `write_file.icl` は `*World -> String` にして避けています。
- `gcc` が無いと `Can't execute the linker` で実行ファイルを作れません。
