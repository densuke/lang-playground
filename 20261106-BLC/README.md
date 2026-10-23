# Binary Lambda Calculus を試す (2026-11-06)

「古今東西 プログラミング言語紹介」2026-11-06 回の実験環境です。

```bash
./run.sh                       # シェルに入る
./run.sh bash -s < demo/demo.sh # 全部を順に実行する
```

処理系は John Tromp の IOCCC 2012 受賞作 `tromp.c` (Most functional)。
`ioccc-src/winner` のコミット `815fa1a6780979a47482234b0c8faf298209e99f` に固定し、
sha256 を検証してから gcc でビルドします (Dockerfile、ビルドは 1 分未満・特別なメモリは不要)。
ベースは debian:trixie-slim (digest 固定)。linux/arm64 で動作確認済み。
ライセンスはリポジトリ全体が CC BY-SA 4.0。Tromp 本人の tromp/AIT リポジトリには
LICENSE が無いので、そちらは使っていません。

BLC はビット列で書く言語なので、人が読み書きできる形から変換する小さな
`demo/lam2blc.pl` (perl、このリポジトリのオリジナル) を付けています。
ラムダ式 `\x y z. z x y` を、de Bruijn 添字を経て `00 00 00 01 01 10 1110 110` にします。

| ファイル | 内容 |
|---|---|
| `demo/lam2blc.pl` | ラムダ式 (または de Bruijn 添字) から BLC のビット列を作る。`-s` 区切り表示 / `-B` バイト詰め / `-d` 添字入力 |
| `demo/id.lam` | 恒等関数。0010 の 4 ビット |
| `demo/hi.lam` | 入力を無視して "Hi" を返す |
| `demo/uni.dbj` | 自己解釈器 U (232 ビット)。BLC のページの式 |
| `demo/quine.dbj` | 入力を 2 回つなげる 66 ビットの項。132 ビットの quine の元 |
| `demo/demo.sh` | 上を順に動かす。素数列 (primes.blc) と Brainfuck インタプリタ (bf.Blc) も |
