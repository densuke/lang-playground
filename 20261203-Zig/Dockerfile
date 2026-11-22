# Zig の実験環境 (2026-12-03 「古今東西 プログラミング言語紹介」)
#
# 処理系は Zig 0.17.1 (2026-11-02 リリース、MIT)。ziglang.org の公式配布物 (aarch64-linux) を取得し、
# sha256 (index.json の値) と minisign (公式ダウンロードページの公開鍵) の両方で検証する。
# 配布物は展開すれば使える単一ディレクトリなので、ビルドは要らない。
FROM debian:trixie-slim@sha256:a99cfc517144bc59b1978475ec53b46ecabec7e43635402ee5b77cc54cd1b20a AS fetch

ARG ZIG_VERSION=0.17.1
ARG ZIG_SHA256=a1546d5646eb184437918d6635ca6b762a0e889eac09cef720ee7a1ed3fe7795
ARG ZIG_MINISIGN_KEY=RWSGOq2NVecA2UPNdBUZykf1CCb147pkmdtYxgb3Ti+JO/wCYvhbAb/U

# hadolint ignore=DL3003,DL3008,DL4006
RUN <<'SH'
    set -eux
    apt-get update
    apt-get install -y --no-install-recommends curl ca-certificates xz-utils minisign
    cd /tmp
    base="https://ziglang.org/download/${ZIG_VERSION}/zig-aarch64-linux-${ZIG_VERSION}.tar.xz"
    curl -fsSL -o zig.tar.xz "${base}"
    curl -fsSL -o zig.tar.xz.minisig "${base}.minisig"
    echo "${ZIG_SHA256}  zig.tar.xz" | sha256sum -c -
    minisign -V -P "${ZIG_MINISIGN_KEY}" -m zig.tar.xz -x zig.tar.xz.minisig
    mkdir /opt/zig
    tar -xJf zig.tar.xz -C /opt/zig --strip-components=1
SH

FROM debian:trixie-slim@sha256:a99cfc517144bc59b1978475ec53b46ecabec7e43635402ee5b77cc54cd1b20a AS runtime

# 生成物の形式を見せるのに file を使う
# hadolint ignore=DL3008
RUN <<'SH'
    set -eux
    apt-get update
    apt-get install -y --no-install-recommends file
    rm -rf /var/lib/apt/lists/*
SH

COPY --from=fetch /opt/zig /opt/zig
ENV PATH=/opt/zig:$PATH LANG=C.UTF-8 ZIG_GLOBAL_CACHE_DIR=/tmp/zig-cache ZIG_LOCAL_CACHE_DIR=/tmp/zig-local
WORKDIR /work
CMD ["bash"]
