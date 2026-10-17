# Whenever を試す (2026-10-30)

Whenever は David Morgan-Mar が作った、文が書いた順に実行されない言語です。
各行に行番号が付き、その集合が「やることリスト (to-do list)」になります。処理系は毎回リストから
等確率で 1 つ選んで実行します。リストが空になれば終わりです。変数も制御構造もありません。

処理系は itruffat/WheneverEverywhere (Python 製、作者の仕様ページが「Resources」に載せている実装) を
コミット `737d928b` に固定して使います。Debian trixie の python 3.13.5 で動かします。独自の処理系は書いていません。

## 使い方

```bash
./run.sh                       # シェルに入る
./run.sh sh /work/demo.sh      # 収録用デモ (Hello World, defer, 順序の揺れ, 99 Bottles, Fibonacci)
./run.sh /work/wh 7 /work/unordered.we   # シード 7 で 1 本だけ流す (シード無しなら毎回違う)
```

## demo/ の中身

| ファイル | 内容 |
|---|---|
| `wh` | 乱数の種を決めて処理系を起動する 1 行ラッパー (`wh [シード] file.we`)。処理系の標準エラー出力 (ply の警告) は捨てる |
| `hello.we` | 仕様ページの Hello World |
| `hello2.we` | 2 行版。`defer(1)` で 2 行目が 1 行目を待つ |
| `unordered.we` | defer 無しの 4 行。シードで順序が変わる |
| `bottles.we` | 仕様ページの 99 Bottles を 3 本に縮小 |
| `fib.we` | 仕様ページの Fibonacci を上限 100 から 10 に縮小 |
| `demo.sh` | 上を順に流す |

## 注意

WheneverEverywhere は「リストにある**行番号**」から等確率で選びます。仕様は「リストの**項目**から等確率」
(同じ行が複数回載っていれば、その回数ぶん当たりやすい) です。作者の Java 版は項目ごとに選びます。
