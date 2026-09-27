# CLU の実験環境 (2026-09-08 「古今東西 プログラミング言語紹介」)
#
# 処理系は MIT の Portable CLU (PCLU) 3.7。MIT の配布元 (pmg.csail.mit.edu) は
# 現在 403 で取れないので、そのソースに 64 ビット向けの修正を加えて公開している
# nbuwe/pclu (GitHub。本家は https://hg.sr.ht/~nbuwe/pclu) の 2024-10-15 時点の
# コミットを固定して使う。タグ付きのリリースは無い。
#
# PCLU は CLU を C に変換して cc でコンパイルする。ガベージコレクタに Boehm GC を
# 使い、その内部ヘッダも読むので、GC もソースからビルドする。PCLU 同梱だった
# gc-7.2 系は aarch64 に対応していないので、aarch64 に対応した gc-8.2.8 を使う。
FROM debian:trixie-slim AS build

ARG PCLU_COMMIT=1a8ad7603ea20b9744942182a52810441182f6a6
ARG PCLU_SHA256=5c7c8d1e88c2e2d03d43e167db3ceb1fa96a3315b3e4b48e02b2133635db57e1
ARG GC_VERSION=8.2.8
ARG GC_SHA256=7649020621cb26325e1fb5c8742590d92fb48ce5c259b502faf7d9fb5dabb160

RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates curl gcc libc6-dev make \
    && rm -rf /var/lib/apt/lists/*

ENV CLUHOME=/opt/pclu

RUN curl -fsSL -o /tmp/pclu.tar.gz \
        "https://github.com/nbuwe/pclu/archive/${PCLU_COMMIT}.tar.gz" \
    && echo "${PCLU_SHA256}  /tmp/pclu.tar.gz" | sha256sum -c - \
    && curl -fsSL -o /tmp/gc.tar.gz \
        "https://github.com/ivmai/bdwgc/releases/download/v${GC_VERSION}/gc-${GC_VERSION}.tar.gz" \
    && echo "${GC_SHA256}  /tmp/gc.tar.gz" | sha256sum -c - \
    && tar xzf /tmp/pclu.tar.gz -C /tmp \
    && mv /tmp/pclu-${PCLU_COMMIT} ${CLUHOME} \
    && tar xzf /tmp/gc.tar.gz -C /tmp

# GC は PCLU の README の手順どおり、スレッド無しの静的ライブラリにして
# $CLUHOME/code/gc に入れる。PCLU が読む内部ヘッダ (private/) も一緒に置く。
RUN cd /tmp/gc-${GC_VERSION} \
    && ./configure --enable-static=yes --enable-shared=no --enable-threads=no \
        --with-libatomic-ops=none --prefix=${CLUHOME}/code/gc \
    && make \
    && make install \
    && mkdir -p ${CLUHOME}/code/gc/include/gc/private \
    && cp include/private/*.h ${CLUHOME}/code/gc/include/gc/private/

# README.md の手順: ランタイム → 同梱の C から作るコンパイラ → CLU ライブラリ。
# include/ ディレクトリはリポジトリに入っていないので先に作る。
RUN cd ${CLUHOME} \
    && mkdir -p include \
    && make symlinks \
    && (cd code && make OPT_FLAGS='-O2') \
    && (cd code/cmp && make OPT_FLAGS='-O2') \
    && (cd lib && make libs)

# pclu が出した C を cc でコンパイル・リンクするので、実行用イメージにも gcc が要る。
FROM debian:trixie-slim
RUN apt-get update && apt-get install -y --no-install-recommends \
        gcc libc6-dev \
    && rm -rf /var/lib/apt/lists/*
ENV CLUHOME=/opt/pclu
COPY --from=build /opt/pclu /opt/pclu
COPY clu /usr/local/bin/clu
WORKDIR /work
CMD ["bash"]
