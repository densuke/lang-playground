# Egison を試す (2026-10-29)

「古今東西 プログラミング言語紹介」2026-10-29 回の実験環境です。

Egison は江木聡志 (Satoshi Egi) が作った、パターンマッチを中心に据えた関数型言語です。
多重集合や集合のような「標準の並べ方がないデータ」にも、同じ変数が 2 回出る非線形パターンで一致を取れます。
処理系は Haskell 製で、公式の配布物は Hackage のソース tarball だけなので、手元でビルドして取り込みます。

## 使い方

```bash
./build-egison.sh              # 初回だけ。Egison 5.1.0 をビルド (約 35 分、メモリ 8G のコンテナで実行)
./run.sh                       # シェルに入る (egison と打てば対話環境)
./run.sh sh /work/demo.sh      # 収録用デモを順に流す
./run.sh egison -t /work/twin.egi
```

`build-egison.sh` は共有 builder を使わず、通常のコンテナ (`haskell:9.10.1-bullseye`、digest 固定) の中で
`cabal install` します。成果物は `build/bin/egison` と `build/share` (組み込みライブラリ)。`build/` は git に入れません。

## demo/ の中身

| ファイル | 内容 |
|---|---|
| `hello.egi` | Hello World (`main` を持つプログラム) |
| `multiset.egi` | 多重集合に対する matchAll。非線形パターン (同じ変数が 2 回出る) |
| `twin.egi` | 無限の素数列から双子素数・素数の三つ子を取り出す (公式の代表例) |
| `poker.egi` | ポーカーの役判定 (5 枚の多重集合に対するパターン。公式 sample から抜粋) |
| `math.egi` | 数式処理 (展開・平方根・微分・テイラー展開)。触れる程度 |
| `demo.sh` | 上を順に流す。`-t` は式の値だけを表示する |
