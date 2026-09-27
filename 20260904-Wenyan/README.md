# 文言 を試す (2026-09-04)

「古今東西 プログラミング言語紹介」2026-09-04 回の実験環境です。
動画: <https://www.youtube.com/watch?v=obpQ5UhcHBk>

## 使い方

```bash
./run.sh                          # シェルに入る。wenyan コマンドが使える
./run.sh wenyan hello.wy          # 直接動かす
./run.sh bash -s < demo.sh        # 収録と同じ順に全部動かす
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。
処理系は npm で入るので、初回でも数分で終わります。

## 処理系について

動画で紹介した npm パッケージ **`@wenyan/cli` 0.3.4** (文言の公式コンパイラ) を使っています。
公式リポジトリ (<https://github.com/wenyan-lang/wenyan>) の README が
`npm install -g @wenyan/cli` を導入方法として案内しています。

Debian には文言のパッケージが無いので、`Dockerfile` では Debian の `nodejs` (v20.19.2) と
`npm` を入れたうえで、npm レジストリから取ってきた tarball の SHA-256 を確かめてから
インストールしています。

`wenyan ファイル名` は、文言のソースを JavaScript に変換してそのまま実行します。
`-c` を付けると、実行せずに変換結果を表示します。

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/hello.wy` | 動画で紹介した「問天地好在。」を 3 回書くプログラム (公式 README の例) |
| `demo/oneline.wy` | 同じプログラムを句読点も改行も無しで 1 行に書いたもの (公式 README の例) |
| `demo/fibonacci.wy` | 再帰でフィボナッチ数を求める術 (関数)。公式リポジトリの `examples/fibonacci.wy` |

## 実行結果

```
$ cat hello.wy
吾有一數。曰三。名之曰「甲」。
為是「甲」遍。
	吾有一言。曰「「問天地好在。」」。書之。
云云。

$ wenyan hello.wy
問天地好在。
問天地好在。
問天地好在。

$ wenyan -c hello.wy
var 甲=3;for(let _rand1=0;_rand1<甲;_rand1++){var _ans1="問天地好在。";console.log(_ans1);};

$ wenyan oneline.wy
問天地好在
問天地好在
問天地好在

$ wenyan fibonacci.wy
一百四十四

$ wenyan --no-outputHanzi fibonacci.wy
144
```

`wenyan -c` の結果を見ると、「吾有一數。曰三。名之曰「甲」。」が `var 甲=3;`、
「為是「甲」遍。」が `for` ループになっていることが分かります。

`oneline.wy` の出力に「。」が付かないのは、1 行版では文字列の中の「。」も省いているためです。

## つまずきやすい点

**数値は漢数字で表示されます。** `fibonacci.wy` の答え 144 は「一百四十四」と出ます。
算用数字で見たいときは `--no-outputHanzi` を付けます。

**Python や Ruby への変換は、変換結果を見るところまでです。** `wenyan -c -l py hello.wy`
(Ruby は `-l rb`) で変換結果は表示できますが、この環境には Python も Ruby も入れていない
ので、そのコードを実行することはできません。何も付けずに `wenyan` で動かしたときは
JavaScript に変換して Node.js で実行しています。

**ロケールを UTF-8 にしておく必要があります。** ソースも出力も漢字なので、`Dockerfile` で
`LANG=C.UTF-8` を設定しています。

**`wenyan -i` は対話環境 (REPL) です。** `./run.sh bash -s < demo.sh` のように標準入力を
パイプでつないでいるときに使うと、`demo.sh` の残りを読んでしまいます。デモでは使っていません。

## ライセンス

`demo/hello.wy`・`demo/oneline.wy`・`demo/fibonacci.wy` は公式リポジトリの README と
examples から取ったもので、文言本体と同じ MIT ライセンスです
(npm パッケージに同梱の `LICENSE` による)。
