# Python を試す (2026-09-16)

「古今東西 プログラミング言語紹介」2026-09-16 回の実験環境です。
動画: <https://www.youtube.com/watch?v=HFqgkZt-0KA>

## 使い方

```bash
./run.sh python3 hello.py        # 直接動かす
./run.sh                         # シェルに入る
./run.sh bash -s < demo.sh       # 収録と同じ順に全部動かす
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。

Python はたいていの環境に最初から入っているので、手元で試すだけならこの環境は要りません。
ここでは動画で話した「多重代入」と「字下げがそのまま構造になる」ところを、同じ結果で
見返せるように置いています。

## 処理系について

公式イメージ `python:3-slim` の CPython を使っています。収録時点のバージョンは
`Python 3.14.7` です。`python:3-slim` は Python 3 の最新版を追いかけるタグなので、
ビルドし直すとバージョンが上がり、エラーメッセージの見た目が変わることがあります。

Python は Guido van Rossum が 1989年のクリスマス休暇に作り始め、1991年2月に
USENET で公開した言語です。当時 van Rossum はオランダの研究所 CWI で ABC という
言語の開発グループにいて、字下げで文をまとめる書き方や、高水準のデータ型は
ABC が出どころだと本人が書いています。同時に、ABC は拡張できないことが最大の
問題のひとつだったとも書いています。

名前はヘビではなく、BBC のコメディ番組「空飛ぶモンティ・パイソン」から取っています。
短くて、他と重ならず、少し謎めいた名前が欲しかったそうです。
出典はいずれも公式 FAQ です (<https://docs.python.org/3/faq/general.html>)。

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/hello.py` | Hello World、ジェネレータで作るフィボナッチ数列、内包表記 |
| `demo/swap.py` | 多重代入 `a, b = b, a + b` と、一行ずつ代入した場合の比較 |
| `demo/indent.py` | 字下げでブロックの範囲が決まる例 |
| `demo/bad_indent.py` | 字下げが揃っていない例。**エラーになるのが正解** |
| `demo/braces.py` | 波括弧を使わせてもらえるか試す。**エラーになるのが正解** |

## 実行結果

```
$ python3 --version
Python 3.14.7

$ python3 hello.py
Hello, world!
[0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
[0, 4, 16, 36, 64]

$ python3 swap.py
入れ替え: 2 1
多重代入で5回: 5 8
一行ずつで5回: 16 32

$ python3 indent.py
0 偶数
1 奇数
2 偶数
3 奇数
ループの外

$ python3 bad_indent.py
  File "/work/bad_indent.py", line 3
    print(name)
IndentationError: unexpected indent

$ python3 braces.py
  File "/work/braces.py", line 1
    from __future__ import braces
                           ^^^^^^
SyntaxError: not a chance
```

`swap.py` が動画の一行の場面です。`a, b = b, a + b` は右側の `b` と `a + b` を先に
両方計算してから、左の `a` と `b` へ配ります。一時変数なしで入れ替えと足し算が
同時にでき、5 回まわすとフィボナッチ数列の `5 8` に進みます。同じことを
`a = b` と `b = a + b` の二行に分けると、`b` の計算に書き換え後の `a` が使われて
`16 32` という別の結果になります。

`bad_indent.py` は、3 行目だけ字下げが深いため `IndentationError` で止まります。
字下げが見た目の飾りではなく構造そのものなので、ずれると実行前に弾かれます。

`braces.py` は CPython に仕込まれた冗談です。`from __future__ import braces`
(将来の機能として波括弧を取り込む) と書くと、`not a chance` (ありえない) と返されます。
動画で「波括弧は使わない」と言ったことへの、処理系自身からの返事です。

## つまずきやすい点

**字下げにタブと空白を混ぜないでください。** `bad_indent.py` のように深さがずれると
エラーになりますが、タブと空白の混在は見た目では気づきにくい原因です。

**`python3` を引数なしで動かすと対話モードで入力を待ちます。** `./run.sh bash -s < demo.sh`
のように標準入力をパイプでつないでいるときは、対話モードがパイプの中身を読んでしまうので、
`demo.sh` ではかならずファイル名を渡しています。

**バージョンが変わるとエラーメッセージの形が変わることがあります。** 上の実行結果は
3.14.7 のものです。

## ライセンス

`demo/` のコードは自由に使ってください。Python のライセンスは
<https://docs.python.org/3/license.html> を参照してください。
