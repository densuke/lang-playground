# AID (JOSS の末裔) を TOPS-10 + simh で動かす (2026-10-20)

「古今東西 プログラミング言語紹介」2026-10-20 回の実験環境その 2 です。
1963 年の RAND の JOSS 本体は動かせません。代わりに、DEC が JOSS の言語要素を PDP-10 向けに移植した
**AID (Algebraic Interpretive Dialogue)** を、PDP-10 エミュレータ simh 上の **TOPS-10 6.03** で動かします。
AID は RAND の許可を得た移植です (1970 年の PDP-10 Timesharing Handbook の序文)。ただし JOSS そのものではなく、記法が違います (下記)。

手順の出発点は https://timereshared.com/tops-10-aid/ と、同サイトの
https://timereshared.com/tops-10-quick-tour-simh/ (TOPS-10 を simh で動かす記事) です。

親ディレクトリ (`../`) の環境は別物で、wryun/joss-language という第三者の再実装です。こちらは消さずに残しています。

## 使い方

```bash
./run.sh                                  # 対話。TOPS-10 を起動して telnet で入る
./run.sh aid-demo                         # demo/*.aid を非対話で流す (hello, steps, let, diff の順)
./run.sh aid-demo /work/hello.aid         # 1 本だけ
```

`container` / `docker` / `podman` のいずれかがあれば動きます (本リポジトリでは Apple container で確認)。
初回だけ 2 つのファイル (計 約 59 MB) を `images/` に取得して sha256 を検査します。

対話では `login 100,100` / パスワード `demo1` で入り (PiDP-10 のイメージに入っている公開アカウント)、
`.r aid` で AID が起ち `*` が出ます。AID を抜けるのは Ctrl-C、TOPS-10 から出るのは `.r logout`、
telnet を閉じるのは Ctrl-] のあと `quit`。

## 構成

| ファイル | 内容 |
|---|---|
| `Dockerfile` | open-simh を **コミット `87eb7d5e` に固定**してソースから `pdp10-ka` だけビルド。ベースは `debian:bookworm-slim` を digest 固定、linux/arm64 |
| `run.sh` | 版権物の取得 (sha256 検査) とビルド・実行 |
| `ini/` | simh の設定。構成は timereshared/dec-tops-10-simh-quickstart (BSD-3-Clause) に由来 |
| `bin/aid-boot` | ディスクとテープを展開し、simh を背景で起動。ログインできるまで待つ (約 20 秒) |
| `bin/aid-run` | telnet で入り、`[1,2]` で BACKUP を使いテープから `AID.EXE` を `SYS:` へ入れ、`100,100` で AID を起動して台本を 1 行ずつ流す (expect) |
| `bin/aid-demo` | `aid-boot` + `aid-run` |
| `demo/*.aid` | AID に流す台本 (1 行 = 1 コマンド)。行頭 `#` は見出し、`>` は Demand への答え |

## 取得するファイルと再配布の条件

**イメージ類は git に入れません** (`.gitignore` の `images/`)。`run.sh` が毎回、無ければ取りに行きます。

| ファイル | 取得元 | サイズ | sha256 |
|---|---|---|---|
| `tops603ka.zip` (TOPS-10 6.03 のディスク 4 枚、PiDP-10 プロジェクト製) | https://obsolescence.dev/pidp10-sw/tops603ka.zip | 55,448,190 B | `70fbf55544bb50dd6b9216cbad0bd037cb41c1fd9570ea6e94dd13735f61599d` |
| `bb-x130a-sb.tap.bz2` (BB-X130A-SB、TOPS-10 Customer Supported CUSPs 1984-04、AID を含む) | https://pdp-10.trailing-edge.com/tapes/bb-x130a-sb.tap.bz2 | 6,451,619 B (展開後 約 19.3 MB) | `929b757b077a700b9090d025df5f516f6357c6e2833d9ed195c090088fa83ec5` (展開後 `c291f7756f0ef64564107db8d9a31d3467df654e951901355499bf65732ed76e`) |

**再配布はできない前提で扱ってください。** TOPS-10 と AID は DEC (現在の権利者は別) の著作物で、
trailing-edge は「DEC 36 ビット ホビイスト ライセンス」の利用者のための置き場だと明記しています。
そのライセンスは「個人的で非商業的な利用に限って」使用と改変を許諾するもので
(原文 "solely for personal, non-commercial uses")、再配布を認める条項は見当たりません。

- 動画をこのイメージ自体の配布なしに画面として見せるのは、再配布ではありません
- 画面を収録した動画を収益化したチャンネルで公開することが「非商業的」に当たるかは判断がつかないため、この環境を使う 2026-10-20 回 (長編・ショート) は**広告をオフにして公開**します
- simh は MIT ライセンスです (open-simh)

ライセンス全文は https://pdp-10.trailing-edge.com/ の「DIGITAL LICENSE AGREEMENT」にあります。

## RAND の JOSS と AID の違い (実機で確かめたもの)

demo/ の台本を流した結果です。出力の全文は research_joss.md の【動作検証】にあります。

| | RAND JOSS (P-2922 ほか) | AID 20A(32) |
|---|---|---|
| 乗算 | 中黒 `·` | `*` (`&` も受け付け、答えの表示は `*` に直る) |
| べき乗 | `*` | `^` (`**` も受け付け、表示は `^`) |
| 変数名 | 英字 | **1 文字だけ** (大文字小文字は別、計 52 個) |
| 文字集合 | JOSS 専用の端末 | Teletype。入力は大文字小文字を区別し、命令は先頭だけ大文字か全部小文字 (`TYPE` は `Eh?`) |
| `Type 2+2.` の答え | `2+2 = 4` と式ごと答える | 同じく式ごと答える (`2+2 =	      4`)。JOSS の出力形式を引き継いでいる |
| 分からない命令 | `Eh?` | `Eh?` (同じ) |
| 保存行の誤り | (未確認) | **入力時は通り、`Do` で実行したときに** `Error at step 8.1:  Eh?` (DEC の手引きも「入力時は行番号だけ検査する」と書く) |
| 未定義の変数 | (未確認) | `x = ???` |
| ゼロ除算 | (未確認) | `I have a zero divisor.` |
| 数値 | 十進 (RAND の記述) | 9 桁に丸める十進 (`1/3` を 3 回足すと `.999999999`) |
| 命令の末尾のピリオド | 命令はピリオドで終わる (図 3a、3d) | **省略可** (DEC の手引きも「optional」と書く)。保存した行の表示ではピリオドが補われる |
| `Let` | 式の定義 | 式 (`Let d = ...`) と利用者関数 (`Let f(b,c) = ...`) |
| 入力 | `Demand` | `Demand x` → `x =` と尋ねられる |

(RAND JOSS 側の列は research_joss.md の一次資料に基づく。AID 側の列が今回実機で確かめたもの。「未確認」は RAND 側の一次資料を今回当たっていない。)

## 意図的に空けている箇所

- シェルの expect で telnet を操作する `aid-run` は、テスト (自動検査) を置いていません。壊れたらデモ収録が止まるだけで、
  すぐ気づけて、データは失われないためです。止まったときは 120 秒でタイムアウトして、受信内容つきで落ちます
- ディスクイメージは毎回 `images/` から展開します (コンテナ内のコピーなので、AID のインストールは毎回 約 15 秒かかる)

## 注意

- TOPS-10 6.03 は 2000 年問題を持つので、日付は今日の月日 + 1979 年にしています (ログインの `Tue` などの曜日は 1979 年のもの)
- 画面幅は約 72 桁で、`Type` の長い行は途中で折れます。台本の行は短く保っています
