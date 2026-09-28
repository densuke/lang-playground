# occam を試す (2026-09-09)

「古今東西 プログラミング言語紹介」2026-09-09 回の実験環境です。
動画: <https://www.youtube.com/watch?v=4DpUs3Xa-cE>

occam は 1983 年にイギリスの INMOS 社が、並列計算機向けのチップ「トランスピュータ」のために
作った言語です。処理を順に動かすなら `SEQ`、同時に動かすなら `PAR` と書き、プロセス同士は
チャネルで値をやりとりします (`!` が送信、`?` が受信)。

動画のコード例は Wikipedia から引いたもので、収録の時点では動かしていませんでした。
ここではそれを実際にコンパイルして動かしています。その結果、動画の `PAR` の例は
**そのままではコンパイルエラーになる** ことが分かりました (下の「実行結果」を参照)。

## 使い方

```bash
./run.sh                          # シェルに入る。exit で抜ける
./run.sh occam hello.occ          # 直接動かす (コンパイル・リンク・実行)
./run.sh bash -s < demo.sh        # 収録と同じ順に全部動かす
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。

**最初のビルドには 40 分ほどかかります。** 処理系をソースからビルドし、しかもそれを
32 ビット x86 のエミュレーションの上で行うためです (次の節を参照)。2 回目からはキャッシュが
効くので、すぐに始まります。

## 処理系について

ケント大学の **KRoC** (Kent Retargetable occam Compiler) を使っています。ソースは
<https://github.com/concurrency/kroc> で、master の最新コミット (2020-03-29) を固定し、
SHA-256 を確かめてからビルドしています。occam-π (ケント大学が拡張した occam) の処理系ですが、
普通の occam のプログラムもそのままコンパイルできます。

KRoC は **32 ビット x86 (i386) 専用** です。Apple container は arm64 の Linux で動き、
Rosetta も 32 ビットの実行ファイルは動かせません。そこで次の 2 段構えにしています。

- ビルド段: `linux/386` の Debian 11 (bullseye) で KRoC をビルドする。ビルダーが
  エミュレーションで動かすので、KRoC から見ると本物の 32 ビット x86 の環境になる
- 実行段: arm64 の Debian 13 (trixie) に `qemu-user` を入れ、i386 のプログラムを
  `qemu-i386` で動かす

実行には、KRoC に含まれる **Transterpreter** (`tvm`) を使っています。occam のプログラムを
バイトコードにして、それを仮想マシンで動かす仕組みです。KRoC 本来の、機械語に変換して
動かす方式 (ランタイムは CCSP) も試しました。コンパイルとリンクはできましたが、できた
プログラムを `qemu-i386` で動かすと、起動した直後に必ず `KRoC: Segmentation fault.` で
落ちました。ビルダー側のエミュレーションで動かしても同じでした。CCSP はスケジューラの
一部をアセンブリで直に書いていて、そこがエミュレーションと合わないのだと思います。
`tvm` は C で書かれた仮想マシンなので、この問題を避けられます。

1 本のプログラムを動かす流れは次のとおりで、これを `occam` というスクリプトにまとめています。

1. コンパイラ `occ21` (i386) を `qemu-i386` で動かし、`.tce` を作る
2. リンカ `plinker.pl` (Perl) を arm64 の `perl` でそのまま動かし、標準ライブラリ
   `forall` と、ソースが使うライブラリ (`course` など) をつないで `.tbc` を作る
3. 仮想マシン `tvm` (i386) を `qemu-i386` で動かす

作業ファイルは一時ディレクトリに作るので、`demo/` には何も残りません。標準入力は
`/dev/null` にしています。

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/hello.occ` | 画面に 1 行出す。`out.string` は KRoC の `course` ライブラリの手続き |
| `demo/seq.occ` | 動画の `SEQ` の例 (`x := x + 1` → `y := x * x`) を、`x = 3` から動かす |
| `demo/par_video.occ` | 動画の `PAR` の例 (`keyboard ? c` と `screen ! c`) をそのまま書いたもの。コンパイルエラーになる |
| `demo/channel.occ` | 上を直したもの。2 つのプロセスを `PAR` で同時に動かし、チャネル `c` で 1 文字ずつ送る |
| `occam` | コンパイル・リンク・実行をまとめたスクリプト (イメージの `/usr/local/bin/occam` に入る) |

KRoC のプログラムは、`(CHAN BYTE keyboard?, screen!, error!)` を引数に持つ `PROC` から
始まります。キーボード・画面・エラー出力が、それぞれチャネルとして渡されます。

## 実行結果

```
$ occam hello.occ
Hello, occam!

$ occam seq.occ
x = 4, y = 16

$ cat par_video.occ
-- The PAR example from the video, as is.
PROC par.video (CHAN BYTE keyboard?, screen!, error!)
  BYTE c:
  PAR
    keyboard ? c
    screen ! c
:

$ occam par_video.occ

    :-- The PAR example from the video, as is.
    :PROC par.video (CHAN BYTE keyboard?, screen!, error!)
    :  BYTE c:
   4:  PAR
    :    keyboard ? c
    :    screen ! c
    ::
Error-occ21-par_video.occ(4)- variable `c' is read and assigned to in parallel
Warning-occ21-par_video.occ(6)- variable `c' is undefined here

$ cat channel.occ
-- The video's PAR, fixed: the two processes share a channel, not a variable.
PROC channel (CHAN BYTE keyboard?, screen!, error!)
  VAL []BYTE word IS "occam*n":
  CHAN BYTE c:
  PAR
    SEQ i = 0 FOR SIZE word     -- sender
      c ! word[i]
    SEQ i = 0 FOR SIZE word     -- receiver
      BYTE ch:
      SEQ
        c ? ch
        screen ! ch
:

$ occam channel.occ
occam
```

**動画の `PAR` の例は、そのままではコンパイルが通りません。** `PAR` の下の 2 行は同時に
動くので、一方が変数 `c` に書き込み (`keyboard ? c`)、もう一方が同じ `c` を読む
(`screen ! c`) ことになります。occam は、並行に動くプロセスが同じ変数を取り合う書き方を
コンパイルの時点で禁止しています。エラーの文面もそのとおりで、`c` が並行に読み書き
されている、と言っています。

実は Wikipedia では、`keyboard ? c` と `screen ! c` は **別々の 2 つの例** として載っていて、
`PAR` の下には並んでいません。動画ではこの 2 つを 1 つの `PAR` にまとめてしまっていました。

`channel.occ` が直した形です。2 つのプロセスは変数を共有せず、チャネル `c` だけでつながって
います。送る側 (`c ! word[i]`) と受け取る側 (`c ? ch`) は、相手の準備ができるまで待ち合わせる
ので、文字は必ず送った順に届きます。画面に書くのは受け取る側だけなので、何度動かしても出力は
同じです。動画の「共有メモリとロックを使わない」「取り合いにならない」は、まさにこの形のことです。

## つまずきやすい点

**`SEQ` や `PAR` は、処理が 1 つだけなら書かなくてかまいません。** 動画では「どちらも省略
できない」と紹介しましたが、正確には「複数の処理を並べるときは、必ずどちらかを書く」です。
`hello.occ` の `PROC` の中身は `out.string (...)` の 1 行だけなので、`SEQ` を付けていません。

**インデントは 2 文字ずつです。** occam は字下げで構造を表し、1 段が空白 2 つと決まっています。
4 つ下げると `incorrect indentation` というエラーになります。

**`PROC` の定義の最後には `:` が要ります。** 変数の宣言 (`INT x, y:`) も、宣言の後ろに `:` を
付けます。

**文字列の中の改行は `*n` です。** occam ではエスケープに `\` ではなく `*` を使います。

**`keyboard` から読むプログラムは、`occam` スクリプトでは入力を受け取れません。** 収録で
止まらないよう、標準入力を `/dev/null` にしているためです。デモでは `keyboard` を使っていません。

**`occam` は警告を出さない設定にしています。** `keyboard` や `error` を使わないと
「使っていない引数がある」という警告が毎回出るためです。エラーは表示されます。ただ、
`par_video.occ` でエラーの後に出る ``variable `c' is undefined here`` のように、消えない警告もあります。

**ビルド段の Debian 11 は、サポートが終わった版です。** KRoC のビルドは Python 2 を前提に
していて、Debian 13 には Python 2 がありません。パッケージは `archive.debian.org` から
取ってきます。Docker Hub の `debian:bullseye-slim` にはセキュリティ更新済みの `libc6` /
`perl-base` が入っていて、archive にある版と合いません。そのため `Dockerfile` では、archive
にある版に入れ直しています。Hub のイメージが更新されてビルドが通らなくなったら、ここを
見直してください。

**x86_64 の Linux なら、エミュレーションは要りません。** KRoC の README には、x86-64 の
Debian では 32 ビットのバイナリを作るための `gcc-multilib` などを入れるように書かれています。

## ライセンス

`demo/` のコードと `occam` は自由に使ってください。

KRoC は GNU GPL (コンパイラ `occ21`、リンカ `plinker.pl` など) と GNU LGPL (Transterpreter の
中核 `libtvm` など) で配布されています。このリポジトリには処理系そのものは含めず、
`Dockerfile` が GitHub から取ってきてビルドします。
