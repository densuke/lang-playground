# INTERCAL を試す (2026-11-27)

「古今東西 プログラミング言語紹介」2026-11-27 回 (esolang 枠) の実験環境です。

## 使い方

```bash
./run.sh                                  # 対話シェル (bash) に入る (ick が使える)
./run.sh bash -c 'cd /tmp && cp /work/hello.i . && ick -b hello.i && ./hello'   # 1 本だけ動かす
./run.sh bash -s < demo.sh                # 全部を順に実行する (1 秒かからない)
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。
初回だけビルドします (GitLab から取得してコンパイル、1 分ほど)。`demo/` が `/work` に入ります。

`ick foo.i` は INTERCAL を C に直して cc で実行ファイル `foo` を作ります (カレントに出る)。
`-b` は「コンパイラの気まぐれな失敗 (E774、わざと入っている) を出さない」指定で、デモを毎回同じ結果にするために付けています。

## 処理系について

C-INTERCAL (ick) 0.35 (2026-08-13 リリース、保守者 Eric S. Raymond) を、GitLab の 0.35 タグの
アーカイブからビルドします (`src/SHA256SUMS` で検証)。Debian trixie の apt (intercal 0.30-6) より新しいので apt は使いません。

- ライセンスは GPL v2 以降 (生成される C の雛形だけ非 GPL、マニュアルは GFDL 1.2)。このリポジトリには同梱せず、ビルド時に取得します
- GitLab のアーカイブは再生成でバイトが変わりうるので、sha256 が合わなくなったらビルドが止まります (SHA256SUMS を更新してください)
- `autoconf` / `automake` / `bison` / `flex` / `texinfo` はビルド段階だけに入れ、実行側のイメージは gcc (ick が生成した C をコンパイルするのに要る) だけです

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo.sh` | 下の例を順に実行する |
| `demo/hello.i` | Hello, World! (17 行。文字を「前の文字との差」で配列に入れる) |
| `demo/roman.i` | 数値の出力がローマ数字になる (`#1990` → MCMXC。上に棒を引く拡張ローマ数字なので、上の行に空白が出る) |
| `demo/rude.i` | 全部 `DO` で `PLEASE` が足りない。コンパイラが拒否する (E079) |
| `demo/servile.i` | 全部 `PLEASE` で多すぎる。コンパイラが拒否する (E099) |
| `demo/comefrom.i` | `COME FROM`。(1) の文のあとに COME FROM へ飛び、間の文を飛ばす |

INTERCAL のソースには普通のコメントがありません。このため demo/ のコードにコメントは入れていません (解説はこの README と調査素材に)。
