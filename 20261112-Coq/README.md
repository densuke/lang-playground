# Coq (Rocq) を試す (2026-11-12)

「古今東西 プログラミング言語紹介」2026-11-12 回の実験環境です。
Coq は 2025 年に **Rocq (The Rocq Prover)** へ改名されました。コマンドも `coqc` / `coqtop` から `rocq compile` / `rocq repl` に変わっています。

```bash
./run.sh                                  # シェル (bash) に入る
./run.sh rocq compile /work/hello.v       # 証明をコンパイル (通れば何も出ない)
./run.sh rocq repl                        # 対話環境 (REPL)
./run.sh bash /work/demo.sh               # 全部を順に実行する
```

`container` (Apple container) / `docker` / `podman` のいずれかがあれば動きます。
**初回のビルドは約 6 分** (Rocq を opam でソースからビルドするため)。

## 処理系について

- **Rocq 9.3.0** (`rocq-runtime` / `rocq-core`、2026-09-19 リリース、2026-10-31 時点の最新)
- **Stdlib 9.2.0** (`rocq-stdlib`。Stdlib の 9.3 系はまだ無いので最新の 9.2.0 を使う)
- Debian trixie の OCaml (システム OCaml) と opam。opam-repository は commit 固定の tarball (sha256 検証)
- ベースイメージ `debian:trixie-slim@sha256:62bd423aeee912639ca8ee681c2b762cb3e25137e0a92b20be455898a9f034ad` (linux/arm64)
- 公式の `rocq/rocq-prover` イメージは amd64 のみを確認したため使っていません
- ライセンス: Rocq は LGPL 2.1。demo/ のコードは本リポジトリのオリジナル

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/hello.v` | 帰納法で `n + 0 = n` を証明する。`Print Assumptions` で公理に頼っていないことを確認 |
| `demo/rev_twice.v` | 自作の `rev` で「2 回ひっくり返すと元に戻る」を補題つきで証明 |
| `demo/bad_claim.v` | 偽の主張 `n + 1 = n` を証明しようとして拒否される (コンパイル失敗) |
| `demo/bad_cheat.v` | ゴールを残したまま `Qed` と書いて拒否される |
| `demo/extract.v` | 「整列していて、元の並べ替えである」と証明した挿入ソートを `isort.ml` (OCaml) へ抽出 |
| `demo/run_isort.ml` | 抽出された OCaml を呼ぶ |
| `demo.sh` | 上を順に流す |
