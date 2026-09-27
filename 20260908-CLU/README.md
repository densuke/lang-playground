# CLU を試す (2026-09-08)

「古今東西 プログラミング言語紹介」2026-09-08 回の実験環境です。
動画: <https://www.youtube.com/watch?v=fTQDKUo2idE>

## 使い方

```bash
./run.sh                          # シェルに入る。exit で抜ける
./run.sh clu complex.clu          # 直接動かす (CLU → C → 実行ファイル → 実行)
./run.sh bash -s < demo.sh        # 収録と同じ順に全部動かす
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。
処理系とガベージコレクタをソースからビルドするので、初回は数分かかります。

## 処理系について

MIT の **Portable CLU (PCLU) 3.7** を使っています。PCLU は CLU のプログラムを C に変換し、
`cc` でコンパイルして実行ファイルを作る処理系です。同梱の `README` には、1992 年の
Release 3.6 を 64 ビットの Linux で動くように更新したもの、と書かれています。

MIT の配布元 (`pmg.csail.mit.edu/ftpdir/pclu/`) は現在 HTTP 403 で取れません。そこで、
この PCLU に「32 ビットと 64 ビットの取り違え」の修正などを加えて公開している
**nbuwe/pclu** (<https://github.com/nbuwe/pclu>、本家は <https://hg.sr.ht/~nbuwe/pclu>) を
使っています。タグ付きのリリースが無いため、`Dockerfile` では 2024 年 10 月 15 日時点の
コミット (`1a8ad76`) を固定し、SHA-256 を確かめてからビルドしています。

PCLU はガベージコレクタに Boehm GC を使い、その内部ヘッダも読みます。そのため GC も
ソースからビルドします。PCLU に同梱されていた gc-7.2 系は aarch64 に対応していないので、
aarch64 に対応した **gc-8.2.8** (<https://github.com/ivmai/bdwgc>) を使っています。
これで Apple container の arm64 環境でそのまま動きます。

`clu` は、`pclu` での変換・コンパイル、`plink` でのリンク、実行をまとめたスクリプトです。
作業ファイル (`.c` / `.o` / 実行ファイル) は一時ディレクトリに作るので、`demo/` には
何も残りません。

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/complex.clu` | 動画の `complex_number = cluster is ...` と `rep = record [real_part: real, imag_part: real]`。内部の持ち方を隠し、操作だけを外に見せる |
| `demo/iter.clu` | `iter ... yields` で書いたイテレータ 2 つ (偶数と、フィボナッチ数列) を `for` で回す |
| `demo/signals.clu` | `signals` で宣言した例外を呼び出し側の `except when` で受ける。組み込みの `int$parse` の `bad_format` も受ける |
| `clu` | 変換・コンパイル・リンク・実行をまとめたスクリプト (イメージの `/usr/local/bin/clu` に入る) |

## 実行結果

```
$ clu complex.clu
x + y = 2.0 + 3.0i
x - y = 1.0 + 1.0i

$ clu iter.clu
evens: 2 4 6 8 10
fib: 0 1 1 2 3 5 8 13 21 34

$ clu signals.clu
average = 6
empty array: signal caught
int$parse: bad_format
```

`complex.clu` の `create` / `add` などは、引数や戻り値の型に `cvt` を書いています。
cluster の外から見ると `complex_number` 型、中では `rep` (record) として扱う、という
切り替えを表す書き方です。外の `start_up` からは `real_part` に直接触れません。

## つまずきやすい点

**動画では「処理系は入手困難」と紹介しましたが、この環境では動きます。** MIT の配布元が
取れないのは動画の時点と同じです。上に書いたとおり、有志が 64 ビット向けに直したソースと、
新しい GC を組み合わせることでビルドできました。

**`real$unparse` は指数表記になります。** `real$unparse(2.0)` は `2.000000e+00` を返します。
デモでは `f_form(x, 1, 1)` (整数部 1 桁以上・小数部 1 桁) で書式を決めています。

**`pclu` は毎回、経過を表示します。** `Optimizing ...` と `time = ...` の行です。`clu` では
これを隠し、コンパイルエラーのときだけ表示します。エラーのときは、たとえば次のように
行番号付きで出ます。

```
bad.clu:2: error: object assigned to 'x' of wrong type
	expected type: int
	actual type: string
```

**`start_up` が入口です。** C の `main` にあたる手続きの名前は `start_up = proc ()` と
決まっています。

## ライセンス

`demo/` のコードと `clu` は自由に使ってください。

PCLU は 1995 年の MIT の著作権表示 (`COPYRIGHT`) のもとで配布されていて、この表示と
許諾文を残すこと、MIT の名前を宣伝に使わないことなどを条件に、無償での使用・複製・
改変・配布が認められています。Boehm GC は、著作権表示を残すことを条件に、どんな目的でも使用・複製してよいとされています (配布物の `README.QUICK`
による)。このリポジトリには処理系そのものは含めず、`Dockerfile` が配布元から取ってきます。
