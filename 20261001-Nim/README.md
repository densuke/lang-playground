# Nim を試す (2026-10-01)

「古今東西 プログラミング言語紹介」2026-10-01 回の実験環境です。

## 使い方

```bash
./run.sh                                          # シェルに入る
./run.sh nim c -r -o:/tmp/a /work/basics.nim      # コンパイルして実行
./run.sh bash -s < demo.sh                        # 動画で流した順に実行する
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。
Debian の `nim` は trixie から消え、bookworm も 1.6 系で古いので、公式イメージを使っています。

出力先を `/tmp` にしているのは、`demo/` がホストと共有されているためです。バイナリを
ホストへ書き出したくないときはこうします。

## 処理系について

**Nim 2.2.4** です。Nim は**いったん C のソースへ落として、C コンパイラでビルドします**。
だから「Python に見えるものが C と同じ速さで動く」という言い方になります。
生成された C は `~/.cache/nim/` に残るので覗けます。

```
$ ./run.sh nim c --hints:off -o:/tmp/a /work/basics.nim
$ ./run.sh sh -c 'ls ~/.cache/nim/basics_d/ | head -3'
@m..@snim@slib@spure@sstrutils.nim.c
@m..@snim@slib@spure@sstrutils.nim.c.o
@m..@snim@slib@sstd@sassertions.nim.c
```

C / C++ / JavaScript のどれへも出せます (`nim js`)。

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/basics.nim` | Hello World・フィボナッチ・型推論。**インデントで構造を書く** |
| `demo/compiletime.nim` | **コンパイル時に走る計算。** 同じ関数を実行時にも使える |
| `demo/macro.nim` | マクロ。構文木を組み立てて返す |

## 実行結果

```
$ nim c --hints:off -o:/tmp/b /work/basics.nim && /tmp/b
Hello, world!
@[0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
3 NIM

$ nim c --hints:off -r -o:/tmp/ct /work/compiletime.nim
これはコンパイル中に出る: 2432902008176640000
[1, 1, 2, 6, 24, 120, 720, 5040, 40320, 362880]

$ nim c --hints:off -r -o:/tmp/mac /work/macro.nim
構文木: StmtList
  Command
    Ident "echo"
    Infix
      Ident "+"
      IntLit 1
      IntLit 2
2 回出る
2 回出る
3
```

`compiletime.nim` の `const table` は**ビルド中に全部計算されて**、実行時には表を引くだけに
なります。`fact` は普通の `proc` で、コンパイル時用に別に書いたものではありません。

`macro.nim` の「構文木:」はコンパイル中の出力です。実行前に出ているところが見どころです。

## つまずきやすい点

**識別子の大文字小文字とアンダースコアが無視されます** (先頭の 1 文字を除く)。
`fooBar` と `foo_bar` は同じものです。驚きますが仕様です。

**`result` という変数が最初からあります。** `proc` の中では戻り値の置き場として使えます。
自分で `result` という名前を付けると衝突します。

**標準ライブラリは明示的に import します。** `basics.nim` は `toUpperAscii` のために
`import std/strutils` が要ります。忘れると `undeclared field` と言われます。

**C コンパイラが必要です。** このイメージには入っていますが、手元に入れるときは
`gcc` か `clang` を先に用意してください。

## ライセンス

`demo/` のコードは自由に使ってください。Nim 本体は MIT ライセンスです。
