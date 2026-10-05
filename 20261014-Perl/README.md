# Perl を試す (2026-10-14)

「古今東西 プログラミング言語紹介」2026-10-14 回の実験環境です。

## 使い方

```bash
./run.sh                                  # シェル (bash) に入る。perl はそこで使える
./run.sh perl /work/hello.pl              # 直接動かす
./run.sh bash -s < demo.sh                # 全部を順に実行する
printf 'foo bar\n' | ./run.sh perl -pe 's/foo/FOO/g'   # 1 行スクリプト
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。
処理系は apt で入るので、初回でも数分で終わります。

Perl には決まった対話環境 (REPL) がありません。`./run.sh` はシェルに入るので、
そこで `perl -e '...'` やファイルを渡して動かします。

## 処理系について

Debian trixie の apt が配る **perl 5.40.1** です (本家の最新安定版は 5.44.0)。

```
$ ./run.sh perl -v

This is perl 5, version 40, subversion 1 (v5.40.1) built for aarch64-linux-gnu-thread-multi
(with 70 registered patches, see perl -V for more detail)
```

macOS には `/usr/bin/perl` が最初から入っています (手元の macOS では 5.34.1)。
Homebrew なら `brew install perl` で最新版が入ります。

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/hello.pl` | Hello World。`$` `@` `%` の記号で変数の種類が分かる |
| `demo/report.pl` | アクセスログから正規表現でステータスを抜き出し、件数を報告する |
| `demo.sh` | 上の 2 本と 1 行スクリプト (`perl -pe 's/foo/FOO/g'`) をまとめて実行 |

## 実行結果

```
$ ./run.sh perl /work/hello.pl
Hello, world!
Perl は C sed awk sh のいいとこ取り
Perl 1.0 は 1987 年、Perl 5 は 1994 年

$ ./run.sh perl /work/report.pl
200   3 ***
302   1 *
404   2 **

$ printf 'foo bar\nbaz foo\n' | ./run.sh perl -pe 's/foo/FOO/g'
FOO bar
baz FOO
```

`report.pl` は名前の由来 "Practical Extraction and Report Language" そのままの仕事です。
テキストから必要な部分を**抜き出し** (Extraction)、集計して**報告** (Report) します。

(Apple container は実行のたびに `[6/6] Starting container` という進捗を標準エラーへ出します。
上の出力からは省いています。)

## つまずきやすい点

**`use strict;` と `use warnings;` は付けておく。** 付けないと変数名の打ち間違いが
黙って新しい変数になります。

**配列の要素は `$` で取り出す。** `@langs` の 1 個目は `$langs[0]`、ハッシュ `%born` の値は
`$born{Perl}` です。頭の記号は「取り出すものの種類」を表します。

**`print` は改行を付けない。** 末尾に `\n` を書きます (`say` を使う方法もあります)。

**日本語を文字として扱うなら `use utf8;` が要る。** このデモは文字列をそのまま出すだけなので
付けていません。文字数を数えたり正規表現で日本語を扱うなら付けます。

## ライセンス

`demo/` のコードは自由に使ってください。Perl 本体は Artistic License か GNU GPL で配布されています。
