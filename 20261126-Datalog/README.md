# Datalog (Soufflé) を試す (2026-11-26)

「古今東西 プログラミング言語紹介」2026-11-26 回の実験環境です。

## 使い方

```bash
./run.sh                                 # 対話シェル (bash) に入る
./run.sh souffle /work/ancestor.dl -D-   # 1 本動かす (-D- は結果を標準出力へ)
./run.sh bash -s < demo.sh               # 全部を順に実行する
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。
`demo/` が `/work` に入ります。初回はソースからのビルドで時間がかかります。

注意: 既定の builder (2GB) では Soufflé のビルドに長時間かかる、または途中で止まることがあります
(2CPU/2GB で 1 時間以上かかって完了しなかった)。`container builder start --cpus 6 --memory 8G` などで
増やすか、`container build -c 6 -m 12G -t lang-datalog .` で明示してください。ビルドは `-j1` です。

## 処理系について

Datalog は 1 つの処理系を持つ言語ではなく、データベース理論から生まれた言語の族です。
ここでは現役の実装 Soufflé 2.5 (2025-03-24 リリース、UPL-1.0) を使います。
Soufflé は Datalog を拡張した言語を処理します (算術などの関数を足してある)。
公式の配布バイナリは x86_64 だけで Debian にもパッケージが無いため、ソースタグ 2.5 から
arm64 でビルドします (sha256 検証)。実行は解釈実行 (`souffle file.dl`) のみで、C++ への変換は使いません。

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/ancestor.dl` | 親子から祖先 (推移閉包)。右再帰 |
| `demo/left_recursion.dl` | 同じ祖先を左再帰で書く。止まる |
| `demo/reachability.dl` | 循環のあるグラフの到達可能性と、到達できない点 (否定) |
| `demo/diverge.dl` | 止まらない例。Soufflé の算術拡張で値が増え続ける (demo.sh は 3 秒で打ち切る) |
