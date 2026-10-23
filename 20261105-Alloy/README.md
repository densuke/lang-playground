# Alloy を試す (2026-11-05)

「古今東西 プログラミング言語紹介」2026-11-05 回の実験環境です。

```bash
./run.sh                          # シェルに入る
./run.sh alloy exec -f -c '*' -t text -o - /work/smallscope.als   # 1 本だけ動かす
./run.sh bash -s < demo.sh        # 全部を順に実行する
```

処理系は Alloy 6.2.0 (2025-01-09、2026-10-24 時点の最新リリース) の配布 jar。GUI は使わず、6.2.0 で加わった CLI (`alloy exec`) で動かします。
jar は sha256 固定でイメージに取り込み、JDK は公式 `eclipse-temurin:21-jre-noble` (digest 固定、arm64) です。

- 初回は Temurin イメージの取得に約 2 分 (全プラットフォーム分を展開するため)、ビルド自体は十数秒。メモリは共有 builder の既定で足りる
- SAT ソルバは SAT4J のみ (linux/aarch64 にネイティブソルバが無い。起動時の `findPlatform unknown Linux aarch64` は無害)
- 時相の完全なモデル検査 (`for 1.. steps`) は NuSMV / nuXmv が要るので入れていない。`N steps` の有界検査だけ

`check` の **SAT は反例が見つかった、UNSAT は範囲内に反例なし**。`run` の SAT は例が見つかった、です。

| ファイル | 内容 |
|---|---|
| `demo/hello.als` | `sig` と関係、`run` で祖父母のいる例を探す |
| `demo/smallscope.als` | small scope hypothesis。偽の主張は反例が出て、真の主張は UNSAT |
| `demo/addressbook.als` | 「追加して削除すれば元に戻る」の反例 (Jackson の本の例を縮めたもの) |
| `demo/temporal.als` | Alloy 6 の時相論理 (`var` `always`)。相互排除の安全性 |
