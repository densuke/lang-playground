# Bitwise Cyclic Tag (BCT) を試す (2026-11-13)

「古今東西 プログラミング言語紹介」2026-11-13 回 (金曜 esolang 枠) の実験環境です。
取り上げるのは、命令が 0 と 1 の 2 つだけの難解言語 Bitwise Cyclic Tag (BCT) です。
土台の計算モデル Cyclic Tag System (Matthew Cook の 2004 年の論文) も、動画で背景として触れます。

```bash
./run.sh                        # シェルに入る
./run.sh bash -s < demo/demo.sh # 全部を順に実行する
./run.sh python3 ct.py bct 00111 101 -n 12   # BCT のプログラムとデータ語を自分で与える
```

処理系は `demo/ct.py` (このリポジトリのオリジナル。Python 標準ライブラリのみ、約 110 行)。
仕様は esolangs.org の Bitwise Cyclic Tag / Cyclic tag system のページと、
Cook の論文 (Complex Systems 15(1), 2004) に合わせてあります。

- BCT: プログラムは 0 と 1 の列で、巡回して実行する。データも 0 と 1 の列
  - `0` はデータの先頭ビットを消す
  - `1` は次のビット x を読み (そのビットは実行されない)、データの先頭が 1 なら x をデータの末尾に付ける
  - データが空になると停止
- Cyclic Tag System: 生成規則のリストを巡回して使う。データの先頭を消し、それが 1 なら今の規則を末尾に付ける。
  規則を `0 → 10`、`1 → 11`、規則の終わり `→ 0` と書き換えると BCT のプログラムになる (esolangs.org の変換)

既存の BCT 実装 (Coates の C、MIT など) もありますが、第三者コードを使わなくて済む大きさなので自作にしています。
ベースは debian:trixie-slim (digest 固定) + python3-minimal。linux/arm64 で動作確認済み。
ビルドは 1 分未満 (パッケージを 1 つ入れるだけ・特別なメモリは不要)。

| ファイル | 内容 |
|---|---|
| `demo/ct.py` | `bct` (BCT プログラム + データ語) / `tobct` (生成規則から BCT への変換) / `ct` (生成規則 + データ語) / `rule110` (1 セルから) |
| `demo/collatz_bct.py` | BCT で Collatz 列を計算する (esolangs.org の生成規則を BCT にして走らせる) |
| `demo/demo.sh` | 下記 7 つを順に動かす |

## demo.sh の中身

1. BCT の基本 (プログラム 00111、データ語 101。esolangs.org の例と同じ)
2. 0 だけのプログラム (先頭を消すだけ。データ語が空になって停止)
3. 停止する例 (生成規則 00, 10, 11 を BCT にしたもの、データ語 101。363 コマンドで空になる。総当たりで見つけた例で、出典は無い)
4. 増え続ける例 (生成規則 111, 0 を BCT にしたもの、データ語 1)
5. BCT の土台 (Cyclic Tag System の生成規則 → BCT への変換と、31 ステップぶんの照合)
6. Collatz (BCT で k = 3 → 5 → 8 → 4 → 2 → 1 と、7 から始めた列)
7. Rule 110 の時空図 (雰囲気だけ。BCT をその上で動かす実装ではない)

## 実行出力 (コンテナ内、2026-11-01)

```
=== 1. BCT (Bitwise Cyclic Tag): プログラム 00111、データ語 101 (esolangs.org の例と同じ)
step   0  cmd=-   D=101
step   1  cmd=0   D=01
step   2  cmd=0   D=1
step   3  cmd=11  D=11
step   4  cmd=10  D=110
step   5  cmd=0   D=10
step   6  cmd=11  D=101
step   7  cmd=10  D=1010
step   8  cmd=0   D=010
step   9  cmd=11  D=010
step  10  cmd=10  D=010
step  11  cmd=0   D=10
step  12  cmd=11  D=101
(-n 12 で打ち切り: 長さ 3)

=== 2. 0 だけのプログラム: 先頭のビットを 1 つずつ消すだけ。データ語が空になると停止
step   0  cmd=-   D=1011
step   1  cmd=0   D=011
step   2  cmd=0   D=11
step   3  cmd=0   D=1
step   4  cmd=0   D=(empty)
halt: データ語が空になった (4 ステップ)

=== 3. 停止する例: 生成規則 (00, 10, 11) を BCT にしたプログラム、データ語 101
101001110011110
halt: データ語が空になった (363 ステップ)

=== 6. 計算になっている: Collatz (k が偶数なら k/2、奇数なら (3k+1)/2) を BCT で
BCT プログラムの長さ: 42 ビット
k: 3 -> 5 -> 8 -> 4 -> 2 -> 1
実行したコマンド: 576
BCT プログラムの長さ: 42 ビット
k: 7 -> 11 -> 17 -> 26 -> 13 -> 20 -> 10 -> 5 -> 8 -> 4 -> 2 -> 1
実行したコマンド: 3072
```

4・5・7 の出力は長いので省略しています (`./run.sh bash -s < demo/demo.sh` で全部出ます)。
5 は最後に「31 ステップぶん比較: 一致」と出ます。
