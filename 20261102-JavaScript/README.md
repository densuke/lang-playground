# JavaScript を試す (2026-11-02)

「古今東西 プログラミング言語紹介」2026-11-02 回の実験環境です。

```bash
./run.sh                          # シェルに入る (node で対話環境)
./run.sh node /work/hello.mjs     # 直接動かす
./run.sh bash -s < demo.sh        # 全部を順に実行する
```

処理系は公式 node イメージの Node.js 24.22.1 (`node:24.22.1-trixie-slim`、digest 固定)。
2026-10-24 時点で nodejs.org のダウンロードページが LTS として案内している版です。
npm の依存は使わず、Node.js 標準だけで動きます。初回のイメージ取得は数分、2 回目以降のビルドは数秒です。

| ファイル | 内容 |
|---|---|
| `demo/hello.mjs` | 第一級関数とクロージャ (カウンタ、`compose`、`var` と `let`) |
| `demo/proto.mjs` | プロトタイプ連鎖、`class` は prototype の上の書き方 |
| `demo/eventloop.mjs` | イベントループの実行順 (同期、マイクロタスク、`setTimeout`) |
| `demo/coercion.mjs` | 型変換の癖 (`typeof null`、`==`、`sort`、`parseInt`、BigInt) |

`setTimeout(0)` と `setImmediate` の順序は、メインモジュールからは実行ごとに変わりうる (Node.js の仕様)。
このため `eventloop.mjs` では `setImmediate` を使っていません。
