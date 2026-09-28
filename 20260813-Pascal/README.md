# Pascal を試す (2026-08-13)

「古今東西 プログラミング言語紹介」2026-08-13 回の実験環境です。
動画: <https://www.youtube.com/watch?v=lzEUxYzBAM0>
(縦型のショート版: <https://www.youtube.com/watch?v=q_6vbVwNV90>)

## 使い方

```bash
./run.sh                                                  # シェルに入る
./run.sh bash -c 'fpc -l- -v0 -FE/build iso.pas && /build/iso'
./run.sh bash -s < demo.sh                                # 収録と同じ順に全部動かす
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。
処理系は apt で入るので、初回でも数分で終わります。

## 処理系について

Debian trixie の `fp-compiler` パッケージ (Free Pascal 3.2.2) を使っています。

Pascal は Niklaus Wirth 教授が設計した言語で、1970 年に発表され、ETH Zurich の大規模な
講義で使われました。その後、Borland の Philippe Kahn が 50 ドルのフロッピーディスクで
売った Turbo Pascal が学校を中心に広まった、と ETH Zurich の記事にあります
(<https://inf.ethz.ch/department/history/meilensteine-forschung/50years-pascal.html>)。

## 方言とコンパイラモード

Pascal には、ISO 7185 で規格化された標準 Pascal、Borland の Turbo Pascal、クラスを
持つ Delphi (Object Pascal) といった方言があります。Free Pascal はこれらを
**コンパイラモード** で切り替えます。ソースの先頭に `{$mode ...}` と書くか、コマンドラインで
`-M...` を指定します。

| モード | 対応する方言 (`fpc -h` の説明) | この環境で見える違い |
|---|---|---|
| `iso` | ISO 7185 mode (標準 Pascal) | `mod` が ISO の定義どおり負にならない。`writeln` の数値に既定の桁幅が付く |
| `tp` | TP/BP 7.0 compatibility mode | `string` は最大 255 文字の shortstring。関数の多重定義はできない |
| `fpc` | Free Pascal dialect (default) | 何も指定しないときのモード |
| `objfpc` | FPC mode with Object Pascal support | クラス・例外が使える。手続き変数への代入に `@` が要る |
| `delphi` | Delphi 7 compatibility mode | クラス・例外が使える。`@` なしで手続き変数に代入できる。`string` は既定で ansistring |

モードごとの細かい違いは Free Pascal の Programmer's Guide にまとまっています。

- `$MODE` ディレクティブ: <https://www.freepascal.org/docs-html/prog/progsu104.html>
- 付録 D (各モードの一覧): <https://www.freepascal.org/docs-html/prog/progap4.html>
  - TP mode: <https://www.freepascal.org/docs-html/prog/progse73.html>
  - Delphi mode: <https://www.freepascal.org/docs-html/prog/progse74.html>
  - OBJFPC mode: <https://www.freepascal.org/docs-html/prog/progse76.html>
  - ISO mode: <https://www.freepascal.org/docs-html/prog/progse78.html>

たとえば OBJFPC mode の説明には "You must use the address operator to assign procedural
variables." とあり、Delphi mode には "You cannot use the address operator to assign
procedural variables." とあります。`procvar.pas` はこの違いを実際に踏むデモです。

## 入っているもの

| ファイル | モード | 内容 |
|---|---|---|
| `demo/iso.pas` | `{$mode iso}` | 標準 Pascal。`program iso(output);` のように使うファイルを引数に書く |
| `demo/tp.pas` | `{$mode tp}` | Turbo Pascal 流。`uses greet;` で unit を取り込み、`string` を使う |
| `demo/greet.pas` | `{$mode tp}` | `tp.pas` が使う unit |
| `demo/objfpc.pas` | `{$mode objfpc}` | Object Pascal。クラス、プロパティ、例外 |
| `demo/modtest.pas` | 指定なし | 同じソースを `-Miso` と `-Mtp` でビルドし、`-7 mod 3` の結果を比べる |
| `demo/procvar.pas` | 指定なし | `f := Twice;`。`-Mdelphi` では通り、**`-Mobjfpc` ではコンパイルが通らないのが正解** |

## 実行結果

```
$ fpc -l- -v0 -FE/build iso.pas

$ /build/iso
sum of squares 1..5 =         55

$ fpc -l- -v0 -FE/build tp.pas

$ /build/tp
Hello, Turbo Pascal!
length = 20, max = 255
copy   = Turbo

$ fpc -l- -v0 -FE/build objfpc.pas

$ /build/objfpc
balance = 70
Exception: insufficient funds (balance 70, withdraw 500)

$ fpc -Miso -l- -v0 -FE/build modtest.pas

$ /build/modtest
-7 mod 3 =           2

$ fpc -Mtp -l- -v0 -FE/build modtest.pas

$ /build/modtest
-7 mod 3 = -1

$ fpc -Mdelphi -l- -v0 -FE/build procvar.pas

$ /build/procvar
42

$ fpc -Mobjfpc -l- -v0 -FE/build procvar.pas
procvar.pas(14,8) Error: Wrong number of parameters specified for call to "Twice"
procvar.pas(6,10) Error: Found declaration: Twice(LongInt):LongInt;
procvar.pas(17) Fatal: There were 2 errors compiling module, stopping
Fatal: Compilation aborted
Error: /usr/bin/ppca64 returned an error exitcode
```

`modtest.pas` は一字一句同じソースです。ISO モードでは `-7 mod 3` が `2`、TP モードでは
`-1` になります。ISO Pascal の `mod` は結果が負になりません (Programmer's Guide の ISO mode
に "Mod operation as required by ISO pascal." とあります)。数値の前の空白も ISO モード
だけに付いています。桁幅を指定しないときの既定の幅がモードで違うためです。

`procvar.pas` の `f := Twice;` は、Delphi モードでは「関数 `Twice` を変数 `f` に入れる」と
読まれます。objfpc モードでは「引数なしで `Twice` を呼び出す」と読まれるので、引数が
足りないというエラーになります。objfpc モードでは `f := @Twice;` と書きます。

`tp.pas` の `max = 255` は、TP モードの `string` が最大 255 文字の shortstring である
ことを示しています。

## つまずきやすい点

**`demo/` はホストと共有しているので、生成物は `/build` に出しています。** `fpc` は
何も指定しないと `.o` / `.ppu` / 実行ファイルをソースと同じディレクトリに作ります。
`-FE/build` で、実行ファイルと unit の生成物をコンテナ内の `/build` に置いています。
`/build` はコンテナを抜けると消えます。

**ソース中の `{$mode ...}` はコマンドラインの `-M` より優先されます。** `iso.pas` などは
ソースにモードを書いてあるので、`-M` を付けても変わりません。`modtest.pas` と
`procvar.pas` はモードを書かずに、コマンドラインで切り替えています。

**`-l- -v0` を付けないと、ビルドのたびにバナーが出ます。** Debian の `/etc/fpc.cfg` は
`-l` (ロゴ表示) と `-viwn` (情報・警告・注意の表示) を有効にしています。デモでは
`-l-` でロゴを、`-v0` でエラー以外のメッセージを消しています。

**エラーの最終行に出るコンパイラ本体の名前は CPU によって変わります。** 上の
`/usr/bin/ppca64` は arm64 (AArch64) の場合です。x86_64 のマシンでは別の名前になります。

## ライセンス

`demo/` のコードは自由に使ってください。Free Pascal のライセンスは
<https://www.freepascal.org/faq.var> を参照してください。
