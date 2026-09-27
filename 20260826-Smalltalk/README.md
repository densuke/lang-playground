# Smalltalk を試す (2026-08-26)

「古今東西 プログラミング言語紹介」2026-08-26 回の実験環境です。
動画: <https://www.youtube.com/watch?v=RGuaVNlZFbw>

## 使い方

```bash
./run.sh                          # 対話環境 (gst) に入る。Ctrl-D で抜ける
./run.sh gst hello.st             # 直接動かす
./run.sh bash -s < demo.sh        # 収録と同じ順に全部動かす
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。
処理系をソースからビルドするので、初回は数分かかります。

## 処理系について

動画の「試すなら」で紹介した **GNU Smalltalk (`gst`) 3.2.5** を使っています。
GNU の公式配布 (<https://ftp.gnu.org/gnu/smalltalk/>) にある最新のリリースで、
2013 年 4 月に出たものです。

動画では `brew install gnu-smalltalk` を紹介しましたが、Debian では 11 (bullseye) を
最後にパッケージが無くなり、このコンテナの土台にしている Debian 13 (trixie) にも
ありません。そこで `Dockerfile` では公式のソースを取ってきて、SHA-256 を確かめたうえで
ビルドしています。GUI (Tk / GTK) と Emacs 連携は外しています。

Pharo や Squeak も Smalltalk の実装ですが、どちらも画面付きのイメージ環境が中心です。
ファイルを渡して結果を文字で見るこの実験には、`gst` のほうが向いています。

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/hello.st` | 動画の `Transcript showCr: 'Hello, World!'` と、`inject:into:` による 1 から 10 の合計 |
| `demo/objects.st` | 数も `true` も `nil` もオブジェクトであること、`ifTrue:ifFalse:` が真偽値へのメッセージであること |
| `demo/account.st` | メッセージを送ってクラスを定義し、そのインスタンスにメッセージを送る |

## 実行結果

```
$ gst hello.st
Hello, World!
sum 1..10 = 55

$ gst objects.st
3 class        -> SmallInteger
(3 > 2) class  -> True
nil class      -> UndefinedObject
3 + 4 * 2      -> 14
100 factorial size -> 158
3 > 2 is true
1 odd
2 even
3 odd
4 even
5 odd

$ gst account.st
balance = 150
responds to deposit:? true
responds to fly?      false
```

`3 + 4 * 2` が 14 になるのは、二項メッセージに優先順位が無く、左から順に送られるためです。
`(3 > 2) class` が `True` なのは、真偽値も `True` / `False` というクラスのオブジェクトだからです。
`ifTrue:ifFalse:` はこのオブジェクトが受け取るメッセージで、構文ではありません。

## つまずきやすい点

**文字列は一重引用符 `'...'` で書きます。** 二重引用符 `"..."` はコメントです。
`"yes" printNl.` と書いても何も起きず、エラーにもなりません。

**`printNl` は文字列を引用符付きで表示します。** `'abc' printNl` は `'abc'` と出ます。
引用符なしで出したいときは `displayNl` か `Transcript showCr:` を使います。

**新しい GCC でビルドすると、大きな整数の計算が壊れます。** ソースのまま最適化を
かけると、整数があふれたかどうかの検査がコンパイラに消され、`100 factorial` が
負の数になります。`Dockerfile` では `-fwrapv` を付けてこれを防いでいます。
この状態で同梱のテスト (`make check`) を流すと、126 件が期待どおり、5 件がスキップでした。

**ファイルを渡さずに `gst` を起動すると、標準入力を読みます。** `gst hello.st` のように
ファイルを渡したときは、読み終えると終了します。

## ライセンス

`demo/` のコードは自由に使ってください。GNU Smalltalk 本体は、仮想マシンが
GNU GPL バージョン 2 以降、クラスライブラリが GNU LGPL バージョン 2.1 以降で
配布されています (ソース中の各ファイルの冒頭による)。
