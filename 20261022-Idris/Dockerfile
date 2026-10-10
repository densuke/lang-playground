# Idris 2 の実験環境 (2026-10-22 「古今東西 プログラミング言語紹介」)
#
# Idris 2 は apt に無いので、公式のソースタグ v0.8.0 を Chez Scheme でブートストラップして入れる。
# Chez Scheme は Debian trixie の apt (10.0.0) を使う。
FROM debian:trixie-slim@sha256:a99cfc517144bc59b1978475ec53b46ecabec7e43635402ee5b77cc54cd1b20a AS build

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
ARG IDRIS2_VERSION=v0.8.0
# hadolint ignore=DL3008,DL3003
RUN <<'EOS'
    set -eux
    apt-get update
    apt-get install -y --no-install-recommends \
        build-essential ca-certificates curl chezscheme libgmp-dev
    rm -rf /var/lib/apt/lists/*
    curl -fsSL "https://github.com/idris-lang/Idris2/archive/refs/tags/${IDRIS2_VERSION}.tar.gz" | tar xz -C /opt
    cd "/opt/Idris2-${IDRIS2_VERSION#v}"
    make bootstrap SCHEME=chezscheme PREFIX=/opt/idris2
    make install PREFIX=/opt/idris2
EOS

FROM debian:trixie-slim@sha256:a99cfc517144bc59b1978475ec53b46ecabec7e43635402ee5b77cc54cd1b20a AS runtime

# hadolint ignore=DL3008
RUN apt-get update \
    && apt-get install -y --no-install-recommends chezscheme libgmp10 \
    && rm -rf /var/lib/apt/lists/*

COPY --from=build /opt/idris2 /opt/idris2
ENV PATH="/opt/idris2/bin:${PATH}"

WORKDIR /work
CMD ["bash"]
