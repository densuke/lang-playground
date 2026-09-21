# COBOL を試す (2026-09-22)

「古今東西 プログラミング言語紹介」2026-09-22 回 (実践編パイロット版) の実験環境です。

## 使い方

```bash
./run.sh                                   # シェルに入る
./run.sh bash -c 'cobc -x /work/basics.cob && cd /work && ./basics'
./run.sh bash /work/demo.sh                # 動画の前半で流した順に実行する
./run.sh bash /work/demo-feature.sh        # 動画の後半 (十進演算の実演)
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。

## 処理系について

**GnuCOBOL 3.2.0** です。Debian trixie の `apt` で入ります。

```
$ ./run.sh cobc --version
cobc (GnuCOBOL) 3.2.0
Copyright (C) 2023 Free Software Foundation, Inc.
```

コンパイラ本体は GPLv3、ランタイムライブラリは LGPLv3 です。
公式サイトは https://gnucobol.sourceforge.io/ 。

`cobc -x` で実行ファイルを作ります。`-free` を足すと自由形式になります。

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/basics.cob` | Hello World と、`PIC` 句による桁の定義。**編集項目でカンマが自動で入る** |
| `demo/decimal.cob` | **十進演算と二進浮動小数点の対比。** 同じ `0.1 + 0.2` を並べる |
| `demo/freeform.cob` | 自由形式 (`-free`) と 88 レベル (条件名) |
| `demo/demo.sh` | 動画の前半で流した手順 |
| `demo/demo-feature.sh` | 動画の後半で流した手順 |

## 実行結果

### 桁を型として書く (`basics.cob`)

```
$ ./basics
Hello, World!
RAW   : 0005941.50
GOKEI :   5,941.50
```

`PIC 9(7)V99` が生の値、`PIC ZZZ,ZZZ.99` が表示用です。
**カンマが自動で入り、先頭のゼロが空白になります。** 金額を見せるための機能が
言語の側に入っています。

### 十進演算 (`decimal.cob`)

この回でいちばん見てほしいところです。

```
$ ./decimal
COBOL 10進 : 0.300000000000000000
2進浮動小数: 0.299999999999999933
```

同じプログラムの中で `PIC 9V9(18)` (十進) と `USAGE COMP-2` (二進倍精度) に
同じ `0.1 + 0.2` を計算させています。**十進は正確に 0.3 になります。**

GnuCOBOL の公式ドキュメントは、二進表現について「近似値しか得られない、多くの
十進の分数は二進では正確に表せないから」と書いています。金額を一円も間違えられない
用途で使われてきた理由が、この一行に出ています。

### 自由形式と 88 レベル (`freeform.cob`)

```
$ cobc -x -free freeform.cob && ./freeform
ADULT
CHILD
```

COBOL は 80 桁のパンチカードが出発点で、何桁目に何を書くかが決まっています
(1-6 桁目が通し番号、7 桁目が標識、8-11 桁目が Area A、12-72 桁目が Area B)。
**自由形式は COBOL 2002 の規格から入りました。** GnuCOBOL の既定は固定形式です。

`88` で始まる行は条件名と呼びます。`IF ADULT` のように書けて、記憶域を占有しません。

## もっと知るには

- GnuCOBOL 公式: https://gnucobol.sourceforge.io/
- 最新規格 ISO/IEC 1989:2023 (2023年1月31日発行): https://webstore.iec.ch/en/publication/82522
- COBOL を作った当事者の講演録 (Computer History Museum):
  https://archive.computerhistory.org/resources/access/text/2017/10/102639620-05-01-acc.pdf

最後の講演録には、**Grace Hopper は短期委員会の委員ではなくアドバイザーだった**という
証言や、決定の遅さに苛立った委員が「COBOL」と彫った墓石をペンタゴンへ送りつけた話が
本人の口から語られています。
