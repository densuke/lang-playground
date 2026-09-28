# C を試す (2026-09-14)

「古今東西 プログラミング言語紹介」2026-09-14 回の実験環境です。
動画: <https://www.youtube.com/watch?v=kLybcEphwMk>

## 使い方

```bash
./run.sh                                                  # シェルに入る
./run.sh bash -c 'cc -o /build/hello hello.c && /build/hello'
./run.sh bash -s < demo.sh                                # 収録と同じ順に全部動かす
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。

C のコンパイラは macOS なら Xcode Command Line Tools で、Linux なら apt / dnf で入るので、
手元で試すだけならこの環境は要りません。ここでは動画で話した「配列とポインタ」と
「`=` と `==`」を、同じ結果で見返せるように置いています。

## 処理系について

Debian trixie の `gcc` パッケージ (`cc --version` の表示は `cc (Debian 14.2.0-19) 14.2.0`) を
使っています。`cc` は gcc を指しています。`make` などは使わないので、build-essential ではなく
`gcc` と `libc6-dev` だけを入れています。

C は 1970年代の初めに、ベル研究所の Dennis Ritchie が Unix を書くために作った言語です。
1971年に B へ文字型を足し始め、1973年初頭には現代的な C の骨格ができあがり、
同じ年の夏に PDP-11 の Unix カーネルを C で書き直しています。それまでの Unix は
アセンブラで書かれていました。

名前は「B の次だから C」と言われますが、Ritchie 本人は、アルファベットの次なのか
BCPL の綴りの次なのかを決めずにおいた、と書いています。
出典は Ritchie 本人の論文 "The Development of the C Language" です
(<https://www.nokia.com/bell-labs/about/dennis-m-ritchie/chist.pdf>)。

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/hello.c` | Hello World とフィボナッチ数列 |
| `demo/pointer.c` | 動画の `char *p = s;` と `*(p + 1)`。配列の名前が先頭要素へのポインタになる |
| `demo/assign.c` | `==` のつもりで `=` と書いたときに起きること |

## 実行結果

```
$ cc -o /build/hello hello.c

$ /build/hello
Hello, world!
0 1 1 2 3 5 8 13 21 34 

$ cc -o /build/pointer pointer.c

$ /build/pointer
p == &s[0] : 1
s[1]       : e
*(p + 1)   : e
1[s]       : e
HELLO
sizeof s   : 6
sizeof p   : 8

$ cc -Wall -o /build/assign assign.c
assign.c: In function 'main':
assign.c:10:9: warning: suggest parentheses around assignment used as truth value [-Wparentheses]
   10 |     if (x = 0) printf("x = 0 is true\n");
      |         ^

$ /build/assign
x == 0 is false
x = 0 is false
x is now 0
```

`pointer.c` が動画の二行の場面です。`char *p = s;` で配列 `s` の名前がそのまま
先頭要素 `&s[0]` へのポインタになり、`*(p + 1)` は `s[1]` と同じ `e` を返します。
C では `a[i]` が `*(a + i)` と定義されているので、足し算の順番を入れ替えた `1[s]` まで
通ってしまいます。動画で「添字の書き方が、ただの飾りに見えてきた」と言ったのは
このことです。

`assign.c` は、動画の最後に出た「`=` が代入、`==` が比較」の裏側です。`if (x = 0)` は
比較ではなく代入なので、`x` が 0 に書き換わり、条件は 0 (偽) になります。
文法としては正しいのでコンパイルは通ります。`-Wall` を付けると gcc が警告を出します。

## つまずきやすい点

**配列はポインタに「なる」だけで、ポインタそのものではありません。** `sizeof s` は
配列全体の大きさ (`"hello"` の 5 文字と終端の `'\0'` で 6) ですが、`sizeof p` は
ポインタ変数の大きさです。`8` はこの環境 (64 ビットの aarch64) での値で、
32 ビット環境なら `4` になります。

**`-Wall` を付けないと、`if (x = 0)` には何も言われません。** `demo.sh` でも `hello.c` と
`pointer.c` は警告なしでビルドしています。手元で試すときは `-Wall` を付けておくのが
安全です。

**`demo/` はホストと共有しているので、実行ファイルは `/build` に出しています。**
動画のように `cc hello.c && ./a.out` とすると、`demo/` の中に `a.out` ができます。
`/build` はコンテナを抜けると消えます。

**`hello.c` の 2 行目の末尾には空白が 1 つ残っています。** 数字のあとに毎回空白を
出しているためで、表示の上では見えません。

## ライセンス

`demo/` のコードは自由に使ってください。GCC のライセンスは <https://gcc.gnu.org/> を
参照してください。
