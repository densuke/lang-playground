# Icon を試す (2026-11-24)

「古今東西 プログラミング言語紹介」2026-11-24 回の実験環境です。

## 使い方

```bash
./run.sh                                   # シェルに入る (icon / icont が使える)
./run.sh bash -c 'cd /tmp && cp /work/every.icn . && icont -s every.icn && ./every'   # 1 本をコンパイルして動かす
./run.sh bash -s < demo.sh                 # 全部を順に実行する
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。
初回はソースからのビルドで 1 分ほどかかります。

`icont` は `.u1` / `.u2` と実行ファイルをカレントディレクトリへ書き出すので、上のように `/tmp` へコピーして動かすと `demo/` が汚れません。

## 処理系について

Icon 9.5.25a (2025-09-07)。Arizona 大学の公式実装で、ソースは GitHub (gtownsend/icon) で管理されています。
タグ `v9.5.25a` のアーカイブを sha256 で検証し、ソースからビルドします (public domain、グラフィックスなし)。
Debian trixie の `icon` パッケージは 9.5.24b、sid は 9.5.25a です。
arm64 / amd64 のどちらでも動きます (確認は arm64)。

## 注意 (Icon で書くとき)

- `a < b` は成功すると **右辺の値** を返します (`100 < fib()` は fib の値)。真偽値はありません
- `every` は式の全部の値を引き出し、`if` / `while` は「値が出たか (成功)」だけを見ます
- 文字集合は `'-'` (cset)、文字列は `"-"`。`upto` は cset を取ります
- 数値の代入 `:=`、交換 `:=:`、加算代入 `+:=`、個数制限 `e \ n`

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/hello.icn` | Hello World |
| `demo/every.icn` | ジェネレータ (`to` / `\|` / `!s`) と `every` |
| `demo/fail.icn` | 失敗で分岐する `if`、最初の成功、バックトラック、失敗する引数 |
| `demo/scan.icn` | 文字列走査 (`?` / `find` / `move` / `tab` / `upto`) |
| `demo/gen.icn` | `suspend` による手続きのジェネレータ、無限のフィボナッチ、頻度表 |
| `demo/cast_every.icn` | every の短縮版 (動画の端末収録用) |
| `demo/cast_fail.icn` | fail の抜粋 (動画の端末収録用) |
| `demo/cast_gen.icn` | gen の fib 部分 (動画の端末収録用) |

## 動画の収録

`rec-run.sh` / `rec-feature.sh` は動画の端末収録 (cast) 用です。待ち時間は動画の台詞の尺に合わせてあります。`rec-all.sh` が asciinema で録画し、`align-cast.py` で最初のプロンプトの時刻を揃えます。
