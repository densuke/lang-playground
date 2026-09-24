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

| 公開日 | 言語 | ディレクトリ |
|---|---|---|
| 2026-09-22 | Standard ML | [20260922-Standard_ML](20260922-Standard_ML) |
| 2026-09-24 | Oberon | [20260924-Oberon](20260924-Oberon) |
| 2026-09-28 | Lua | [20260928-Lua](20260928-Lua) |
| 2026-09-29 | Racket | [20260929-Racket](20260929-Racket) |
| 2026-09-30 | Julia | [20260930-Julia](20260930-Julia) |
| 2026-10-01 | Nim | [20261001-Nim](20261001-Nim) |
| 2026-10-02 | Grass | [20261002-Grass](20261002-Grass) |

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
