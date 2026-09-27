# Ada を試す (2026-08-24)

「古今東西 プログラミング言語紹介」2026-08-24 回の実験環境です。
動画: <https://www.youtube.com/watch?v=Oi_UrlLSfu8>

## 使い方

```bash
./run.sh                                                  # シェルに入る
./run.sh bash -c 'gnatmake -q -D /build -o /build/hello hello.adb && /build/hello'
./run.sh bash -s < demo.sh                                # 収録と同じ順に全部動かす
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。
処理系は apt で入るので、初回でも数分で終わります。

## 処理系について

Debian trixie の `gnat` パッケージ (GCC の Ada コンパイラ、`gnatmake --version` の表示は
`GNATMAKE 14.2.0`) を使っています。動画で案内した Alire (`alr`) は使っていません。
Linux では apt の `gnat` でもコンパイラが入ります。

Ada は、米国防総省 (DoD) の契約のもと、フランスの CII-Honeywell-Bull で Jean Ichbiah 博士が
率いたチームが設計した言語です。名前は頭字語ではなく、世界初のプログラマとも言われる
Augusta Ada Lovelace にちなみます (<https://www.adaic.org/advantages/ada-overview/>)。
事前条件・事後条件による契約は Ada 2012 で取り入れられた機能で、最新の規格は
Ada 2022 (ISO/IEC 8652:2023) です (<https://www.iso.org/standard/83621.html>)。

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/hello.adb` | Hello World |
| `demo/types.adb` | 範囲付きの型 `Speed_Kmh` / `Temp_C`。範囲を超えると `Constraint_Error` |
| `demo/types_bad.adb` | 速度の変数に温度を入れる。**コンパイルが通らないのが正解** |
| `demo/contract.adb` | Ada 2012 の事前条件 (`Pre`) と事後条件 (`Post`) |

## 実行結果

```
$ gnatmake -q -D /build -o /build/hello hello.adb

$ /build/hello
Hello, World!

$ gnatmake -q -D /build -o /build/types types.adb
types.adb:15:19: warning: value not in range of type "Speed_Kmh" defined at line 5 [enabled by default]
types.adb:15:19: warning: Constraint_Error will be raised at run time [enabled by default]

$ /build/types
Speed: 120 km/h
Temp: 25 C
Constraint_Error: 120 * 3 is out of 0 .. 300

$ gnatmake -q -D /build -o /build/types_bad types_bad.adb
types_bad.adb:11:13: error: expected type "Speed_Kmh" defined at line 4
types_bad.adb:11:13: error: found type "Temp_C" defined at line 5
gnatmake: "types_bad.adb" compilation error

$ gnatmake -q -gnata -D /build -o /build/contract contract.adb

$ /build/contract
10 / 3 = 3
Assertion_Error: precondition B /= 0 failed
```

`types_bad.adb` のエラーが、動画で見せた「速度に温度を入れようとしたら止まる」場面です。
`Speed_Kmh` と `Temp_C` はどちらも整数ですが別の型なので、代入するとコンパイラが止めます。

`types.adb` では `Speed := Speed * 3;` の 360 が `0 .. 300` を超えます。GNAT はコンパイル時に
警告を出し、実行時には `Constraint_Error` が上がります。

## つまずきやすい点

**`demo/` はホストと共有しているので、生成物は `/build` に出しています。** `gnatmake` は
何も指定しないと `.o` / `.ali` / 実行ファイルをカレントディレクトリに作ります。`-D /build` で
中間ファイルを、`-o /build/<名前>` で実行ファイルをコンテナ内の `/build` に置いています。
`/build` はコンテナを抜けると消えます。

**契約は `-gnata` を付けないと検査されません。** GNAT の既定では `Pre` / `Post` は
チェックされず、`contract.adb` を `-gnata` なしでビルドすると `10 / 0` の呼び出しが
事前条件で止まりません。`demo.sh` では `contract.adb` だけ `-gnata` を付けています。

**`'Image` は正の数の先頭に空白を付けます。** `Integer'Image (3)` は `" 3"` です。
`"10 / 3 =" & ...` のように、空白の分を見込んで文字列をつないでいます。

## ライセンス

`demo/` のコードは自由に使ってください。GNAT は GCC の一部です。ライセンスは
<https://gcc.gnu.org/> を参照してください。
