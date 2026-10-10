# Iota を試す (2026-10-23)

Iota は Chris Barker (言語学者) が 2001 年ごろに発表した、記号が `*` と `i` の 2 つだけの言語です。
プログラムは `i` か、`*` のあとに Iota のプログラムが 2 つ続くもの。意味は組合せ論理 (S, K) で決まります。

処理系は作者自身の R5RS Scheme 参照実装 (`demo/iota.scm`、原文のまま) を、Debian trixie の
guile 3.0.10 で動かします。Iota には入出力がありません。式の結果は「関数」なので、記号や数に適用して
中身を覗きます。

## 使い方

```bash
./run.sh                       # シェルに入る
./run.sh sh /work/demo.sh      # 収録用デモ (I, K, S, Church 数, Jot)
./run.sh sh /work/loop.sh      # 発散する式 (10 秒で打ち切り)
```

## demo/ の中身

| ファイル | 内容 |
|---|---|
| `iota.scm` | Barker の Iota 参照実装 (原文) + 文字列から読む補助 1 行 |
| `jot.scm` | Barker の Jot 参照実装 (原文) + 補助 1 行 |
| `demo.scm` | I, K, S の確認、組合せ論理から Iota への翻訳器、Church 数の 3 と 2×3、Jot の K と S |
| `loop.sh` | 発散する式 2 つ (Barker の `(SII)(SII)` と Mike Stay の 27 記号) |
| `demo.sh` | `demo.scm` を流す |
