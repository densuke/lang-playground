# ArnoldC を試す (2026-10-09)

「古今東西 プログラミング言語紹介」2026-10-09 回 (esolang 枠) の実験環境です。

ArnoldC は Lauri Hartikka が 2014 年に公開した esolang です (開発開始は 2013 年 10 月)。キーワードが
すべて Arnold Schwarzenegger の映画のセリフに置き換わっています。ジョーク言語
ですが実装は本気で、Scala で書かれたコンパイラが ASM を使って JVM バイトコードを
直接生成します。

## 使い方

```bash
./run.sh                                   # シェルに入る
./run.sh bash -c 'cd /work && arnoldc hello.arnoldc && java hello'
./run.sh bash /work/demo.sh                # hello world からバイトコード生成まで
./run.sh bash /work/demo-bytecode.sh       # 生成された .class を覗く
./run.sh bash /work/demo-int16.sh          # リテラルの 16bit 切り詰め
```

`arnoldc` は `java -jar /opt/ArnoldC.jar` のラッパーです。`.arnoldc` を食わせると
カレントディレクトリに `.class` が出ます。実行は普通の `java` コマンドです。

## 文法

| 記法 | 意味 |
|---|---|
| `IT'S SHOWTIME` / `YOU HAVE BEEN TERMINATED` | main の開始 / 終了 |
| `HEY CHRISTMAS TREE` + `YOU SET US UP` | 変数宣言 + 初期値 |
| `GET TO THE CHOPPER` … `ENOUGH TALK` | 代入ブロック |
| `HERE IS MY INVITATION` | 代入ブロックの第1項 |
| `GET UP` / `GET DOWN` | 加算 / 減算 |
| `YOU'RE FIRED` / `HE HAD TO SPLIT` / `I LET HIM GO` | 乗算 / 除算 / 剰余 |
| `LET OFF SOME STEAM BENNET` | 大なり |
| `YOU ARE NOT YOU YOU ARE ME` | 等値 |
| `KNOCK KNOCK` / `CONSIDER THAT A DIVORCE` | 論理積 / 論理和 |
| `BECAUSE I'M GOING TO SAY PLEASE` … `BULLSHIT` … `YOU HAVE NO RESPECT FOR LOGIC` | if / else / endif |
| `STICK AROUND` … `CHILL` | while |
| `TALK TO THE HAND` | 出力 |
| `@NO PROBLEMO` / `@I LIED` | 真 / 偽 |

代入は「第1項を置いてから演算を積む」形です。`a = (4 + b) * 2` はこうなります。

```
GET TO THE CHOPPER a
HERE IS MY INVITATION 4
GET UP b
YOU'RE FIRED 2
ENOUGH TALK
```

## 実測でわかったこと

### 生成された .class が「Java から生まれた」と名乗る

`javap -c hello` の先頭行がこうなります。

```
Compiled from "Hello.java"
```

Java のコンパイラを一度も通していないのに、ソースファイル属性に `Hello.java` が
刻まれています。ASM でバイトコードを組み立てる際、この属性が固定値で埋められて
いるためです。

### 「16bit 整数」なのはリテラルであって変数ではない

作者の wiki は「変数型は 16bit 符号付き整数のみ」と書いていますが、実測すると
そうではありませんでした。

リテラルは書いた時点で 16bit に切り詰められます。警告もエラーも出ません。

| 書いたリテラル | 実際に出る値 |
|---|---|
| 32767 | 32767 |
| 32768 | -32768 |
| 65535 | -1 |
| 65536 | 0 |
| 100000 | -31072 |

理由はバイトコードを見るとわかります。リテラルは `sipush` で埋め込まれています。
`sipush` は 16bit の即値を push する命令です。

```
0: sipush -1        ← 2147483647 と書いた行
3: istore_0
```

一方で変数は `istore` / `iload` が示すとおり 32bit の int スロットです。そのため
`32767 + 1` は素直に `32768` になります (`demo/addition.arnoldc`)。

つまり 16bit という制約はリテラルの表現範囲にだけ効いていて、計算の幅は 32bit
です。切り詰めが黙って起きるので、大きい定数を書くと理由もわからず値が化けます。
