# Bash を試す (2026-11-18)

「古今東西 プログラミング言語紹介」2026-11-18 回の実験環境です。

## 使い方

```bash
./run.sh                          # 対話環境 (bash) に入る
./run.sh bash /work/arrays.sh     # 直接動かす
./run.sh bash -s < demo.sh        # 全部を順に実行する
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。

## 処理系について

公式イメージ `bash:5.3.20` (GNU Bash 5.3、パッチレベル 20。GPL-3.0-or-later) を、
マニフェストの digest で固定して使います。arm64 / amd64 の両方が配られています。
macOS 標準の `/bin/bash` は 3.2.57 で、連想配列 (`declare -A`) や `${f^^}` が使えません。
そのため、手元の Mac で直接動かさず、コンテナの最新版で見せます。

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/hello.sh` | Hello World と版 (`BASH_VERSION`) |
| `demo/arrays.sh` | 配列と連想配列 |
| `demo/expand.sh` | パラメータ展開と波括弧展開 |
| `demo/procsub.sh` | プロセス置換 (`<(...)`)、パイプとの違い (パイプの先はサブシェルで変数が残らない) |
| `demo/regex.sh` | `[[ ]]` と正規表現 (`BASH_REMATCH`) |
| `demo/strict.sh` | `set -e` / `pipefail` の効果と、`if` の条件の中で `-e` が効かない落とし穴 |
