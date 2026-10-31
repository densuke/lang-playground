# Erlang を試す (2026-11-10)

「古今東西 プログラミング言語紹介」2026-11-10 回の実験環境です。

## 使い方

```bash
./run.sh                                  # 対話環境 (erl) に入る
./run.sh escript /work/hello.escript      # 直接動かす
./run.sh bash -s < demo.sh                # 全部を順に実行する
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。

## 処理系について

公式イメージ `erlang:29.1.2-slim` (Erlang/OTP 29.1.2、2026-10-14 リリース。Apache-2.0) を、
マニフェストの digest で固定して使います。arm64 / amd64 の両方が配られています。
Debian の apt (trixie) の Erlang は 27.3.4.1 で古めなので、公式イメージのほうが最新に近いです。

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/hello.escript` | Hello World と OTP の版 |
| `demo/match.escript` | パターンマッチ (タプル・関数の頭・文字列・ビット列・失敗) |
| `demo/procs.escript` | 軽量プロセスとメッセージの送受信、10 万プロセス |
| `demo/crash.escript` | let it crash: スーパーバイザが落ちた worker を再起動する |
