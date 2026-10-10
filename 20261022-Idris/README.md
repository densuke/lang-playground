# Idris 2 を試す (2026-10-22)

「古今東西 プログラミング言語紹介」2026-10-22 回の実験環境です。

## 使い方

```bash
./run.sh                           # シェル (bash) に入る。idris2 はそこで使える
./run.sh bash /work/demo.sh        # デモを順に実行する
./run.sh idris2 /work/vect.idr     # 対話環境 (REPL) で vect.idr を読み込む (:t append で型を見る)
./run.sh idris2 --build-dir /tmp/b /work/hello.idr --exec main   # 非対話で実行
```

`container` (Apple container) / `docker` / `podman` のいずれかがあれば動きます。
**初回のビルドは 5 分ほどかかります** (Idris 2 をソースから Chez Scheme でブートストラップするため)。

注意点が 2 つあります。

- **ビルドに 4GB 以上のメモリが要ります。** Apple container の builder は既定が 2GB で、
  Chez のブートストラップ中に `Killed` / `Stream unexpectedly closed` で落ちます。
  `run.sh` は `container build -m 12G -c 4` で build します。builder の設定が変わると
  builder が作り直されるため、**その直後の 1 回目は失敗することがあります。もう一度実行してください。**
- **`bash -s < demo.sh` のように標準入力から流さないでください。** `idris2` が標準入力を読んで
  スクリプトの続きを食べるため止まります。`bash /work/demo.sh` の形で実行します。

## 処理系について

- **Idris 2 v0.8.0** (2025-10-31 リリース、2026-10-10 時点の最新)。公式のソースタグ `v0.8.0` を取得し、
  同梱の Scheme 生成コードから `make bootstrap SCHEME=chezscheme` でビルドします
- Chez Scheme 10.0.0 (Debian trixie の apt)
- ベースイメージ `debian:trixie-slim@sha256:a99cfc517144bc59b1978475ec53b46ecabec7e43635402ee5b77cc54cd1b20a`
  (linux/arm64 で確認)

```
$ ./run.sh idris2 --version
Idris 2, version 0.8.0
```

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/hello.idr` | Hello World |
| `demo/vect.idr` | 長さ付きベクトル `Vect n a`。`append` の型が `Vect (n + m) a` になる |
| `demo/bad_length.idr` | 長さ 3 と宣言して要素を 2 個しか渡さない。型エラーになる |
| `demo/bad_total.idr` | `total` を付けた関数で `n = 0` の場合を書き忘れる。"not covering" になる |
| `demo/demo.sh` | 上の 4 本を順に流す |

## 実行結果

```
$ ./run.sh bash /work/demo.sh
Idris 2, version 0.8.0
Hello, world!
1/1: Building vect (/work/vect.idr)
Main> Main.append : Vect n a -> Vect m a -> Vect (n + m) a
Main> Main.firstOf : Vect (S n) a -> a
Main> Bye for now!
[1, 2, 3, 4, 5]
1
1/1: Building bad_length (/work/bad_length.idr)
Error: While processing right hand side of bad. Sorry, I can't find any elaboration which works. All errors:
If Data.Vect.Nil: When unifying:
    Vect 0 Int
and:
    Vect 1 Int
Mismatch between: 0 and 1.
...
exit=1
1/1: Building bad_total (/work/bad_total.idr)
Error: firstOf is not covering.

bad_total:6:1--7:24
 6 | total
 7 | firstOf : Vect n a -> a

Missing cases:
    firstOf []

exit=1
```

(`bad_length` のエラー全文は research_idris.md の【動作検証】にあります。)

## つまずきやすい点

**`[1, 2]` は Vect にも List にもなる。** どちらの型かは期待される型で決まるため、
エラーには `Data.Vect.Nil` の場合と `Prelude.Nil` (List) の場合が両方出ます。
型が合わなかった理由が 2 つ並ぶだけで、意味は同じです。

## ライセンス

`demo/` のコードは自由に使ってください。Idris 2 本体は BSD 3-Clause 系のライセンスです
(リポジトリの LICENSE)。
