# Cyclic Tag System を試す (2026-11-13)

「古今東西 プログラミング言語紹介」2026-11-13 回 (金曜 esolang 枠) の実験環境です。

```bash
./run.sh                        # シェルに入る
./run.sh bash -s < demo/demo.sh # 全部を順に実行する
./run.sh python3 ct.py ct "011,10,101" 1 -n 10   # 規則とデータ語を自分で与える
```

処理系は `demo/ct.py` (このリポジトリのオリジナル。Python 標準ライブラリのみ、約 100 行)。
仕様は Matthew Cook の論文 (Complex Systems 15(1), 2004) と esolangs.org の
Cyclic tag system / Bitwise Cyclic Tag のページに合わせてあります。
データ語の先頭を読んで消し、それが 1 なら現在の生成規則を末尾に付け、規則は巡回し、
データ語が空になったら停止します。
既存の BCT 実装 (Coates, MIT) もありますが、第三者コードを使わなくて済む大きさなので自作にしています。
ベースは debian:trixie-slim (digest 固定) + python3-minimal。linux/arm64 で動作確認済み。
ビルドは 1 分未満 (パッケージを 1 つ入れるだけ・特別なメモリは不要)。

| ファイル | 内容 |
|---|---|
| `demo/ct.py` | `ct` (生成規則 + データ語) / `bct` (BCT プログラム + データ語) / `tobct` (規則から BCT への変換) / `rule110` (1 セルから) |
| `demo/demo.sh` | 下記 6 つを順に動かす |

## demo.sh の中身

1. Cook の例 (規則 011, 10, 101、データ語 1) のステップ表示
2. 停止する例 (規則 00, 10, 11、データ語 101。121 ステップ後にデータ語が空になる)
3. 増え続ける例 (Cook の図 2 の規則 YYY, N、データ語 1)
4. Collatz (巡回タグで偶数 n/2・奇数 (3n+1)/2 を計算する。esolangs.org の例)
5. BCT (プログラム 00111、データ語 101) と、規則から BCT への変換が正しいことの照合
6. Rule 110 の時空図 (巡回タグがその上で動く、という雰囲気だけ。Cook の構成そのものではない)
