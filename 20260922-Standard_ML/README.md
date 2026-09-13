# Standard ML を試す (2026-09-22)

「古今東西 プログラミング言語紹介」2026-09-22 回の実験環境です。

## 使い方

```bash
./run.sh                                        # 対話環境 (poly) に入る
./run.sh poly --script /work/Basics.sml         # 直接動かす
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。
処理系は apt で入るので、初回でも 1 分ほどで終わります。

## 処理系について

**Poly/ML** を使っています。対話環境で式を打つと**推論された型がそのまま表示される**ので、
型推論の挙動を見るのに向いています。

```
$ ./run.sh
Poly/ML 5.7.1 Release
> val f = fn x => x + 1;
val f = fn: int -> int
> val g = fn x => (x, x);
val g = fn: 'a -> 'a * 'a
```

ほかに SML/NJ (事実上の参照実装) と MLton (全プログラム最適化) があります。macOS なら
`brew install smlnj mlton polyml` で入ります。

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/Basics.sml` | Hello World・フィボナッチ・代数的データ型。**型を 1 つも書いていない** |
| `demo/Exhaustive.sml` | 場合分けの書き忘れをコンパイル時に指摘させる |
| `demo/Dict.sml` | signature / structure / **functor**。モジュールを取ってモジュールを返す |

## 実行結果

```
$ ./run.sh poly --script /work/Basics.sml
Hello, world!
0 1 1 2 3 5 8 13 21 34
12.56636 12.0

$ ./run.sh poly --script /work/Exhaustive.sml
/work/Exhaustive.sml:6: warning: Matches are not exhaustive.
    Found near fun name R = "red" | name G = "green"

$ ./run.sh poly --script /work/Dict.sml
{1, 3}
{sml, ml}
```

`Dict.sml` は `MakeSet` という functor を 1 つ書いて、`IntSet` と `StringSet` を作っています。
**集合の実装は 1 つしかありません。** 順序が付く型なら何でも受け取れます。

## つまずきやすい点

**式の終わりにセミコロンが要ります。** 対話環境では `;` を打つまで評価されません。
打ち忘れると、入力を待ち続けているように見えます。

**`=` は代入ではありません。** `val x = 1` は束縛で、あとから書き換えられません。
書き換えたいときは `ref` を使います。

**警告は止めてくれません。** 網羅していないパターンマッチは警告のまま通り、実行時に
`Match` 例外で落ちます。警告を読む習慣が要ります。

## ライセンス

`demo/` のコードは自由に使ってください。Poly/ML のライセンスは配布元を参照してください。
