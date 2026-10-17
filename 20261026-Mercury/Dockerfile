# Mercury の実験環境 (2026-10-26 「古今東西 プログラミング言語紹介」)
#
# 公式の Debian パッケージは amd64/i386 のみで arm64 が無い。そこで公式のソース配布
# (mercury-srcdist-22.01.9, sha512 検証付き) を build-mercury.sh でビルドして
# build/mercury-prefix.tar.gz にし、ここで取り込む。
# 重いビルドは共有 builder を使わず、通常のコンテナ (メモリ 8G) の中で行う。
FROM debian:trixie-slim@sha256:a99cfc517144bc59b1978475ec53b46ecabec7e43635402ee5b77cc54cd1b20a AS base

# Mercury のコンパイラは Mercury -> C -> gcc で動くので、実行にも C コンパイラが要る。
RUN apt-get update && apt-get install -y --no-install-recommends \
        gcc=4:14.2.0-1 libc6-dev=2.41-12* make=4.4.1-2 \
    && rm -rf /var/lib/apt/lists/*

ADD build/mercury-prefix.tar.gz /opt/
ENV PATH=/opt/mercury/bin:$PATH \
    LANG=C.UTF-8
WORKDIR /work
CMD ["bash"]
