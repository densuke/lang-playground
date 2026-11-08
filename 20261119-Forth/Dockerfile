# Forth の実験環境 (2026-11-19 「古今東西 プログラミング言語紹介」)
#
# 処理系は Gforth 1.0.0 (GNU Forth。ANS Forth / Forth 2012 に沿う)。
# 公式配布物 (net2o.de/gforth-dist/Snapshots/1.0.0/gforth-1.0.0.tar.xz) をソースからビルドする。sha256 を検証する。
# Debian trixie の apt には gforth が無い (sid / forky は 0.7.3+dfsg-10)。arm64 / amd64 のどちらでも動く。
FROM debian:trixie-slim@sha256:a99cfc517144bc59b1978475ec53b46ecabec7e43635402ee5b77cc54cd1b20a AS build

ARG GFORTH_VERSION=1.0.0
ARG GFORTH_SHA256=79c880b68a4a9aa817b7067c21b79acd5b07149fad78f3f630320db410886fa6

# hadolint ignore=DL3003,DL3008,DL4006
RUN <<'SH'
    set -eux
    apt-get update
    apt-get install -y --no-install-recommends \
        gcc libc6-dev make m4 libtool libtool-bin libffi-dev libltdl-dev xz-utils curl ca-certificates
    cd /tmp
    curl -fsSLO "https://net2o.de/gforth-dist/Snapshots/${GFORTH_VERSION}/gforth-${GFORTH_VERSION}.tar.xz"
    echo "${GFORTH_SHA256}  gforth-${GFORTH_VERSION}.tar.xz" | sha256sum -c -
    tar xJf "gforth-${GFORTH_VERSION}.tar.xz"
    cd "gforth-${GFORTH_VERSION}"
    ./configure --prefix=/usr/local CFLAGS="-O1"
    make
    make install
SH

FROM debian:trixie-slim@sha256:a99cfc517144bc59b1978475ec53b46ecabec7e43635402ee5b77cc54cd1b20a AS runtime

# gforth の C FFI (libcc) が実行時に gcc を呼ぶので、gcc は残す。
# hadolint ignore=DL3008
RUN apt-get update \
    && apt-get install -y --no-install-recommends gcc libc6-dev make libffi8 libltdl7 libtool-bin \
    && rm -rf /var/lib/apt/lists/*
COPY --from=build /usr/local /usr/local

ENV LANG=C.UTF-8
WORKDIR /work
CMD ["gforth"]
