# PHP を試す (2026-12-02)

「古今東西 プログラミング言語紹介」2026-12-02 回の実験環境です。

## 使い方

```bash
./run.sh                                  # 対話シェル (bash) に入る
./run.sh php -v                           # 版を見る
./run.sh php /work/hello.php              # スクリプトを 1 本動かす
./run.sh bash -s < demo.sh                # 全部を順に実行する
./run.sh php /work/version_check.php      # 手元の版が更新済みかを確かめる
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。
`demo/` が `/work` に入ります。

## 処理系について

公式イメージ `php:8.6.0-cli-trixie` (PHP 8.6.0、2026-11-19 リリース。CLI) を、
マニフェストの digest で固定して使います。PHP 本体のライセンスは PHP License (新しい版は
Modified BSD 相当の version 4) です。

- 公式イメージは設定ファイル (php.ini) を読み込みません (`php --ini` が `(none)` と出ます)。
  `/usr/local/etc/php/` に `php.ini-development` と `php.ini-production` が置かれています
- `php -S` (組み込みの Web サーバー) は開発・デモ用です。**公衆のネットワークでは使わないでください**
  (公式マニュアルの警告)

## 注意: PHP の版を最新に保つ

PHP では 2026 年 10 月と 11 月に、重大 (critical) と評価された脆弱性の修正が相次ぎました。
`demo/version_check.php` は、手元の版が「サポート中の系統の最新の修正版か」を確かめる最小の例です。
表は 2026-11-22 の php.net (supported-versions / releases) から写したもので、
**実際に使うときは必ず https://www.php.net/supported-versions.php と
https://www.php.net/releases/ で最新の表を確かめてください。**
このリポジトリには、脆弱性を突くコードは入れていません。

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/hello.php` | Hello World |
| `demo/index.php` | HTML に PHP を埋め込む (`<?= ?>` と `foreach`)。`php index.php` か `php -S` で動かす |
| `demo/array.php` | 1 つの配列型がリストにも辞書にもなる。型は値と文脈で決まる |
| `demo/version_check.php` | 版の系統と最新の修正版・サポート期限を突き合わせる |
