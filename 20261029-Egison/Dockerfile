# Egison の実験環境 (2026-10-29 「古今東西 プログラミング言語紹介」)
#
# 公式の配布物は Hackage のソース tarball のみ (GitHub Releases にバイナリなし)。
# そこで dist/egison-5.1.0.tar.gz を build-egison.sh でビルドして build/ に bin と share を出し、ここで取り込む。
# GHC のビルドは重いので、共有 builder は使わず通常のコンテナ (メモリ 8G) の中で行う。
FROM debian:trixie-slim@sha256:a99cfc517144bc59b1978475ec53b46ecabec7e43635402ee5b77cc54cd1b20a AS base

# Haskell 製バイナリの実行時依存 (GMP)。
RUN apt-get update && apt-get install -y --no-install-recommends \
        libgmp10=2:6.3.0+dfsg-3 \
    && rm -rf /var/lib/apt/lists/*

COPY build/bin/egison /usr/local/bin/egison
# 組み込みライブラリ (lib/core/*.egi など) の置き場。Cabal の Paths_egison は egison_datadir で上書きできる。
COPY build/share /opt/egison/share
ENV egison_datadir=/opt/egison/share \
    LANG=C.UTF-8
WORKDIR /work
CMD ["bash"]
