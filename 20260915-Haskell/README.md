# Haskell を試す (2026-09-15)

「古今東西 プログラミング言語紹介」2026-09-15 回の実験環境です。

## 使い方

```bash
./run.sh                                # ghci (対話環境) に入る
./run.sh runghc /work/Lazy.hs           # 直接動かす
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。
初回は apt でコンパイラを入れるので 1〜2 分ほどかかります。

## 処理系について

**GHC**（Glasgow Haskell Compiler、[haskell.org](https://www.haskell.org/ghc/) 配布）を使っています。
`ghci`（対話環境）と `runghc`（コンパイルせずスクリプトとして実行）の 2 通りで試せます。

公式の Docker イメージ `haskell:slim` は GHC に加えて Stack・Cabal を含みます。
この用途では `ghci` / `runghc` が動けば十分なので、GHC 単体である
Debian trixie の `ghc` パッケージ（[Debian Packages: ghc](https://packages.debian.org/trixie/ghc)、
バージョン 9.6.6、実機で確認）を `debian:trixie-slim` に apt で入れる方針にしました。
`container image inspect` で実測したところ、本イメージ（圧縮後）は約 253MB、
初回ビルドも 2 分弱で済みます。

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/Lazy.hs` | 遅延評価と無限リスト。素数列とフィボナッチ数列を無限リストとして定義する |
| `demo/TypeClass.hs` | 型クラス。`Circle` と `Rectangle` に共通の `area` を持たせる |
| `demo/Adt.hs` | 代数的データ型とパターンマッチ。二分探索木、および `Maybe` 相当の自作型 |

## 実行結果

```
$ ./run.sh runghc /work/Lazy.hs
[2,3,5,7,11,13,17,19,23,29]
[0,1,1,2,3,5,8,13,21,34]

$ ./run.sh runghc /work/TypeClass.hs
半径 2.0 の円 の面積は 12.566370614359172
3.0x4.0 の長方形 の面積は 12.0

$ ./run.sh runghc /work/Adt.hs
[1,3,4,5,8]
Ok: 5
Err: 0 で割れません
```

## つまずきやすい点

**コンテナのロケールが未設定だと日本語が文字化けします。** 標準出力のエンコーディングは
`getLocaleEncoding`（[base: GHC.IO.Encoding](https://hackage.haskell.org/package/base/docs/GHC-IO-Encoding.html)、
「現在のロケールの Unicode エンコーディングを返す」と定義）が返す**現在のロケール**に従います。
Debian slim には言語ロケールが入っておらず、`LANG` が空のままだと非 ASCII 文字が `?` に潰れて
出力されることを本環境の構築時に実機で確認しました。`Dockerfile` で `LANG=C.UTF-8`
（glibc 組み込み、ロケール生成不要）を設定して回避しています。

**遅延評価は「あとで一気に」ではありません。** `primes = sieve [2..]` は無限リストですが、
`take 10` で必要な分だけがその場で計算されます。全部を先に計算しようとすると止まりません。

**`::` は型注釈で、型シグネチャの `::` とは書く場所が違います。** `fibs :: [Integer]` は
トップレベルの宣言、`[5, 3, 8 :: Int]` は式の中の注釈です。混同すると構文エラーになります。

## ライセンス

`demo/` のコードは自由に使ってください。GHC のライセンス（BSD 系）は
[haskell.org](https://www.haskell.org/ghc/) の配布元を参照してください。

---

この回の動画: <https://www.youtube.com/watch?v=ZzfvSLIgrOQ>（公開日 2026-09-15）
