# Simula の実験環境 (2026-11-17 「古今東西 プログラミング言語紹介」)
#
# 処理系は GNU Cim 5.1 (Simula 67 のコンパイラ。Simula を C に変換し、C コンパイラへ渡す)。
# 公式配布物 (ftp.gnu.org/gnu/cim/cim-5.1.tar.gz、2014-05-18) をソースからビルドする。sha256 を検証する。
# Debian には現行の cim パッケージが無い (woody の 3.36 が最後)。arm64 / amd64 のどちらでも動く。
FROM debian:trixie-slim AS runtime

ARG CIM_VERSION=5.1
ARG CIM_SHA256=b90717b66ec400503bdd69e537e8b7f3e8a9d106c3ba9a08a04ae57369a069a9

# cim は実行時にも C コンパイラを呼ぶので、gcc は残す。
# hadolint ignore=DL3003,DL3008,DL4006
RUN <<'SH'
    set -eux
    apt-get update
    apt-get install -y --no-install-recommends gcc libc6-dev make curl ca-certificates
    cd /tmp
    curl -fsSLO "https://ftp.gnu.org/gnu/cim/cim-${CIM_VERSION}.tar.gz"
    echo "${CIM_SHA256}  cim-${CIM_VERSION}.tar.gz" | sha256sum -c -
    tar xzf "cim-${CIM_VERSION}.tar.gz"
    cd "cim-${CIM_VERSION}"
    # 2014 年の C なので、新しい gcc の既定 (C23 / 厳格な警告) を古い方言に戻す。
    # 同梱の事前生成 C (simset.c / simulation.c) は別ディレクトリ前提の include パスを持つので直す。
    sed -i 's|#include "../../lib/cim.h"|#include "cim.h"|' lib/simset.c lib/simulation.c
    ./configure CFLAGS="-O2 -std=gnu89 -w" --disable-nls
    make
    make install
    ldconfig
    cd /
    rm -rf /tmp/cim-* /var/lib/apt/lists/*
    apt-get purge -y curl
    apt-get autoremove -y
SH

ENV LANG=C.UTF-8
WORKDIR /work
CMD ["bash"]
