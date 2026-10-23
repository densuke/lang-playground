# ALGOL 60 の実験環境 (2026-11-03 「古今東西 プログラミング言語紹介」)
#
# 処理系は GNU MARST 2.8 (ALGOL 60 -> C 変換器)。ソース配布 (marst-2.8.tar.gz) を
# ビルドして使う。sha256 を検証する。生成した C は gcc でコンパイルして実行する。
FROM debian:trixie-slim@sha256:a99cfc517144bc59b1978475ec53b46ecabec7e43635402ee5b77cc54cd1b20a AS build
RUN apt-get update && apt-get install -y --no-install-recommends gcc libc6-dev make \
    && rm -rf /var/lib/apt/lists/*
COPY marst-2.8.tar.gz /src/
WORKDIR /src
RUN <<'SH'
    set -eu
    echo "d77f4703b0b44b50be57908f9d556ee6c3bedd97d638c42949d6aec84f8070ba  marst-2.8.tar.gz" | sha256sum -c -
    tar xzf marst-2.8.tar.gz
    cd marst-2.8
    ./configure --prefix=/opt/marst
    make -j2
    make install
SH

FROM debian:trixie-slim@sha256:a99cfc517144bc59b1978475ec53b46ecabec7e43635402ee5b77cc54cd1b20a AS base
RUN apt-get update && apt-get install -y --no-install-recommends gcc libc6-dev \
    && rm -rf /var/lib/apt/lists/*
COPY --from=build /opt/marst /opt/marst
COPY alg /usr/local/bin/alg
ENV PATH=/opt/marst/bin:$PATH LD_LIBRARY_PATH=/opt/marst/lib LANG=C.UTF-8
WORKDIR /work
CMD ["bash"]
