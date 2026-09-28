# D を試す (2026-09-17)

「古今東西 プログラミング言語紹介」2026-09-17 回の実験環境です。
動画: <https://www.youtube.com/watch?v=YduZSgXDExM>

## 使い方

```bash
./run.sh                                  # シェルに入る
./run.sh ldmd2 -run hello.d               # 直接動かす
./run.sh bash -s < demo.sh                # 収録と同じ順に全部動かす
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。
処理系は apt で入るので、初回でも数分で終わります。

## 処理系について

Debian trixie の `ldc` パッケージ (LDC 1.40.0。DMD v2.110.0 のフロントエンドと LLVM 19 を
使った D コンパイラ) を使っています。

動画では `brew install dmd` と `dmd -run hello.d` を案内しましたが、この環境には `dmd` が
ありません。DMD は arm64 向けのビルドが無く、Debian にもパッケージがないためです。
代わりに、LDC に付いてくる `ldmd2` を使っています。`ldmd2` は `dmd` と同じオプションを
受け付けるので、`ldmd2 -run hello.d` が動画の `dmd -run hello.d` にあたります。
D の処理系にはほかに GCC ベースの GDC もあります。

D は Walter Bright 氏が作った言語です。もともとの名前は Mars でしたが、周りが D と
呼び続けたため本人もそう呼ぶようになった、と公式 FAQ に本人の言葉で書かれています
(<https://dlang.org/faq.html>)。

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/hello.d` | Hello World |
| `demo/ctfe.d` | 同じ関数 `fib` をコンパイル時 (`enum`) と実行時の両方で呼ぶ |
| `demo/ctfe_bad.d` | 実行時にしか決まらない値でコンパイル時計算をしようとする。**コンパイルが通らないのが正解** |
| `demo/arrays.d` | 配列の長さ (`.length`) と、範囲外の添字で止まる境界チェック |
| `demo/contract.d` | 事前条件 (`in`) と事後条件 (`out`) による契約 |

## 実行結果

```
$ ldmd2 -run hello.d
Hello, world!

$ ldmd2 -run ctfe.d
compile time: fib(30) = 832040LU
832040
55

$ ldmd2 -run ctfe_bad.d
ctfe_bad.d(12): Error: static variable `n` cannot be read at compile time
ctfe_bad.d(12):        called from here: `fib(n)`

$ ldmd2 -run arrays.d
length: 3
RangeError: index [3] is out of bounds for array of length 3

$ ldmd2 -run contract.d
10 / 3 = 3
AssertError: b must not be 0
```

`ctfe.d` の 1 行目 `compile time: fib(30) = 832040LU` が、動画で見せた「ふつうの関数を
コンパイル時に実行している」場面の証拠です。これは `pragma(msg, ...)` がコンパイル中に
出したメッセージで、プログラムを実行する前に `fib(30)` の値がもう求まっています。
`LU` は `ulong` のリテラルであることを示す接尾辞です。

`ctfe_bad.d` は、書き換えられるモジュール変数 `n` を `enum` の計算に使おうとして止まります。
コンパイル時に計算できるのは、コンパイル時に値が決まるものだけです。

## つまずきやすい点

**`ldc` だけ入れてもリンクで止まります。** `ldc2` はリンクを `cc` に任せるので、`gcc` が
無いと ``cannot find program `cc` `` で失敗します。また `-lrt` などを解決するために
`libc6-dev` も要ります。この `Dockerfile` では両方を入れています。

**`-release` を付けると、契約と境界チェックが外れます。** `ldmd2 -release -run contract.d`
では `divide(10, 0)` が事前条件で止まらず、そのまま割り算が実行されます。
`ldmd2 -release -run arrays.d` では範囲外の添字でも `RangeError` にならず、配列の外の値を
読んでしまいます。境界チェックを残したまま最適化したいときは `-boundscheck=on` を
併用します。

**コンパイラのメッセージは標準エラーに出ます。** `pragma(msg, ...)` の出力やエラーは
標準エラー、プログラムの `writeln` は標準出力です。上の実行結果は両方を混ぜたものです。

**`-run` は生成物を残しません。** 実行ファイルは一時ディレクトリに作られて消えるので、
ホストと共有している `demo/` は汚れません。実行ファイルを残したいときは
`ldmd2 -od=/build -of=/build/hello hello.d` のようにコンテナ内の `/build` に出してください。

## ライセンス

`demo/` のコードは自由に使ってください。LDC のライセンスは
<https://github.com/ldc-developers/ldc> を参照してください。
