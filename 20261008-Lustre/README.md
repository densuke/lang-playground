# Lustre を試す (2026-10-08)

「古今東西 プログラミング言語紹介」2026-10-08 回の実験環境です。

## 使い方

```bash
./run.sh                                  # シェルに入る (lv6 が使える)
./run.sh lv6 --version                    # 版の確認
./run.sh bash -c "$(cat demo.sh)"         # 動画で流した順に実行する
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。
初回は opam で処理系と依存をソースからビルドするため時間がかかります。

## 処理系について

Verimag (Grenoble) の **Lustre V6 コンパイラ lv6 6.107.1** です。opam のパッケージ
`lustre-v6` で入れています (ベースイメージは `ocaml/opam:debian-12-ocaml-5.2`)。

- `lv6 file.lus -n ノード名 -exec` … インタプリタとして実行する。入力は標準入力から
  1 時刻ぶんずつ読み、`#outs` の後ろに出力を出す (RIF 形式)
- `lv6 file.lus -n ノード名 -2c` … C コードを生成する。`sh ノード名.sh` でコンパイルできる

### 実行時の注意

- **入力の無いノードを `-exec` すると止まらない。** 読むものが無いので時刻が進み続ける。
  `| head` で切る
- **入力が尽きると `Fatal error: exception End_of_file` で終わる。** 異常ではない。
  見せたくなければ `2>/dev/null`
- `-2c` は生成物をカレントに書く。`/work` を汚さないよう `demo.sh` は `/tmp` で生成している

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/counter.lus` | カウンタ。`->` (初期値) と `pre` (1 つ前の値) の基本 |
| `demo/fib.lus` | フィボナッチ数列をストリームとして出す。入力なし |
| `demo/bad.lus` | 因果ループ (`x = a + x`)。コンパイル時に弾かれる例 |

```lustre
node counter(reset: bool) returns (n: int);
let
  n = 0 -> if reset then 0 else pre(n) + 1;
tel
```

## 実行結果 (2026-09-26)

```
$ ./run.sh bash -c "$(cat demo.sh)"
6.107.1
f #outs 0
f #outs 1
f #outs 2
t #outs 0
f #outs 1
f #outs 2
 #outs 1
 #outs 1
 #outs 2
 #outs 3
 #outs 5
 #outs 8
 #outs 13
 #outs 21
 #outs 34
 #outs 55
Error: in file "/work/bad.lus", line 4, col 4 to 4, token '=':
Error: Dependency loop on x: x->x->x

0
1
0
1
```

上から順に次のとおりです。

1. `lv6 --version`
2. カウンタ。入力 `reset` に `f f f t f f` を与えると `0 1 2 0 1 2`
3. フィボナッチ。先頭 10 時刻ぶん
4. 因果ループのエラー。`x` が自分自身の**現在の値**に依存しているので順序が決まらない。
   `pre(x)` なら通る
5. C を生成してコンパイルした実行ファイルに `f f t f` を与えた結果

生成された C のステップ関数はループを含まない直線的なコードになります (抜粋)。

```c
void counter_counter_step(_boolean reset,_integer *n,counter_counter_ctx_type* ctx){
  Lustre_pre_get(&_split_1,&ctx->Lustre_pre_ctx_tab[0]);
  _split_2 = _split_1 + 1;
   if (reset == _true) {
     _split_3 = 0;
   } else {
     _split_3 = _split_2;
   }
  Lustre_arrow_step(0,_split_3,n,&ctx->Lustre_arrow_ctx_tab[0]);
  Lustre_pre_set(*n,&ctx->Lustre_pre_ctx_tab[0]);
}
```
