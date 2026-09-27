# Logo を試す (2026-08-18)

「古今東西 プログラミング言語紹介」2026-08-18 回の実験環境です。
動画: <https://www.youtube.com/watch?v=h29mrMvsA7Q>

## 使い方

```bash
./run.sh                          # 対話環境 (ucblogo) に入る。bye で抜ける
./run.sh ucblogo square.lg        # 直接動かす
./run.sh bash -s < demo.sh        # 収録と同じ順に全部動かす
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。
処理系をソースからビルドするので、初回は apt だけの環境より少し時間がかかります。

## 処理系について

動画で紹介した **Berkeley Logo (UCBLogo) 6.2.4** を使っています。公式ページ
(<https://people.eecs.berkeley.edu/~bh/logo.html>) に 6.2.4 (2024 年 7 月 2 日) が
現行版と書かれており、開発は GitHub の <https://github.com/jrincayc/ucblogo-code> で
続いています。

Debian にも `ucblogo` パッケージがありますが、wxWidgets を使う GUI 版で、画面の無い
コンテナでは `Unable to initialize GTK+` で起動できません。そこで `Dockerfile` では
公式リリースのソースを取ってきて、SHA-256 を確かめたうえで `--disable-wx` (文字だけの版) で
ビルドしています。

**タートルの絵は出ません。** ただし位置 (`pos`) と向き (`heading`) は内部で計算されるので、
どこへ動いたかを数字で確かめられます。

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/square.lg` | 動画の `repeat 4 [forward 100 right 90]` と手続き `square :size`。1 周して原点に戻る |
| `demo/star.lg` | 100 歩進んで 144 度曲がるを 5 回。星の頂点の座標を表示する |
| `demo/lists.lg` | `first` / `butfirst` / `map` によるリスト処理と、再帰の `countdown` |

## 実行結果

```
$ ucblogo square.lg
repeat 4 [forward 100 right 90]
back at: 0 0
square 50 -> back at: 0 0

$ ucblogo star.lg
corners of the star:
0 100
59 19
-36 50
59 81
0 0

$ ucblogo lists.lg
apple
banana cherry
1 4 9 16 25
3
2
1
liftoff!
```

`square.lg` は、四角形を描き終えたタートルが原点 `0 0` に戻っていることを確かめています。
`star.lg` の座標は `round` で整数に丸めています。

## つまずきやすい点

**ファイルの最後には必ず `bye` を書きます。** `ucblogo file.lg` はファイルを読み終えると
対話環境に入り、標準入力からコマンドを待ちます。`./run.sh bash -s < demo.sh` のように
標準入力がパイプになっていると、`demo.sh` の残りを Logo のコマンドとして読んでしまいます。

**途中でエラーが出ると、`bye` まで届きません。** UCBLogo はエラーが出た時点でファイルの
読み込みをやめて対話環境に入ります。その場合も上と同じく、続きの標準入力が Logo に
読まれます。

**画面の無い版では、画面の端で座標が折り返します。** 文字だけの版は画面の大きさが
100 x 100 として扱われ、既定の `wrap` モードでは端を越えると反対側から出てきます。
デモの先頭で `window` を実行して、どこまでも進めるようにしています。

**文字だけの版には、描画記録用のバッファが 1 バイトしか無いという不具合があります。**
そのままビルドすると `forward` を呼んだだけで `malloc(): invalid size` で落ちます。
`Dockerfile` では `nographics.h` の `GR_SIZE` を GUI 版と同じ 60000 に書き換えてから
ビルドしています。

## ライセンス

`demo/` のコードは自由に使ってください。UCBLogo 本体は GNU GPL バージョン 3 以降で
配布されています (ソースに同梱の `README.md` と `LICENSE` による)。
