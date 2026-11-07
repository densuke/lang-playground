# Forth を試す (2026-11-19)

「古今東西 プログラミング言語紹介」2026-11-19 回の実験環境です。

## 使い方

```bash
./run.sh                                  # 対話環境 (gforth) に入る
./run.sh gforth /work/hello.fs -e bye     # 直接動かす
./run.sh bash -s < demo.sh                # 全部を順に実行する
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。
初回はソースからのビルドで 1 分ほどかかります。

## 処理系について

Gforth 1.0.0 (GNU Forth、GPLv3+) を、公式配布物 (`gforth-1.0.0.tar.xz`) の sha256 を検証してソースからビルドします。
Debian trixie の apt には gforth が無く (sid / forky は 0.7.3+dfsg-10)、新しい版はソースから入れるのが近道です。
arm64 / amd64 の両方で動きます。

ビルドは `CFLAGS=-O1` にしています。既定の最適化だとエンジンのコンパイルで gcc がメモリを使い切り、
Apple container の builder (12 GB) では落ちるためです。実行速度は demo の用途では差がありません。
ドキュメント (info / html) の生成は失敗しますが、本体には影響しません。

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/hello.fs` | スタックと逆ポーランド記法 (`.s` で中身を見る) |
| `demo/define.fs` | `:` と `;` でワードを定義する。再定義。`see` で定義を見る |
| `demo/control.fs` | `unless` / `times ... end` を自分で作る (`immediate`) |
| `demo/defining.fs` | `create ... does>` でワードを作るワード。配列、単位 |
