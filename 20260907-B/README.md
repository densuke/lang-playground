# B を試す (2026-09-07)

「古今東西 プログラミング言語紹介」2026-09-07 回の実験環境です。
動画: <https://www.youtube.com/watch?v=yt9HtA9eo3s>

## 使い方

```bash
./run.sh                                      # シェルに入る。exit で抜ける
./run.sh b -q -hist -o /tmp/fib -run fib.b    # 直接動かす
./run.sh bash -s < demo.sh                    # 収録と同じ順に全部動かす
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。
処理系をソースからビルドするので、初回は apt だけの環境より少し時間がかかります。

## 処理系について

1969 年に Ken Thompson が PDP-7 で作った B の処理系そのものは、手軽に動かせる形では
残っていません。そこで動画で紹介した現代の再実装 **bext-lang/b**
(<https://github.com/bext-lang/b>) を使っています。Rust で書かれていて、aarch64 Linux 向けの
アセンブリを出し、`cc` でアセンブル・リンクして実行ファイルを作ります。Apple container の
arm64 環境でそのまま動きます。

タグ付きのリリースが無いため、`Dockerfile` では 2025 年 10 月 29 日時点の main のコミット
(`078429a`) を固定し、SHA-256 を確かめてからビルドしています。ビルドには Debian trixie の
`rustc` をそのまま使っています。

`-hist` を付けると、Ken Thompson の "Users' Reference to B" の書き方にできるだけ合わせる
モードになります (`b -help` の説明による)。デモはすべてこのモードで動かしています。

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/fib.b` | 動画の `auto a, b, t, i;` と `while (i < 10)` を使ったフィボナッチ数列 |
| `demo/typeless.b` | 型が無いことの確認。同じワードをアドレスとしても整数としても使う。文字定数 `'AB'` も数になる |
| `demo/kernighan.b` | 1972 年の Kernighan のチュートリアルにある Hello, world。この再実装では通らない |

## 実行結果

```
$ b -q -hist -o /tmp/fib -run fib.b
0 1 1 2 3 5 8 13 21 34 

$ b -q -hist -o /tmp/typeless -run typeless.b
p[0] + p[2] = 40
'AB' = 16706

$ cat kernighan.b
main( ) {
  extrn a, b, c;
  putchar(a); putchar(b); putchar(c); putchar('!*n');
}

a 'hell';
b 'o, w';
c 'orld';

$ b -q -hist -o /tmp/kernighan -run kernighan.b
kernighan.b:6:3: LEXER ERROR: Character literal contains more than two characters
```

`'AB' = 16706` は 16 進で `0x4142` で、`A` (0x41) と `B` (0x42) を 1 ワードに詰めた値です。

`kernighan.b` は 6 行目の `a 'hell';` で止まります。1 ワードに 4 文字を詰める文字定数に、
この再実装は対応していません (2 文字まで)。動画で「いまの再実装では通らないものもある」と
紹介したのはこの挙動です。

## つまずきやすい点

**改行の `*n` は `-hist` を付けないと効きません。** 固定したコミットでは、`-hist` なしだと
エスケープ文字が C と同じ `\` になります。`fib.b` を `-hist` なしで動かすと、行末に
`*n` がそのまま表示されます。`kernighan.b` も、`-hist` なしだと 6 行目より手前の
`'!*n'` (3 文字の文字定数として読まれる) でエラーになります。

**作業ファイルの置き場所に注意します。** `b -run fib.b` とだけ書くと、ソースと同じ場所に
実行ファイル `fib` と作業用ディレクトリ `.build/` ができます。`demo/` はホストと共有
しているので、デモでは `-o /tmp/...` で出力先をコンテナ内に逃がしています。

**配列の宣言は `auto v 3;` です。** C のつもりで `auto v[3];` と書くと
`expected ... integer literal` というエラーになります。

## ライセンス

`demo/` のコードは自由に使ってください (`kernighan.b` は 1972 年のチュートリアルからの
引用です)。bext-lang/b 本体は MIT ライセンスで配布されています (リポジトリの `LICENSE` による)。
