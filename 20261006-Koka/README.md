# Koka を試す (2026-10-06)

「古今東西 プログラミング言語紹介」2026-10-06 回の実験環境です。

## 使い方

```bash
./run.sh                                  # 対話環境 (koka) に入る
./run.sh koka -e /work/hello.kk           # コンパイルして実行する
./run.sh bash /work/demo.sh               # 動画で流した順に実行する
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。
初回のビルドは公式の install.sh で処理系を落とすので数分かかります。

## 処理系について

本家 (koka-lang/koka) の公式リリース **Koka 3.2.9** です。Dockerfile の `KOKA_VERSION` で
版を固定しています。Koka は **C へ変換してから gcc でネイティブコードにする**ため、
イメージには build-essential も入れています。初回の実行はランタイム (kklib) の
ビルドが走るので少し待ちます。

```
$ ./run.sh koka --version --console=raw
Koka 3.2.9, 05:27:12 Sep 18 2026 (ghc release version)
```

対話環境は `./run.sh` だけで入れます (式を入れると、その場でコンパイルして評価します)。

```
$ printf '1+1\n:q\n' | ./run.sh
...
2
```

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/hello.kk` | Hello World・フィボナッチ。再帰関数の型に `div` (停止しないかもしれない) が出る |
| `demo/ask.kk` | 自前のエフェクト `ask` と、差し替え可能な 2 つのハンドラ |
| `demo/perceus.kk` | Perceus。参照が 1 本のリストはセルを再利用して「その場で」更新される |
| `demo/show-reuse.sh` | perceus.kk を C に変換し、再利用のコードが生成されていることを見せる |
| `demo/demo.sh` | 上をまとめて流す |

**ファイル名に注意。** ファイル名がそのままモジュール名になるので、`effect.kk` や
`handler.kk` のように予約語と同じ名前にすると parse error になります。

## 実行結果

```
$ ./run.sh bash /work/demo.sh
Koka 3.2.9, 05:27:12 Sep 18 2026 (ghc release version)
== hello.kk
Hello, world!
fib: 0 1 1 2 3 5 8 13 21 34
== ask.kk
always 10: 20
counter  : 3
== perceus.kk
[2,3,4] ... 要素数 1000000
== show-reuse.sh
    kk_reuse_t _ru_x51 = kk_reuse_null; /*@reuse*/;
    if kk_likely(kk_datatype_ptr_is_unique(xs, _ctx)) {
      _ru_x51 = (kk_datatype_ptr_reuse(xs, _ctx));
    kk_reuse_t _ru_x52 = kk_reuse_null; /*@reuse*/;
```

`ask.kk` の `add-twice` は同じ関数です。**ハンドラを差し替えるだけで**、
「いつも 10」なら 10+10=20、「呼ぶたびに数える」なら 1+2=3 になります。

`show-reuse.sh` の出力は生成された C です。「参照が自分だけ (`is_unique`) なら、
古いセルを新しいセルに使い回す (`reuse`)」という分岐がコンパイラによって
差し込まれています。GC を持たずに、関数型の書き方のままで破壊的更新と同じ速さを出す仕組みです。
