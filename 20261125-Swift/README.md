# Swift を試す (2026-11-25)

「古今東西 プログラミング言語紹介」2026-11-25 回の実験環境です。

## 使い方

```bash
./run.sh                                                  # 対話シェル (bash) に入る
./run.sh swiftc -swift-version 6 -o /tmp/hello /work/hello.swift   # コンパイルして /tmp に作る
./run.sh bash -s < demo.sh                                # 全部を順に実行する
./run.sh bash -c 'swiftc -swift-version 6 -o /tmp/o /work/optional.swift && /tmp/o'   # 1 本だけ動かす
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。
`demo/` が `/work` に入ります。イメージは展開すると約 4 GB あるので、初回は取得と展開に数分かかります。
`-swift-version 6` を付けると Swift 6 言語モード (データ競合検査がコンパイルエラー) になります。

## 処理系について

公式イメージ `swift:6.4.2-trixie` (Swift 6.4.2、2026-10-29 リリース。Apache-2.0 + Runtime Library Exception) を、
マニフェストの digest で固定して使います。arm64 / amd64 の両方が配られています。
無印の `swift:6.4.2` は Ubuntu 26.04 ベースなので、他の回と OS を合わせて trixie 版にしています。

**Linux 上なので、Apple のフレームワーク (SwiftUI・UIKit・AppKit など) は使えません。**
Apple のプラットフォームには Objective-C ランタイムがあり、それらのフレームワークはそれに依存します (swift.org の説明)。
ここで動くのは標準ライブラリと、移植版の Foundation などです。画面を作る話は実演できません。

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/hello.swift` | Hello World。Linux 上であることを表示 |
| `demo/optional.swift` | Optional、`if let`、`guard let`、`??`、`?.` |
| `demo/enum_switch.swift` | enum の関連値と switch、範囲パターン、ガード |
| `demo/value_types.swift` | struct のコピーと class の共有、配列の値型 |
| `demo/bounds_trap.swift` | 配列の範囲外アクセスで実行が止まる。**異常終了する (実行時)** |
| `demo/missing_case.swift` | switch の網羅漏れ。**コンパイルエラーになる** |
| `demo/force_optional.swift` | Optional を Int として使う。**コンパイルエラーになる** |
| `demo/data_race.swift` | 複数タスクから var を書き換える。**Swift 6 モードでコンパイルエラーになる** |
| `demo/actor_ok.swift` | actor で `data_race.swift` を直した例 |
