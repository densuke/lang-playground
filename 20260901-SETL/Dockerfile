# SETL の実験環境 (2026-09-01 「古今東西 プログラミング言語紹介」)
#
# 処理系は GNU SETL 8.13.22 (setl.org の公式ソース)。Debian にはパッケージが無い。
# setl.org は MD5 (6fd27f35b2ffa3a97e69a6b9b0dfdfa9) しか公開していないので、
# その MD5 と一致することを確かめた tarball から計算した SHA-256 で固定している。
FROM debian:trixie-slim AS build

ARG SETL_VERSION=8.13.22
ARG SETL_SHA256=ee0475fd7e8f5c728a25db626286a8c8f62ad1751169ffb892170cdde271f207

RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates curl gcc g++ libc6-dev make bison flex m4 perl libgmp-dev \
    && rm -rf /var/lib/apt/lists/*

# 素のままの make は「ビルド用ディレクトリを作るか」などを端末で尋ねてくる。
# ソースディレクトリに config.parms を置くと「ここでビルドする」扱いになり、
# configure_args を渡すと設定の質問も飛ばせる。
RUN curl -fsSL -o /tmp/setl.tgz "https://www.setl.org/setl/setl-${SETL_VERSION}.tgz" \
    && echo "${SETL_SHA256}  /tmp/setl.tgz" | sha256sum -c - \
    && tar xzf /tmp/setl.tgz -C /tmp \
    && cd /tmp/setl-${SETL_VERSION} \
    && touch config.parms \
    && configure_args=--prefix=/usr/local make </dev/null \
    && make install </dev/null

FROM debian:trixie-slim
RUN apt-get update && apt-get install -y --no-install-recommends libgmp10 \
    && rm -rf /var/lib/apt/lists/*
COPY --from=build /usr/local /usr/local

WORKDIR /work
CMD ["bash"]
