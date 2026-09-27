# 文言 (wenyan-lang) の実験環境 (2026-09-04 「古今東西 プログラミング言語紹介」)
#
# 処理系は公式の npm パッケージ @wenyan/cli 0.3.4 (公式リポジトリの README が
# 案内している導入方法)。Debian には無いので、Debian の nodejs / npm の上に入れる。
# パッケージの tarball は SHA-256 を確かめてから入れる。依存パッケージ
# (xmlhttprequest) は npm がレジストリから取り、npm 自身の完全性検査に任せる。
FROM debian:trixie-slim

ARG WENYAN_VERSION=0.3.4
ARG WENYAN_SHA256=84ef489c9831f8014c4b2f40fc263a57d6b3c2259a10c0e0ef3213fe9cf9ae42

RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates curl nodejs npm \
    && rm -rf /var/lib/apt/lists/* \
    && curl -fsSL -o /tmp/wenyan-cli.tgz \
        "https://registry.npmjs.org/@wenyan/cli/-/cli-${WENYAN_VERSION}.tgz" \
    && echo "${WENYAN_SHA256}  /tmp/wenyan-cli.tgz" | sha256sum -c - \
    && npm install -g --no-audit --no-fund /tmp/wenyan-cli.tgz \
    && rm -rf /tmp/wenyan-cli.tgz /root/.npm

# ソースもコンパイル結果も漢字なので、UTF-8 ロケールにしておく。
# C.UTF-8 は Debian の libc に最初から入っている。
ENV LANG=C.UTF-8

WORKDIR /work
CMD ["bash"]
