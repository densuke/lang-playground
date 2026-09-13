# Oberon を試す (2026-09-24)

「古今東西 プログラミング言語紹介」2026-09-24 回の実験環境です。

## 使い方

```bash
./run.sh                      # 処理系のシェルに入る
./run.sh sh -c 'voc -m Hello.Mod && ./Hello'   # 直接動かす
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。
初回はコンパイラをソースからビルドするので 3 分ほどかかります。2 回目以降はキャッシュが効きます。

## 処理系について

**Vishap Oberon Compiler (voc)** を使っています。Oberon のソースを C へ落として
コンパイルする方式で、Linux / macOS / BSD で動きます。

Wirth 本人の **Project Oberon** は、言語だけでなく OS ごと動かす形なので、
言語を試すだけならこちらが早いです。システムそのものを見たい場合は
<http://www.projectoberon.net/> の FPGA 実装かエミュレータをどうぞ。

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/Hello.Mod` | Hello, world |
| `demo/Fib.Mod` | フィボナッチ数列。**公開の印 `*` (export mark)** を見るならここ |
| `demo/Shapes.Mod` | **型拡張**。レコードを土台に別のレコードを作り、実行時に型を判定する |

## 実行結果

```
$ voc -m Fib.Mod && ./Fib
Hello, world!
  0  1  1  2  3  5  8 13 21 34

$ voc -m Shapes.Mod && ./Shapes
figure at 1,2
figure at 10,20  circle r=5
```

## つまずきやすい点

**宣言の順番が固定されています。** `CONST` → `TYPE` → `VAR` → `PROCEDURE` の順で、
手続きより後ろに `VAR` を置くと `END missing` という分かりにくいエラーになります。

```
  13: END Describe;
                  ^
    pos   310  err 41  END missing
```

エラーは手続きの末尾を指しますが、原因は宣言の順番です。

**`make install` は使わなくて構いません。** voc は `make full` の時点で
`voc/install/bin` に一式ができます。この環境では `PATH` をそこへ通しています。

## ライセンス

`demo/` のコードは自由に使ってください。voc 本体のライセンスは
<https://github.com/vishaps/voc> を参照してください。
