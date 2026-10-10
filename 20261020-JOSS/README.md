# JOSS を試す (2026-10-20)

「古今東西 プログラミング言語紹介」2026-10-20 回の実験環境です。

**ここで動くのは RAND の JOSS そのものではありません。** 1963 年の JOSS 本体は JOHNNIAC の機械語で、
動かせる処理系が見つかりませんでした。代わりに、JOSS 系の方言を TypeScript で作りかけている
再実装 `wryun/joss-language` (作者 James Haggerty、MIT、作りかけ) を、コミット `acad0c05` に固定して
取り込んでいます。参考にしているのは IBM System/360 版の方言 MATH(JOSS) の書籍で、RAND の JOSS ではありません。

## 使い方

```bash
./run.sh                          # シェルに入る。中で joss と打つと、標準入力を 1 行ずつ JOSS として評価する
./run.sh sh /work/demo.sh         # 4 本を順に実行する
printf 'Type 2+2.\n' | ./run.sh joss
```

`container` / `docker` / `podman` のいずれかがあれば動きます。

## 注意 (本物の JOSS との違い)

- **`joss` コマンドは私の用意した入口です。** 再実装はライブラリとテストだけで対話ループを持たないので、
  標準入力を 1 行ずつ eval して、行の前に `* ` を付けて見せるだけの `repl.ts` (十数行) を足しました。
  `error:` で始まる行も `repl.ts` が例外メッセージを出したもので、JOSS の `Eh?` ではありません
- **演算子が本物と逆です。** RAND の JOSS では `*` がべき乗、乗算は中黒 `·` です (P-2922 図 3a、3d)。再実装は `*` が乗算、`^` がべき乗なので、デモの `x*x` は JOSS の記法ではありません (本物の `3*3` は 27)
- 本物は `Type 2+2.` に `2+2 = 4` と式ごと答えます (RAND の論文 P-2922 の図 3a)。再実装は値だけを出します
- 本物の算術は十進です。再実装は JavaScript の浮動小数点で、README にも "javascript floats" とあります。
  「1/3 を 3 回足すとちょうど 1」のような実験は、この環境では JOSS の証明になりません
- `Demand` `Stop` `Done` `Delete` `Form` などは未実装です (README: "only some basic constructs")
- `[条件: 値; 値]` の条件式は、この再実装が参考にした IBM の書籍に由来します。RAND の JOSS Primer
  (RM-5220、1967) では確認できませんでした

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/hello.joss` | `Type` と `Set`。文はピリオドで終わる |
| `demo/steps.joss` | `1.1` 形式の行番号 (part.step)、`Do part 1.`、`for i = 1(1)5` |
| `demo/let.joss` | `Let` で式を定義する (`Let f(x) = ...`)。再帰も書ける |
| `demo/bits.joss` | `To step`、後置の `if`、組み込み関数、エラー |
| `demo/demo.sh` | 上の 4 本を順に流す |

## 実行結果 (2026-10-10)

```
$ ./run.sh sh /work/demo.sh
##### hello.joss
* Type "Hello, world".
Hello, world
* Type 2+2.
4
* Set x = 3.
* Type x, x+1, x*x.
3
4
9
##### steps.joss
* 1.1 Set a = 3.
* 1.2 Set b = 4.
* 1.3 Type sqrt(a*a + b*b).
* Do part 1.
5
* 2.1 Type i, i*i.
* Do part 2 for i = 1(1)5.
1
1
2
4
3
9
4
16
5
25
##### let.joss
* Let f(x) = x*x + 1.
* Type f(3), f(10).
10
101
* Let g(n) = [n = 0: 1; n * g(n - 1)].
* Type g(6).
720
* 1.1 Type "n =", n.
* 1.2 Type g(n).
* Do part 1 for n = 1(1)5.
n =
1
1
n =
2
2
n =
3
6
n =
4
24
n =
5
120
* Do step 1.2 for n = 8, 10.
40320
3628800
##### bits.joss
* 1.1 Type "big".
* 1.2 To step 1.4.
* 1.3 Type "skipped".
* 1.4 Type "done".
* Do part 1.
big
done
* Type "yes" if 3 > 2.
yes
* Type "no" if 3 < 2.
* Type ip(3.7), fp(3.7), sqrt(2).
3
0.7
1.41421356
* Type 2 +.
error: Unexpected token in numeric expression: got '.'
* Type nosuch.
error: No such variable: nosuch
```

(Apple container の `[6/6] Starting container` 進捗は標準エラーなので省いています。)

## 処理系について

- 再実装: https://github.com/wryun/joss-language (コミット `acad0c05`、2025-08-03、MIT)
- 実行系: bun 1.3.14 (`oven/bun:1.3.14-alpine`、digest `sha256:5acc90a9…`、linux/arm64)
- 本体の `bun test` は 110 件すべて成功 (コンテナ内)
