# Datalog の実験環境 (2026-11-26 「古今東西 プログラミング言語紹介」)
#
# 処理系は Soufflé 2.5 (2025-03-24 リリース、UPL-1.0)。Datalog を拡張した言語を処理する現役の実装。
# 公式の配布バイナリは x86_64 のみ、Debian にもパッケージが無いので、ソースタグ 2.5 からビルドする (sha256 を検証)。
# demo は解釈実行 (souffle file.dl) だけを使うので、実行側に g++ は入れない。
FROM debian:trixie-slim@sha256:a99cfc517144bc59b1978475ec53b46ecabec7e43635402ee5b77cc54cd1b20a AS build

ARG SOUFFLE_VERSION=2.5
ARG SOUFFLE_SHA256=5d009ad6c74ccec10207d865c059716afac625759bff7c8070e529bd80385067

# hadolint ignore=DL3003,DL3008,DL4006
RUN <<'SH'
    set -eux
    apt-get update
    apt-get install -y --no-install-recommends \
        build-essential cmake bison flex libffi-dev libncurses-dev libsqlite3-dev zlib1g-dev \
        mcpp python3 curl ca-certificates
    cd /tmp
    curl -fsSL -o souffle.tar.gz "https://github.com/souffle-lang/souffle/archive/refs/tags/${SOUFFLE_VERSION}.tar.gz"
    echo "${SOUFFLE_SHA256}  souffle.tar.gz" | sha256sum -c -
    tar xzf souffle.tar.gz
    cmake -S "souffle-${SOUFFLE_VERSION}" -B build \
        -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/opt/souffle \
        -DSOUFFLE_ENABLE_TESTING=OFF -DSOUFFLE_USE_CURSES=OFF -DSOUFFLE_GIT=OFF \
        -DPACKAGE_VERSION=${SOUFFLE_VERSION} -DGIT_PACKAGE_VERSION=${SOUFFLE_VERSION}
    cmake --build build -j1
    cmake --install build
SH

FROM debian:trixie-slim@sha256:a99cfc517144bc59b1978475ec53b46ecabec7e43635402ee5b77cc54cd1b20a AS runtime

# 実行時に souffle が前処理器 mcpp を呼ぶ
# hadolint ignore=DL3008
RUN <<'SH'
    set -eux
    apt-get update
    apt-get install -y --no-install-recommends mcpp libffi8 libsqlite3-0 zlib1g libgomp1 python3
    rm -rf /var/lib/apt/lists/*
SH

COPY --from=build /opt/souffle /opt/souffle
ENV PATH=/opt/souffle/bin:$PATH LANG=C.UTF-8
WORKDIR /work
CMD ["bash"]
