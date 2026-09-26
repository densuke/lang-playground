# BASIC を試す (2026-10-07)

「古今東西 プログラミング言語紹介」2026-10-07 回の実験環境です。
行番号を振って書く、昔ながらの BASIC を動かします。

## 使い方

```bash
./run.sh                                # 対話環境 (bwbasic) に入る。SYSTEM で抜ける
./run.sh bwbasic /work/hello.bas        # 直接動かす
./run.sh bash -c "$(cat demo.sh)"       # 動画で流した順に実行する
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。
処理系は Debian の apt で入るので、初回でも 1 分ほどで終わります。

## 処理系について

**Bywater BASIC (bwBASIC) 2.20 patch level 2** です (Debian trixie の `bwbasic` パッケージ、
2.20pl2-14)。C 製のインタプリタで、起動時に Ted A. Campbell の 1993 年の著作権表示が出ます。ANSI の
Minimal BASIC 規格の上位互換をうたっています。

本家の最新版は **3.40 (2025-10-23)** で、apt の 2.20 とは大きく離れています。
3 系には `OPTION VERSION "DARTMOUTH"` のように昔の方言へ切り替える機能がありますが、
2.20 にはありません。

## 数ある BASIC から bwBASIC を選んだ理由

**行番号を振る古典的な書き方がそのまま動くから**です。行番号を打てばプログラムに入り、
同じ番号を打ち直すとその行が差し替わる。`LIST` で並べ直して表示し、`RUN` で実行する。
1964 年の Dartmouth BASIC で決まった流儀を、エディタ無しで体験できます。

## macOS で試すには

**この実験環境のコンテナで動かしてください** (上の `./run.sh`)。Homebrew に bwbasic は
ありません (formulae.brew.sh で 404)。本家 3.40 のソースを INSTALL の手順
(`gcc -o bwbasic -ansi -pedantic -Wall bw*.c -lm`) で macOS の cc にかけると、
`putenv` の型が衝突してビルドに失敗しました (2026-09-26 確認)。

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/hello.bas` | Hello World。3 行だけ |
| `demo/fib.bas` | FOR-NEXT でフィボナッチ数列を 10 項 |
| `demo/goto.bas` | GOTO でループし、GOSUB/RETURN でサブルーチンを呼ぶ |

## 実行結果

```
$ ./run.sh bwbasic /work/hello.bas
Bywater BASIC Interpreter/Shell, version 2.20 patch level 2
Copyright (c) 1993, Ted A. Campbell
Copyright (c) 1995-1997, Jon B. Volkoff

HELLO, WORLD!

$ ./run.sh bwbasic /work/fib.bas
 0 1 1 2 3 5 8 13 21 34

$ ./run.sh bwbasic /work/goto.bas
LINE 1 SQUARE 1
LINE 2 SQUARE 4
LINE 3 SQUARE 9
DONE
```

(2 本目以降は起動バナーを省略しています)

### 対話環境で行を打ち直す

```
$ ./run.sh
bwBASIC: 10 PRINT "HI"
bwBASIC: 20 GOTO 10
bwBASIC: LIST
     10: PRINT "HI"
     20: GOTO 10
bwBASIC: 20 END
bwBASIC: LIST
     10: PRINT "HI"
     20: END
bwBASIC: RUN
HI
bwBASIC: SYSTEM
```

20 行目を `20 END` と打ち直しただけで、無限ループだったプログラムが止まるものに変わります。
エディタを開かずに、行番号がそのまま編集の単位になっています。

## つまずきやすい点

**END のあとも終了しません。** `bwbasic ファイル名` で実行すると、最後に `bwBASIC:` の
プロンプトが残ります。抜けるには `SYSTEM` と打ちます (スクリプトから呼ぶときは
入力を `/dev/null` にすると終わります)。

**数値のうしろに空白が付きません。** `PRINT "LINE"; N; "SQUARE"` は `LINE 1SQUARE 1` と
くっつきます。数値の前には符号用の空白が 1 つ付きますが、うしろには付きません。
表示が詰まるので、文字列側に空白を入れます (`"LINE"; N; " SQUARE"`)。

**LIST の表示が少し違います。** `10: PRINT "HI"` のように行番号のあとにコロンが付きます。
打ち込むときにコロンは要りません。

## ライセンス

`demo/` のコードは自由に使ってください。bwBASIC 本体は GPLv2 です。
