# Eiffel を試す (2026-08-19)

「古今東西 プログラミング言語紹介」2026-08-19 回の実験環境です。
動画: <https://www.youtube.com/watch?v=WCWn_oRp8kE>

## 使い方

```bash
./run.sh                              # シェルに入る。exit で抜ける
./run.sh eiffel hello.e               # コンパイルして実行する
./run.sh eiffel bank.e account.e      # 複数のクラスを渡すときは、入口のクラスを先頭に
./run.sh bash -s < demo.sh            # 収録と同じ順に全部動かす
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。
初回はダウンロード (約 160MB) と標準ライブラリのコンパイルがあるので数分かかります。

## 処理系について

動画の「試すなら」で紹介した Eiffel Software の **EiffelStudio 25.12** を使っています。
GUI は使わず、コマンドラインのコンパイラ `ec` だけを動かします。`ec` は Eiffel のコードを
C に変換し、gcc でコンパイルします。

調査の段階では「公式のダウンロードには登録が要る」としていましたが、実際には
<https://ftp.eiffel.com/pub/download/> に各 OS 向けのアーカイブが登録なしで置かれていました。
その中に linux-arm64 版があるので、`Dockerfile` ではそれを取ってきて、SHA-256 を確かめて
展開しています。Apple Silicon の Mac でも arm64 のまま動きます。

`eiffel` コマンドは、この環境のために用意した小さなスクリプトです。最初に渡したファイルの
クラスを入口 (`make`) にした設定ファイル (`.ecf`) を一時ディレクトリに作り、`ec` で
コンパイルして実行します。`require` / `ensure` / `invariant` は、すべて実行時に検査する
設定にしています。

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/hello.e` | あいさつと、ループ不変条件 (`invariant`) と変位式 (`variant`) 付きの 1 から 10 の合計 |
| `demo/account.e` | 動画の口座クラス。`deposit` の `require` / `ensure` と、残高が負にならない `invariant` |
| `demo/bank.e` | 契約をわざと破って、どの約束が破れたかを表示する |

## 実行結果

```
$ eiffel hello.e
Hello, World!
sum 1..10 = 55

$ eiffel bank.e account.e
deposit (100)        -> balance = 100
deposit (-5)         -> Precondition violated. [non_negative]
buggy_deposit (50)   -> Postcondition violated. [balance_increased]
withdraw (80)        -> Class invariant violated. [balance_non_negative]
```

`bank.e` は、口座に 3 通りの壊し方をしています。

- `deposit (-5)` は、呼ぶ側が `require` の `non_negative` を破っています。呼んだ側のバグです
- `buggy_deposit (50)` は、本体が足し算を忘れているので、`ensure` の `balance_increased` が
  破れます。呼ばれた側のバグです
- `withdraw (80)` は、残高 (30) より多く引けてしまい、クラスの `invariant` である
  `balance_non_negative` が破れます

角括弧の中は、契約に付けたラベルです。ラベルを付けておくと、どの条件が破れたかが
そのまま表示されます。`bank.e` では例外を `rescue` で受け止めて `retry` し、次の壊し方に
進んでいます。

## つまずきやすい点

**標準ライブラリを前もってコンパイルしておかないと、とても遅くなります。** 何もしないと
`ec` は小さなプログラムでも標準ライブラリ全体を C にしてコンパイルします。メモリ 1GB の
コンテナでは、これに 10 分以上かかったうえで gcc がメモリ不足で落ちました。`Dockerfile` では
イメージを作るときに EiffelBase をプリコンパイルしておき、`eiffel` はそれを使います。
こうすると 1 本のコンパイルが数秒で終わります。

**プリコンパイルと設定をそろえる必要があります。** 設定ファイルの並行処理の設定 (SCOOP) が
プリコンパイル側と違うと、`VD46: incompatible precompiled library` で止まります。
`eiffel` が作る設定ファイルでは、並行処理を使わない設定にしています。

**`ec` は失敗しても終了コード 0 を返すことがあります。** プリコンパイルを作れなかったときも
0 で終わり、実行ファイルができていないことに後から気づきました。

**`ec` はコマンドライン版でも GTK 3 が要ります。** 無いと `libgtk-3.so.0` が見つからないと
言われて起動しません。画面は使わないので、ライブラリを入れるだけで動きます。

**void 安全性の検査が既定で有効です。** `tag_name` のように値が無いかもしれない文字列を
`+` でつなぐと、`VUTA(2)` (対象が void かもしれない) でコンパイルが止まります。
`bank.e` では `print` を分けて呼んでいます。

## ライセンス

`demo/` のコードは自由に使ってください。

EiffelStudio は、Eiffel Software が二つのライセンスで提供しています
(<https://www.eiffel.com/licensing/>)。商用ライセンスを買うか、作ったアプリケーションを
オープンソースのライセンスで公開するか、のどちらかを選ぶ形です。なお、アーカイブに
同梱の `LICENSE` は商用の使用許諾契約書です。この環境は動画の実験用であり、
アーカイブを再配布はしていません (`Dockerfile` は公式の配布元から取ってきます)。
