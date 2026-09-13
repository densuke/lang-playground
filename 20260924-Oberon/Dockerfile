# Oberon の実験環境 (2026-09-24 「古今東西 プログラミング言語紹介」)
#
# 処理系は Vishap Oberon Compiler (voc)。Oberon-07 / Oberon-2 を C 経由でコンパイルする。
# Wirth 本人の Project Oberon はシステムごと動かす形なので、言語だけ試すには voc が早い。
FROM debian:trixie-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential ca-certificates git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt
RUN git clone --depth=1 https://github.com/vishaps/voc.git \
    && cd voc \
    && make full

ENV PATH="/opt/voc/install/bin:${PATH}"
ENV LD_LIBRARY_PATH="/opt/voc/install/lib"
WORKDIR /work
CMD ["/bin/bash"]
