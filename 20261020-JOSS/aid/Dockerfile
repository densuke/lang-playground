# JOSS の末裔 AID を、PDP-10 エミュレータ simh 上の TOPS-10 で動かす環境 (2026-10-20 回)
#
# simh は open-simh のコミットを固定してソースからビルドする (pdp10-ka だけ)。
# TOPS-10 のディスクと AID のテープは版権物なのでイメージに入れない。run.sh が取得して実行時に渡す。
FROM debian:bookworm-slim@sha256:7c7b2c966bc9ee8cedfeef67e0e279108992c77681fa595db4a9d65c06ccc587 AS build

# 2026-10-10 時点の master
ARG SIMH_COMMIT=87eb7d5e96f9ce0ee6ac183e20160e5c486b0712
# hadolint ignore=DL3008
RUN <<'EOS'
    set -eu
    apt-get update
    apt-get install -y --no-install-recommends build-essential ca-certificates curl
    rm -rf /var/lib/apt/lists/*
    curl -fsSL -o /tmp/simh.tgz "https://codeload.github.com/open-simh/simh/tar.gz/${SIMH_COMMIT}"
    tar xzf /tmp/simh.tgz -C /tmp
    make -C "/tmp/simh-${SIMH_COMMIT}" pdp10-ka
    install -m 755 "/tmp/simh-${SIMH_COMMIT}/BIN/pdp10-ka" /usr/local/bin/pdp10-ka
EOS


FROM debian:bookworm-slim@sha256:7c7b2c966bc9ee8cedfeef67e0e279108992c77681fa595db4a9d65c06ccc587
# unzip bzip2 は版権物の展開、telnet と expect は、起動した TOPS-10 へ非対話でログインして流すために使う
# hadolint ignore=DL3008
RUN <<'EOS'
    set -eu
    apt-get update
    apt-get install -y --no-install-recommends bzip2 expect telnet unzip
    rm -rf /var/lib/apt/lists/*
EOS

COPY --from=build /usr/local/bin/pdp10-ka /usr/local/bin/pdp10-ka
COPY ini /opt/ini
COPY bin/ /usr/local/bin/

WORKDIR /work
CMD ["aid-session"]
