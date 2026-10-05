# C++ を試す (2026-10-12)

「古今東西 プログラミング言語紹介」2026-10-12 回の実験環境です。

## 使い方

```bash
./run.sh                                                         # シェル (bash) に入る
./run.sh bash -c 'g++ -std=c++23 -o /tmp/a hello.cpp && /tmp/a'  # 直接動かす
./run.sh bash -s < demo.sh                                       # 全部を順に実行する
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。
コンパイラは apt で入るので、初回でも数分で終わります。

## コンパイラについて

Debian trixie の apt が配る **GCC 14.2** (`g++`) です (本家の最新は GCC 16.2)。
`-std=c++23` を付けると C++23 の `std::println` が使えます。

```
$ ./run.sh g++ --version | head -1
g++ (Debian 14.2.0-19) 14.2.0
```

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/hello.cpp` | Hello World。昔からの `std::cout` と C++23 の `std::println` |
| `demo/raii.cpp` | クラスとデストラクタ。ブロックを抜けると片付けが自動で走る (RAII) |
| `demo/template.cpp` | テンプレート・`constexpr`・`static_assert`・ranges のソート |

## 実行結果

```
$ ./run.sh bash -s < demo.sh
g++ (Debian 14.2.0-19) 14.2.0
Hello, world!
Hello, C++23!
開ける: ファイル
開ける: ロック
作業中
閉じる: ロック
おわり
閉じる: ファイル
42 3
1 3 5 8 
fib(40) = 102334155
```

(Apple container は実行のたびに `[0/6] ... Starting container` という進捗を標準エラーへ出します。
上の出力からは省いています。)

## つまずきやすい点

**`-std=c++23` を忘れると `<print>` が使えません。** GCC 14 の既定は C++17 です。

**GCC 14 では `std::println("{}", v)` で `vector` をそのまま出せません。** C++23 の規格には
ある機能ですが、このコンパイラでは `std::formatter must be specialized` というエラーで止まります。
`demo/template.cpp` ではループで 1 つずつ出しています。

**`static_assert` はコンパイル時に検査します。** `fib(10) == 56` に書き換えると、実行する前に
コンパイルが止まります。

**初回の `container build` が通信エラーで止まったら** `container system stop && container system start`
で基盤を再起動してから、もう一度実行してください。

## ライセンス

`demo/` のコードは自由に使ってください。GCC 本体は GPL のオープンソースです (gcc.gnu.org)。
