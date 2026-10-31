# C# を試す (2026-11-11)

「古今東西 プログラミング言語紹介」2026-11-11 回の実験環境です。

```bash
./run.sh                           # シェルに入る (bash。中で dotnet が使える)
./run.sh dotnet run hello.cs       # ファイル単体で直接動かす
./run.sh bash -s < demo.sh         # 全部を順に実行する
```

処理系は .NET SDK 10.0.403 (C# 14、LTS。2026-10-25 リリース、2026-10-31 時点の最新)。
Microsoft の公式イメージではなく、`debian:trixie-slim` (digest 固定) に公式 linux-arm64 tarball を
入れています (SHA512 を Dockerfile で検証。Microsoft が公開しているハッシュは SHA512)。
`dotnet run X.cs` は .NET 10 のファイル単体実行 (csproj 不要。一時フォルダでビルドして実行)。
初回は SDK の展開と各ファイルのビルドで数秒かかります。

| ファイル | 内容 |
|---|---|
| `demo/hello.cs` | Hello World・トップレベル文・`var` の型推論 |
| `demo/linq.cs` | LINQ (クエリ式とメソッド形式、GroupBy) |
| `demo/records.cs` | `record`・`switch` 式のパターンマッチ・`with` |
| `demo/async.cs` | `async` / `await` と `Task.WhenAll` (順番に 約 600 ms、同時に 約 300 ms) |
