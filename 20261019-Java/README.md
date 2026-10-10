# Java を試す (2026-10-19)

「古今東西 プログラミング言語紹介」2026-10-19 回 (practical 枠) の実験環境です。

処理系は Eclipse Temurin (Adoptium の OpenJDK ビルド) の **25.0.4.1+1**、つまり最新の LTS (Java 25) です。
最新の機能リリースは JDK 27 (2026-09-15 GA、非 LTS)。デモが使う record・switch のパターンマッチ・
単一ファイル実行・`void main()` はどれも Java 25 で正式機能なので、LTS の方を選びました。

## 使い方

```bash
./run.sh                                  # シェル (bash) に入る
./run.sh java /work/Hello.java            # 単一ファイル実行 (javac 不要)
./run.sh bash -s < demo.sh                # 全部を順に実行する
./run.sh jshell                           # 対話環境 (REPL) に入る
```

`container` (macOS の Apple container) / `docker` / `podman` のいずれかがあれば動きます。

## demo/ の中身

| ファイル | 内容 |
|---|---|
| `Hello.java` | Hello World。`void main()` と `IO.println` だけ (Java 25) |
| `Shapes.java` | record + sealed + switch のパターンマッチ。取りこぼすとコンパイルエラー |
| `Report.java` | テキストブロックと Stream でログを集計 (Perl 回の report.pl と同じ題材) |
| `Threads.java` | 仮想スレッド 1 万本が各 1 秒眠っても、全体で 1 秒ほど |

`demo.sh` は上の 4 本と、`jshell` の例 (パイプで流し込む) をまとめて実行します。

## 実行結果

```
$ ./run.sh java --version
openjdk 25.0.4.1 2026-08-18 LTS
OpenJDK Runtime Environment Temurin-25.0.4.1+1 (build 25.0.4.1+1-LTS)
OpenJDK 64-Bit Server VM Temurin-25.0.4.1+1 (build 25.0.4.1+1-LTS, mixed mode, sharing)

$ ./run.sh java /work/Hello.java
Hello, world!

$ ./run.sh java /work/Shapes.java
Circle[r=1.5] -> 面積 7.07
Rect[w=3.0, h=4.0] -> 面積 12.00
Triangle[base=6.0, height=2.0] -> 面積 6.00

$ ./run.sh java /work/Report.java
200   3 ***
302   1 *
404   2 **
```

(Apple container は実行のたびに `[6/6] Starting container` という進捗を標準エラーへ出します。省いています。)

## つまずきやすい点

**`void main()` だけで動くのは Java 25 から。** コンパクトソースファイルとインスタンス main メソッドが
Java 25 で正式になった (JEP 512)。古い JDK で同じ書き方を試すと動かない。

**`java Hello.java` は javac を内部で呼ぶ。** class ファイルは作られない。複数ファイルのプロジェクトは
`javac` で普通にコンパイルする。

## ライセンス

`demo/` のコードは自由に使ってください。OpenJDK / Temurin は GPLv2 + Classpath Exception です。
