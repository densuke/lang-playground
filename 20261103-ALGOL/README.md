# ALGOL を試す (2026-11-03)

「古今東西 プログラミング言語紹介」2026-11-03 回の実験環境です。対象は **ALGOL 60**。

```bash
./run.sh                    # シェルに入る
./run.sh alg /work/hello.alg   # ALGOL 60 のソースを変換・コンパイル・実行する
./run.sh bash -s < demo.sh  # 全部を順に実行する
```

処理系は GNU MARST 2.8 (ALGOL 60 から C への変換器、2025-10-06 リリース)。ソース配布を
Dockerfile 内で sha256 検証してビルドします。`alg` は marst -> gcc -> 実行をまとめた小さなスクリプトです。
ビルドは数十秒程度、追加メモリは不要です。

| ファイル | 内容 |
|---|---|
| `demo/hello.alg` | Hello World |
| `demo/blocks.alg` | ブロックと変数の有効範囲 |
| `demo/recursion.alg` | 再帰 (階乗) |
| `demo/jensen.alg` | 名前呼びと Jensen's device |
