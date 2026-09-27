# Tcl を試す (2026-09-23)

「古今東西 プログラミング言語紹介」2026-09-23 回の実験環境です。
動画: <https://www.youtube.com/watch?v=ZjiINS-Nb3w>

## 使い方

```bash
./run.sh                                  # 対話環境 (tclsh) に入る
./run.sh tclsh /work/Basics.tcl           # 直接動かす
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。
処理系は apt で入るので、初回でも 1 分ほどで終わります。

## 処理系について

Debian の `tcl` パッケージ (Tcl 8.6 系、`tclsh`) を使っています。

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/Basics.tcl` | Hello World・フィボナッチ数列 |
| `demo/Repeat.tcl` | `uplevel` / `upvar` で `for` 相当の制御構造を自作する |
| `demo/Compose.tcl` | コマンド名を文字列として組み立てて実行する |

## Tcl の構文規則について

Tcl のマニュアル [Tcl(n)](https://www.tcl-lang.org/man/tcl8.6/TclCmd/Tcl.htm) には、
構文の核となる規則が次のように書かれています。

- コマンドはセミコロンか改行で区切られる。1 つのコマンドは「まず単語への分割と置換、
  次に最初の単語をコマンド手続きとして解決する」という 2 段階で評価される
  ("A command is evaluated in two steps.")
- `$name` は変数を参照する（`$name(index)` で配列要素も参照できる）
- `[...]` の中身はコマンドとして評価され、その結果に置き換わる（コマンド置換）
- バックスラッシュ (`\n` など) はエスケープシーケンスとして置換される
- ただし **`{}` で囲んだ単語には、変数置換もバックスラッシュ置換も行われない**
  ("Variable substitution is not performed on words enclosed in braces." /
  "Backslash substitution is not performed on words enclosed in braces.")

`if` や `for` が特別な構文ではなく「最初の単語がそのまま呼び出すコマンド名」である、
という規則も同じマニュアルの記述どおりです。`demo/Repeat.tcl` の `repeat` や
`demo/Compose.tcl` のコマンド名の組み立ては、この規則の上に成り立っています。

## 実行結果

```
$ ./run.sh tclsh /work/Basics.tcl
Hello, world!
0 1 1 2 3 5 8 13 21 34

$ ./run.sh tclsh /work/Repeat.tcl
again
again
again
counter = 5

$ ./run.sh tclsh /work/Compose.tcl
コマンド名も文字列として組み立てられる
greet が返した文字列 puts を、そのままコマンドとして実行した
```

## つまずきやすい点

**`{}` の中は置換されません。** `if {$n < 2}` の `{}` は「あとで評価する式」を
文字列のまま渡しているだけで、`if` コマンド自身が中身を評価します。`{}` を `""` に
書き換えると、その場で変数展開されてしまい意味が変わります。

**`uplevel`／`upvar` を使わない自作コマンドは、変数のスコープが呼び出し元と
つながりません。** `repeat` の `body` をただ `eval` すると、`body` の中で作った
変数は `proc` の中に閉じ込められます。呼び出し元のスコープで実行したい場合は
`uplevel 1` を使う必要があります（`demo/Repeat.tcl` 参照）。

## ライセンス

`demo/` のコードは自由に使ってください。Tcl 本体のライセンスは
<https://www.tcl-lang.org/software/tcltk/license.html> を参照してください。
