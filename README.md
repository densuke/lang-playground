# lang-playground

YouTube「古今東西 プログラミング言語紹介」で取り上げた言語を、手元で試すための環境集です。

動画を見て「ちょっと触ってみたい」と思ったときに、処理系の入れ方で消耗しないように
用意しています。1 コマンドで処理系のシェルに入れることを基準にしています。

## 使い方

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

## ディレクトリの中身

| ファイル | 内容 |
|---|---|
| `Dockerfile` | 処理系を入れた環境の定義 |
| `run.sh` | 環境に入るためのスクリプト |
| `demo.sh` | 動画で流したコマンドを順に実行する |
| `README.md` | その言語の説明、実行結果、つまずきやすい点 |
| `demo/` | 動画に出てきたコード |

`demo/` の中身は**動画で見せたコードと同じもの**です。書き写す必要はありません。

## 動作環境

`linux/arm64` を既定にしています。Apple Silicon の Mac と ARM の Linux でそのまま動きます。
amd64 でも動きますが、処理系によってはビルドに時間がかかります。

## ライセンス

`demo/` のコードと各ディレクトリの `Dockerfile` / `run.sh` は自由に使ってください。
各言語の処理系そのもののライセンスは、それぞれの配布元を参照してください。
