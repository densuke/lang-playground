# PowerShell を試す (2026-11-04)

「古今東西 プログラミング言語紹介」2026-11-04 回の実験環境です。

```bash
./run.sh                           # シェルに入る (pwsh の対話環境)
./run.sh pwsh -NoProfile -File /work/hello.ps1   # 直接動かす
./run.sh bash -s < demo.sh         # 全部を順に実行する
```

処理系は PowerShell 7.6.8 (クロスプラットフォーム版、MIT ライセンス。2026-10-22 リリース)。
Microsoft の公式イメージではなく、`debian:trixie-slim` (digest 固定) に GitHub Releases の
linux-arm64 tarball を入れています (SHA256 を Dockerfile で検証)。初回ビルドは約 1 分。

| ファイル | 内容 |
|---|---|
| `demo/hello.ps1` | Hello World と版・エディションの確認 |
| `demo/objects.ps1` | 流れているのは文字列ではなくオブジェクト (`Get-Member`) |
| `demo/pipeline.ps1` | `Where-Object` `Sort-Object` `Select-Object` `Group-Object` で絞る・並べる |
| `demo/data.ps1` | JSON をオブジェクトにして、別の形 (CSV) へ |
