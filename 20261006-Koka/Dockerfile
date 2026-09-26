# Koka の実験環境 (2026-10-06 「古今東西 プログラミング言語紹介」)
#
# 処理系は本家の公式リリース (koka-lang/koka) を install.sh で入れる。
# Koka は C へ変換してから gcc でネイティブコードにするので、C コンパイラが要る。
FROM debian:trixie-slim

ARG KOKA_VERSION=v3.2.9

RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates curl build-essential cmake ninja-build pkg-config tar \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sSL "https://github.com/koka-lang/koka/releases/download/${KOKA_VERSION}/install.sh" \
        | sh -s -- -f --version=${KOKA_VERSION}

WORKDIR /work
CMD ["koka"]
