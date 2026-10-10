# R を試す (2026-10-21)

「古今東西 プログラミング言語紹介」2026-10-21 回の実験環境です。

```bash
./run.sh                       # シェルに入る (R と打てば対話環境)
./run.sh Rscript /work/iris.R  # 直接動かす
./run.sh bash -s < demo.sh     # 全部を順に実行する
```

処理系は rocker/r-ver:4.6.1 (digest 固定)。追加パッケージは使わず、base R と組み込みデータセットだけで動きます。

| ファイル | 内容 |
|---|---|
| `demo/hello.R` | Hello World とベクトル演算 |
| `demo/vector.R` | データフレームと summary |
| `demo/iris.R` | iris の table / aggregate / stem (端末で見えるグラフ) |
