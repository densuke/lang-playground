# Malbolge を試す (2026-09-11)

「古今東西 プログラミング言語紹介」2026-09-11 回の実験環境です。金曜は Esolang の枠です。
動画: <https://www.youtube.com/watch?v=hapwxUExcOk>

## 使い方

```bash
./run.sh malbolge hello.mb     # 直接動かす
./run.sh                       # シェルに入る
./run.sh bash -s < demo.sh     # 動画で流した順に実行する
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。

## 処理系について

Debian には Malbolge のパッケージが無いので、**C で書いた最小インタプリタ** (`malbolge.c`、
66 行) を同梱し、イメージのビルド時にコンパイルしています。動画のファクトチェックで
台本のコードを実際に走らせるために、仕様 (<https://esolangs.org/wiki/Malbolge>) から
書いたものです。このリポジトリのためにそのまま持ってきました。

Malbolge は 1998 年に Ben Olmstead が作った言語で、名前はダンテ『神曲』地獄篇の第八圏
Malebolge (詐欺を働いた者が落ちる階層) から取られています。「できるだけプログラムを
書きにくくすること」が設計目標です (<https://esolangs.org/wiki/Malbolge>)。

仕組みは次の 3 つです。

- 1 ワードは三進 10 桁 (0 から 59048)。メモリも 59049 ワード
- 命令は `(番地 + 文字コード) % 94` で決まる。**同じ文字でも置かれた番地で別の命令になる**
- 実行した命令は、その場で置換表に従って別の文字へ書き換えられる

人間が書くことはまずない言語です。最初に動いたプログラムも、人ではなく探索アルゴリズムが
見つけたものでした。このデモも、知られている Hello World をインタプリタに通すだけです。

## 入っているもの

| ファイル | 内容 |
|---|---|
| `malbolge.c` | インタプリタ本体 (ビルド時に `/usr/local/bin/malbolge` になる) |
| `demo/hello.mb` | 動画で見せた 88 文字の Hello World |
| `demo/shifted.mb` | `hello.mb` の先頭 1 文字を消しただけのもの |

## 実行結果

```
$ cat hello.mb
(=<`#9]~6ZY327Uv4-QsqpMn&+Ij"'E%e{Ab~w=_:]Kw%o44Uqp0/Q?xNvL:`H%c#DD2^WV>gY;dts76qKJImZkj

$ malbolge hello.mb
Hello, world.

$ cat shifted.mb
=<`#9]~6ZY327Uv4-QsqpMn&+Ij"'E%e{Ab~w=_:]Kw%o44Uqp0/Q?xNvL:`H%c#DD2^WV>gY;dts76qKJImZkj

$ malbolge shifted.mb
invalid instruction at 0 (op=61)
```

`shifted.mb` は先頭の `(` を消しただけですが、残りの 87 文字がすべて 1 番地ずつ前にずれます。
命令は番地と文字コードの両方で決まるので、全部が別の命令になります。0 番地の `=`
(文字コード 61) は `(0 + 61) % 94 = 61` で、有効な命令 (4, 5, 23, 39, 40, 62, 68, 81) の
どれでもないため、読み込みの時点で止まります。

## つまずきやすい点

**出力は `Hello, world.` です。** 末尾はピリオドで、`world` の w は小文字です。
Wikipedia の Malbolge 記事はこのプログラムを "Hello, World!" を表示するものとして
紹介していますが、実際に走らせるとこの出力になります。

**命令の解読で ASCII の下駄 (`- 33`) を引いてはいけません。** 引く実装にすると
88 文字すべてが無効命令と判定され、何も出力されません。インタプリタを自分で書くときに
踏みやすい落とし穴です。

**Hello World は末尾に改行を出しません。** `demo.sh` では実行のあとに 1 行空けています。

**空白と改行は読み飛ばされます。** `hello.mb` の末尾に改行を付けても、途中に空白を
入れても動作は変わりません。それ以外の文字を 1 つでも足したり消したりすると、
`shifted.mb` のように壊れます。

## ライセンス

`malbolge.c` と `demo/shifted.mb` は、このリポジトリの作者が動画の制作過程で書いたものです。
自由に使ってください。

`demo/hello.mb` は**このリポジトリで書いたものではありません。**
Wikipedia の Malbolge 記事 (<https://en.wikipedia.org/wiki/Malbolge>) に掲載されている
プログラムをそのまま使っています。記事では Kamila Szewczyk 氏の gist
(<https://gist.github.com/iczelia/a1fe6913aaff8edea515b4af385368fe>) が出典として
挙げられています。再利用の条件は出典元を参照してください。
