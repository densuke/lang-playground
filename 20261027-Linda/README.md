# Linda を試す (2026-10-27)

「古今東西 プログラミング言語紹介」2026-10-27 回の実験環境です。

Linda は単体の言語ではなく、C や Fortran などのホスト言語に足す「協調言語」です。
ここでは Fred Youhanaie による Erlang 実装 [espace](https://github.com/fredyouhanaie/espace)
(Apache-2.0、v0.9.0) を使い、タプル空間と `out` / `in` / `rd` / `eval` (と非ブロック版の `inp` / `rdp`) を動かします。
Erlang のタプルを Linda のタプルとして扱い、パターンの `'$1'` `'$2'` が「?x」にあたります。

```bash
./run.sh                       # シェルに入る (erl で対話環境)
./run.sh sh /work/demo.sh      # 収録用デモ (3 本を順に流す)
./run.sh sh /work/demo.sh hello      # 1 本だけ (hello / prodcons / taskbag)
```

処理系は Erlang/OTP 27.3.4.19 (digest 固定、linux/arm64) と espace v0.9.0。

| ファイル | 内容 |
|---|---|
| `demo/hello.erl` | out / rd / in / rdp / eval を 1 つずつ |
| `demo/prodcons.erl` | 消費者を先に起こす。`in` がタプルを待って止まり、4 秒後の `out` で動き出す (経過ミリ秒つき) |
| `demo/taskbag.erl` | 仕事袋 (bag of tasks)。3 人のワーカーが `inp` で仕事を取り合い、親が `in` で結果を集める |
| `rec-run.sh` / `rec-feature.sh` | 動画用の端末収録 (asciinema)。`./run.sh bash -c "$(cat rec-run.sh)"` の形で流す |

## 文字化けについて

コンテナの `LANG` が `C` のままだと、日本語が `\x{3092}` のように化けます。Dockerfile で `LANG=C.UTF-8` を設定済みです。
