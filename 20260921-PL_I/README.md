# PL/I を試す (2026-09-21)

「古今東西 プログラミング言語紹介」2026-09-21 回の実験環境です。
動画: <https://www.youtube.com/watch?v=8yOh_uHEN_o>

## 使い方

```bash
./run.sh                          # シェルに入る。exit で抜ける
./run.sh pli hello.pli            # 直接動かす (コンパイル・リンク・実行)
./run.sh bash -s < demo.sh        # 収録と同じ順に全部動かす
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。

## 処理系について

動画で紹介した **Iron Spring PL/I 1.4.1** (2026 年 4 月 15 日公開の Linux 版) を使っています。
配布元は <http://www.iron-spring.com/download.html> です。

この処理系は **32 ビット x86 (i386) 専用** です。コンパイラ `plic` は実行ファイルの形でだけ
配られています。ランタイム `libprf.a` はソース (PL/I とアセンブラ) も同梱されていますが、
これも i386 向けです。Apple container は arm64 の Linux で動き、
`--platform linux/amd64` (Rosetta) を付けても 32 ビットの実行ファイルは
`Exec format error` になって動きません。そこで次の組み合わせにしています。

- arm64 の Debian に `qemu-user` を入れ、`qemu-i386` で `plic` を動かす
- リンクは i386 向けの `ld` (`binutils-i686-linux-gnu`) で、libc を使わない静的リンクにする
  (配布物の `samples/SA_make` と同じ方法)
- できた実行ファイルも `qemu-i386` で動かす

この 3 段をまとめたのが `pli` というスクリプトです。作業ファイル (`.o` / `.lst` / 実行ファイル) は
一時ディレクトリに作るので、`demo/` には何も残りません。

配布サイトの HTTPS は自己署名証明書なので、`Dockerfile` では HTTP で取ってきて、
SHA-256 が一致するかを確かめています。

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/hello.pli` | 動画の `HELLO: PROCEDURE OPTIONS(MAIN);` と `PUT SKIP LIST('Hello, world!');` |
| `demo/keywords.pli` | 動画の `IF IF = THEN THEN ELSE = IF;`。`IF` / `THEN` / `ELSE` を変数として宣言して動かす |
| `demo/onunit.pli` | `ON ZERODIVIDE` で 0 除算を受け止める。桁数を指定した `FIXED DECIMAL(7,2)` も使う |
| `pli` | コンパイル・リンク・実行をまとめたスクリプト (イメージの `/usr/local/bin/pli` に入る) |

## 実行結果

```
$ pli hello.pli

Hello, world! 

$ cat keywords.pli
/* PL/I has no reserved words: IF, THEN and ELSE can be variable names. */
KEYWORDS: PROCEDURE OPTIONS(MAIN);
   DECLARE (IF, THEN, ELSE) FIXED BINARY(31);
   IF = 1;
   THEN = 1;
   ELSE = 0;
   IF IF = THEN THEN ELSE = IF;
   PUT SKIP EDIT('IF = ', IF, ', THEN = ', THEN, ', ELSE = ', ELSE)
                (A, F(1), A, F(1), A, F(1));
   PUT SKIP;
END KEYWORDS;

$ pli keywords.pli

IF = 1, THEN = 1, ELSE = 1

$ pli onunit.pli

price =  1234.50
ZERODIVIDE: no boxes (ONCODE 320)
back in the main flow
```

`keywords.pli` では、変数 `IF` と `THEN` がどちらも 1 なので条件が成り立ち、変数 `ELSE` に
`IF` の値 1 が入ります。動画で説明したとおり、2 つめの `IF`・1 つめの `THEN`・`ELSE` が
変数として扱われていることが分かります。

`onunit.pli` では、0 除算が起きた時点で `ON ZERODIVIDE` の中へ飛び、`GOTO DONE` で
本来の流れに戻っています。`items per box = ...` の行は表示されません。

## つまずきやすい点

**`PUT SKIP` は「改行してから書く」命令です。** そのため `hello.pli` の出力は空行から始まります。
また `PUT LIST` は項目のあとに空白を入れるので、`Hello, world! ` の行末には空白が 1 つ付きます。
`keywords.pli` と `onunit.pli` では、見た目をそろえるために `PUT EDIT` で書式を指定しています。

**`FIXED DECIMAL` どうしの 0 除算は `ZERODIVIDE` になりませんでした。** 最初は
`FIXED DECIMAL(3)` の変数で割る形にしていましたが、Iron Spring PL/I 1.4.1 では
`ERROR condition raised ... in procedure with entry CONVERT` となり、`ON ZERODIVIDE` には
入りませんでした。デモでは `FIXED BINARY(31)` の整数で割っています。

**コンパイラの終了コードは、警告だけでも 4 になります。** 付属の手引き (`prog_guide.html`) に
よると、警告だけなら 4、エラーがあれば 8 を返します。`pli` では `-ew` を付けて、警告だけなら
0 になるようにしています。

**x86_64 の Linux なら qemu は要りません。** 64 ビットの x86 Linux では 32 ビットの
アプリとしてそのまま動く、と配布物の `readme_linux.html` に書かれています。

## ライセンス

`demo/` のコードと `pli` は自由に使ってください。

Iron Spring PL/I は、配布物の `readme_linux.html` によると、コンパイラとライブラリを自由に
使用・複製してよく、コンパイルしたプログラムはどんな条件でも配布してよい、とされています。
ランタイムライブラリのソースは GNU LGPL です。動画では「個人利用は無償」と紹介しましたが、
1.4.1 の文面には個人利用に限る条件は書かれていません。このリポジトリには処理系そのものは
含めず、`Dockerfile` が配布元から取ってきます。
