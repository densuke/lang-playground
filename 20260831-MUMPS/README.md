# MUMPS を試す (2026-08-31)

「古今東西 プログラミング言語紹介」2026-08-31 回の実験環境です。
動画: <https://www.youtube.com/watch?v=ty23IdO4JYE>

## 使い方

```bash
./run.sh                          # シェルに入る。yottadb コマンドが使える
./run.sh yottadb -run hello       # 直接動かす (demo/hello.m のラベル hello から実行)
./run.sh yottadb -direct          # 対話モード (direct mode) に入る。halt で抜ける
./run.sh bash -s < demo.sh        # 収録と同じ順に全部動かす
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。
処理系は公式のバイナリを入れるだけなので、初回でも数分で終わります。

## 処理系について

動画で紹介した **YottaDB** (GT.M の後継のオープンソース実装) の r2.06 を使っています。
YottaDB は Debian のパッケージになっていないので、`Dockerfile` では GitLab のリリース
(<https://gitlab.com/YottaDB/DB/YDB/-/releases>) に置かれている AARCH64 / Debian 13 向けの
バイナリ tarball を取ってきて、リリースノートに載っている SHA-256 と照合してから、
同梱の `ydbinstall` で入れています。Apple container の上でも arm64 のまま動きます。

グローバル変数 (`^` で始まる名前) を入れるデータベースは、イメージの中の `/data` に
作ってあります。

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/hello.m` | 動画の `write "Hello, World!",!` と、1 文字に縮めた `w "Hello, World!",!` |
| `demo/setcar.m` | 動画の `SET ^Car("Door","Color")="BLUE"` など、グローバル変数に 3 つの値を入れる |
| `demo/getcar.m` | 別のプロセスから `^Car` を読み出す。`zwrite` で全体を表示し、`$order` で添字を順にたどる |

## 実行結果

```
$ yottadb -run hello
Hello, World!
Hello, World!

$ yottadb -run setcar
saved

$ yottadb -run getcar
^Car("Door","Color")="BLUE"
^Car("Door","Count")=4
^Car("Engine")="V6"
door color: BLUE
  Color = BLUE
  Count = 4
```

`setcar` と `getcar` は別々のプロセスです。`setcar` が終わったあとに起動した `getcar` から
`^Car` が読めるので、代入した値がデータベースに書き込まれていることが分かります。
添字は文字列で、`Door` の下に `Color` と `Count` がぶら下がる階層になっています。
`zwrite` の表示は、代入した順ではなく添字の順に並びます。

## つまずきやすい点

**`./run.sh` を実行し直すと、グローバル変数は消えます。** データベースはイメージの中に
あり、`./run.sh` は毎回まっさらなコンテナを起動して、終わると捨てます。値が残るのは
同じ `./run.sh` の中で動くプロセスどうし (上の `setcar` と `getcar`) だけです。動画の
「プログラムが終わっても残る」は MUMPS そのものの性質としては正しいのですが、
この環境ではコンテナの寿命までしか残りません。

**ファイル名とラベルの書き方に決まりがあります。** `yottadb -run hello` は `hello.m` の
ラベル `hello` から実行します。ラベルは行頭に書き、命令の行は先頭に空白を 1 つ以上
入れます。空白を忘れると、命令がラベルとして読まれてしまいます。

**エラーで対話モードに入らないようにしています。** YottaDB は `-run` で動かしたルーチンの
途中でエラーが起きると、既定では対話モード (direct mode) に入り、標準入力から命令を待ちます。
`./run.sh bash -s < demo.sh` のように標準入力がパイプになっていると、`demo.sh` の残りを
M の命令として読んでしまいます。`Dockerfile` では `ydb_etrap` を設定して、エラーの内容を
表示したら終了するようにしています。

**コンパイル結果は `demo/` に置きません。** YottaDB はルーチン (`.m`) を初めて呼ぶときに
オブジェクトファイル (`.o`) を作ります。`ydb_routines` を `/tmp/ydbobj(/work)` にして、
ソースは `/work` (`demo/`) から読み、`.o` はコンテナの中の `/tmp/ydbobj` に書くように
しています。

## ライセンス

`demo/` のコードは自由に使ってください。YottaDB は GNU AGPL バージョン 3 で配布されています
(配布物に同梱の `COPYING` による)。
