# Ruby を試す (2026-10-28)

「古今東西 プログラミング言語紹介」2026-10-28 回の実験環境です。

```bash
./run.sh                       # シェルに入る (irb で対話環境)
./run.sh ruby /work/hello.rb   # 直接動かす
./run.sh bash -s < demo.sh     # 全部を順に実行する
```

処理系は公式 ruby イメージの 4.0.7 (`ruby:4.0.7-slim-trixie`、digest 固定)。追加の gem は使わず、標準ライブラリだけで動きます。

| ファイル | 内容 |
|---|---|
| `demo/hello.rb` | Hello World と、何でもオブジェクト (`1.class` `5.times`) |
| `demo/blocks.rb` | ブロックとイテレータ (`each` `map` `select` `yield`) |
| `demo/objects.rb` | クラスを開いて足す、`Comparable` |
| `demo/modern.rb` | パターンマッチ、Ractor、JIT の有無 |
