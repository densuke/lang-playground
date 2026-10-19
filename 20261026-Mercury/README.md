# Mercury を試す (2026-10-26)

「古今東西 プログラミング言語紹介」2026-10-26 回の実験環境です。

```bash
./build-mercury.sh                 # 初回だけ。公式ソースから Mercury をビルド (約 1 時間 49 分、メモリ 8GB)
./run.sh                           # シェルに入る
./run.sh bash -c "$(cat demo.sh)"  # 全部を順に実行する
```

`build-mercury.sh` は `container` (Apple container) を使います。8GB・8 CPU のコンテナで
configure / make するため重く、2026-10-18 の実測は 1 時間 49 分 29 秒でした。Codespaces での
動作は確かめていません。

処理系は Mercury 22.01.9 (公式ソース配布を sha512 検証してビルド)。
公式の Debian パッケージは amd64/i386 のみで arm64 が無いため、ソースから作ります。
ベースは debian:trixie-slim (digest 固定)。

| ファイル | 内容 |
|---|---|
| `demo/hello.m` | Hello World |
| `demo/modes.m` | det / semidet / multi と mode 宣言。同じ append が連結にも分割にも使える |
| `demo/bad_type.m` | 型エラー (コンパイルが通らない) |
| `demo/bad_det.m` | 決定性エラー (det と宣言したが失敗しうる) |
| `demo/bad_mode.m` | モードエラー (未束縛の変数を in 引数に渡す) |
| `rec-lib.sh` `rec-run.sh` `rec-feature.sh` | 動画用の端末収録 (asciinema) の台本。使い方は各ファイルの先頭 |
