# Lazy K の実験環境 (2026-11-20 「古今東西 プログラミング言語紹介」esolang 枠)
#
# 処理系は作者 Ben Rudiak-Gould 自身の lazy.cpp (インタプリタ) と lazier.scm (ラムダ式 -> Lazy K)。
# 2002 年の Essies 提出物 (esoteric.sange.fi に原文のまま残る) をビルド時に取得し、
# src/SHA256SUMS で検証する。lazy.cpp / lazier.scm は「Distributed under the GPL」(版の指定なし) で、
# 例題 (eg/*) には許諾の記述が無いので、このリポジトリには同梱せずビルド時の取得にしている。
# lazy.cpp は Windows 専用の io.h を読むため、src/lazy.patch (POSIX 化の最小修正) を当てる。
# prelude.scm / lazier.scm は Guile 3 向けに () を '() に直す (下の sed)。
FROM debian:trixie-slim@sha256:a99cfc517144bc59b1978475ec53b46ecabec7e43635402ee5b77cc54cd1b20a AS build

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
# hadolint ignore=DL3008
RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates curl g++ patch \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/lazyk
COPY src/SHA256SUMS src/lazy.patch /opt/lazyk/
RUN <<'EOF'
    set -eu
    base=https://esoteric.sange.fi/essie2/download/lazy-k
    mkdir -p eg
    while read -r _ f; do
        curl -fsSL --retry 3 -o "$f" "$base/$f"
    done < SHA256SUMS
    sha256sum -c SHA256SUMS
    patch lazy.cpp < lazy.patch
    # Guile 3 は評価される () を構文エラーにする。prelude.scm と lazier.scm の () を '() に直す (lazier.scm は 2 箇所)
    sed -i "s/^(lazy-def ()/(lazy-def '()/" prelude.scm
    sed -i "s/(bound ())/(bound '())/;176s/()/'()/" lazier.scm
    g++ -O2 -o lazy lazy.cpp
EOF

FROM debian:trixie-slim@sha256:a99cfc517144bc59b1978475ec53b46ecabec7e43635402ee5b77cc54cd1b20a AS runtime

RUN apt-get update && apt-get install -y --no-install-recommends \
        guile-3.0=3.0.10* \
    && rm -rf /var/lib/apt/lists/*

COPY --from=build /opt/lazyk /opt/lazyk
RUN ln -s /opt/lazyk/lazy /usr/local/bin/lazy

ENV LANG=C.UTF-8
WORKDIR /work
CMD ["bash"]
