# lang-playground

YouTube「古今東西 プログラミング言語紹介」で取り上げた言語を、手元で試すための環境集です。

動画を見て「ちょっと触ってみたい」と思ったときに、処理系の入れ方で消耗しないように
用意しています。1 コマンドで処理系のシェルに入れることを基準にしています。

## ブラウザだけで試す (インストール不要)

このリポジトリの **Code → Codespaces → Create codespace on main** で、ブラウザ上に環境が
立ち上がります。Docker も入った状態なので、そのまま動かせます。

```bash
cd 20260922-Standard_ML
./run.sh
```

手元に何も入れずに試せます。Codespaces は個人アカウントでも毎月の無料枠があります。

## 手元で試す

```bash
git clone https://github.com/densuke/lang-playground.git
cd lang-playground/20260924-Oberon
./run.sh
```

`run.sh` は `container` (macOS 26 の Apple container) / `docker` / `podman` のうち、
見つかったものを使います。初回はイメージを作るので数分かかります。2 回目以降はキャッシュが
効くので数秒です。

直接コマンドを流すこともできます。

```bash
./run.sh sh -c 'voc -m Hello.Mod && ./Hello'
```

## 収録している言語

<!-- langs:start (scripts/update_readme.py が生成) -->
| 公開日 | 言語 | ディレクトリ |
|---|---|---|
| 2026-07-14 | Prolog | [20260714-Prolog](20260714-Prolog) |
| 2026-08-18 | Logo | [20260818-Logo](20260818-Logo) |
| 2026-08-20 | Scheme | [20260820-Scheme](20260820-Scheme) |
| 2026-08-21 | Fractran | [20260821-Fractran](20260821-Fractran) |
| 2026-08-24 | Ada | [20260824-Ada](20260824-Ada) |
| 2026-08-28 | Unlambda | [20260828-Unlambda](20260828-Unlambda) |
| 2026-08-31 | MUMPS | [20260831-MUMPS](20260831-MUMPS) |
| 2026-09-01 | SETL | [20260901-SETL](20260901-SETL) |
| 2026-09-02 | PostScript | [20260902-PostScript](20260902-PostScript) |
| 2026-09-03 | Miranda | [20260903-Miranda](20260903-Miranda) |
| 2026-09-04 | 文言 | [20260904-Wenyan](20260904-Wenyan) |
| 2026-09-10 | REXX | [20260910-REXX](20260910-REXX) |
| 2026-09-11 | Malbolge | [20260911-Malbolge](20260911-Malbolge) |
| 2026-09-15 | Haskell | [20260915-Haskell](20260915-Haskell) |
| 2026-09-18 | Subleq | [20260918-Subleq](20260918-Subleq) |
| 2026-09-22 | COBOL | [20260922-COBOL](20260922-COBOL) |
| 2026-09-22 | Standard ML | [20260922-Standard_ML](20260922-Standard_ML) |
| 2026-09-23 | Tcl | [20260923-Tcl](20260923-Tcl) |
| 2026-09-24 | Oberon | [20260924-Oberon](20260924-Oberon) |
| 2026-09-25 | Thue | [20260925-Thue](20260925-Thue) |
| 2026-09-28 | Lua | [20260928-Lua](20260928-Lua) |
| 2026-09-29 | Racket | [20260929-Racket](20260929-Racket) |
| 2026-09-30 | Julia | [20260930-Julia](20260930-Julia) |
| 2026-10-01 | Nim | [20261001-Nim](20261001-Nim) |
| 2026-10-02 | Grass | [20261002-Grass](20261002-Grass) |
| 2026-10-05 | LISP | [20261005-LISP](20261005-LISP) |
| 2026-10-06 | Koka | [20261006-Koka](20261006-Koka) |
| 2026-10-07 | BASIC | [20261007-BASIC](20261007-BASIC) |
| 2026-10-08 | Lustre | [20261008-Lustre](20261008-Lustre) |
| 2026-10-09 | ArnoldC | [20261009-ArnoldC](20261009-ArnoldC) |
<!-- langs:end -->

## ディレクトリの中身

| ファイル | 内容 |
|---|---|
| `Dockerfile` | 処理系を入れた環境の定義 |
| `run.sh` | 環境に入るためのスクリプト |
| `demo.sh` | 動画で流したコマンドを順に実行する (`./run.sh bash -s < demo.sh`) |
| `README.md` | その言語の説明、実行結果、つまずきやすい点 |
| `demo/` | 動画に出てきたコード |

`demo/` の中身は**動画で見せたコードと同じもの**です。書き写す必要はありません。

## 動画用に端末を収録するとき (制作側の memo)

`asciinema` で録る。**サイズ指定は `--window-size`**。`--cols` / `--rows` というオプションは
無く、指定しても黙って無視されて 80x24 で録れてしまう。

```bash
asciinema rec --overwrite --idle-time-limit 2 --window-size 68x16 \
    -c <収録スクリプト> out.cast
```

**`./run.sh bash -s < demo.sh` は収録では動かない。** 上の表に書いてある対話用の
書き方で、`run.sh` は stdout が端末のときだけ `-t` を付けるため、stdin がファイル
リダイレクトだと container が失敗して **cast が 1 秒足らずで終わる**。収録では stdin を
使わない形にする。

```bash
./run.sh bash -c "$(cat <中で流すスクリプト>)"
```

**コンテナの起動は 1 回にまとめる。** `run.sh` をコマンドごとに呼ぶと、6 段階の起動
スピナーが毎回映り込む。

## 動作環境

`linux/arm64` を既定にしています。Apple Silicon の Mac と ARM の Linux でそのまま動きます。
amd64 でも動きますが、処理系によってはビルドに時間がかかります。

## ライセンス

`demo/` のコードと各ディレクトリの `Dockerfile` / `run.sh` は自由に使ってください。
各言語の処理系そのもののライセンスは、それぞれの配布元を参照してください。
