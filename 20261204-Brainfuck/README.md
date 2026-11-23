# Brainfuck を試す (2026-12-04)

「古今東西 プログラミング言語紹介」2026-12-04 回 (esolang 枠) の実験環境です。

## 使い方

```bash
./run.sh                                   # 対話シェル (bash) に入る (beef と gcc が使える)
./run.sh beef /work/hello.b                # 作者本人の hello.b を動かす
./run.sh bash -c 'cd /tmp && cp /work/mini.c . && gcc -o mini mini.c && ./mini /work/hello.b'
./run.sh bash -s < demo.sh                 # 全部を順に実行する (1 秒かからない)
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。
初回だけビルドします (Debian のパッケージを入れるだけ、1 分かかりません)。`demo/` が `/work` に入ります。

## 処理系について

- **作者 Urban Müller の原典 (1993 年、`brainfuck-2.lha`) は Amiga (m68k) 専用**で、macOS / Linux では動きません。
  配布物にライセンスの記述が見当たらないので、このリポジトリには同梱せず、ビルド時の取得もしていません (参照のみ)。
- 動かしているのは **Debian trixie の `beef` 1.2.0-2 (第三者の再実装)**。ライセンスは GPL-2+ で、
  apt で入るため同梱もビルド時取得も要りません。ベースは `debian:trixie-slim` を digest で固定しています。
- `demo/mini.c` は、原典 README の「8 命令と C 言語の対応表」を `switch` に写した 38 行の処理系です (このリポジトリで書いた自作)。
  入力の終わりは 0 を入れる、括弧の対応は調べない、という最小限の作りです。

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/hello.b` | 作者本人の `src/hello.b` (Hello World!、187 バイト)。原典は 80 桁で改行されていたものを、読みやすいよう 60 桁で折り返し直しただけで、命令は同じ |
| `demo/mini.c` | 自作の処理系 (38 行)。`gcc -o mini mini.c` |
| `demo/add.b` | 2 と 3 を足して `5` を出す。日本語のコメントが書ける (命令以外の文字は無視) |
| `demo/dup.b` | 入力を 1 文字ずつ出す `,[.,]`。入力が尽きたときの扱いが処理系で違う |

`hello.b` の途中にある `#` は、原典のデバッグ用インタープリタ (`bfi`) の記号で、8 命令には入りません。beef では無視されます。

## 実行例 (2026-11-22、beef 1.2.0-2+b2 / gcc 14.2.0、arm64)

```
$ ./run.sh beef /work/hello.b
Hello World!
$ ./run.sh bash -c 'cd /tmp && cp /work/add.b /work/mini.c . && gcc -o mini mini.c && ./mini add.b'
5
```

括弧が閉じていないプログラムは、beef が実行の前に `beef: bad.b: Unbalanced brackets` と出して終了コード 1 で止めます。
入力が尽きたときに入れる値は処理系しだいです (README に記述なし)。beef の既定は 0 で、`-s zero|eof|same` で選べます。
