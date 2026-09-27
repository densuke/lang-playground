# Prolog を試す (2026-07-14)

「古今東西 プログラミング言語紹介」2026-07-14 回の実験環境です。

## 使い方

```bash
./run.sh                       # 対話環境 (swipl) に入る
./run.sh swipl family.pl       # 直接動かす
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。
処理系は apt で入るので、初回でも 1 分ほどで終わります。

## 処理系について

**SWI-Prolog** (`swi-prolog-nox`) を使っています。X11 向けの GUI ツール類を含まない分、
公式の `swipl` Docker イメージより軽量です。

SWI-Prolog は 1987 年から開発が続く実装で、"Since its start in 1987, SWI-Prolog
development has been driven by the needs of real world applications." と公式サイトに
あります (<https://www.swi-prolog.org/>)。バージョン 7.4.0 以降は Simplified BSD
(BSD-2-Clause) ライセンスです。ただし GNU MP (libgmp) を LGPL のまま動的リンクしているため、
GPL/LGPL を避けたい場合は `--without-gpl` / `--without-lgpl` でのビルドが必要、との注記が
公式ドキュメントにあります (<https://www.swi-prolog.org/pldoc/man?section=license>)。

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/family.pl` | 事実 (`parent/2`) と規則 (`grandparent/2` など) による家系図の問い合わせ |
| `demo/append_rev.pl` | `append/3` の双方向性。連結だけでなく分割・補完にも使える |
| `demo/backtrack.pl` | バックトラッキングで `findall/3` により全解を列挙する |

## 実行結果

```
$ swipl family.pl
tanaka の孫: [yamada,ito]
satou のきょうだい: [suzuki]

$ swipl append_rev.pl
連結: [1,2,3,4]
分割: [[]-[a,b,c],[a]-[b,c],[a,b]-[c],[a,b,c]-[]]
補完: [3,4]

$ swipl backtrack.pl
X<Y かつ X+Y=10 の組: [1-9,2-8,3-7,4-6]
```

`append_rev.pl` の「分割」がこの言語らしいところです。`append(X, Y, [a,b,c])` は
「XとYを連結するとリストになる」という関係でしかないので、第一・第二引数を空にして
問い合わせると、成り立つ組み合わせを全部返します。連結専用の関数ではありません。

## つまずきやすい点

**日本語コメントを含むソースは UTF-8 ロケールが無いと文字化けします。** Debian の
コンテナはデフォルトで `C` ロケールなので、この `Dockerfile` では `locales` パッケージを
入れて `en_US.UTF-8` を生成し、`LANG` に設定しています。これを忘れると
`Illegal multibyte Sequence` という警告とともに、`format/2` の日本語出力も `�` の
連続に化けます。

**`:- initialization(main, main).` は「ファイルの読み込みが終わったら `main` を呼び、
終わったら終了する」という宣言です。** ファイルの先頭に書いても、実際に動くのは `main`
述語の定義まで読み込まれた後です。第 2 引数の `main` を省いて `initialization(main)` と
書くと、`main` を実行した後に対話環境 (`?-`) へ入って止まります。`demo.sh` のように
続けて実行したい場合は `main` を付けておく必要があります。

## ライセンス

`demo/` のコードは自由に使ってください。SWI-Prolog 本体のライセンスは
<https://www.swi-prolog.org/pldoc/man?section=license> を参照してください。
