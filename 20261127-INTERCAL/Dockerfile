# INTERCAL の実験環境 (2026-11-27 「古今東西 プログラミング言語紹介」esolang 枠)
#
# 処理系は C-INTERCAL (ick) 0.35 (2026-08-13、保守者 Eric S. Raymond)。GitLab の 0.35 タグの
# アーカイブをビルド時に取得し、src/SHA256SUMS で検証してからソースビルドする。
# Debian trixie の apt (intercal 0.30-6) より新しいので、apt は使わない。
# ライセンスは GPL v2 以降 (C スケルトンのみ非 GPL)。リポジトリには同梱せず、ビルド時の取得にしている。
# GitLab のアーカイブは再生成でバイトが変わりうる。sha256 が合わなければビルドは止まる (その場合は SHA256SUMS を更新する)。
FROM debian:trixie-slim@sha256:a99cfc517144bc59b1978475ec53b46ecabec7e43635402ee5b77cc54cd1b20a AS build

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
# hadolint ignore=DL3008
RUN apt-get update && apt-get install -y --no-install-recommends \
        autoconf automake bison ca-certificates curl flex gcc libc6-dev make texinfo \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/src
COPY src/SHA256SUMS /opt/src/
# hadolint ignore=DL3003
RUN <<'EOF'
    set -eu
    curl -fsSL --retry 3 -o intercal-0.35.tar.gz \
        https://gitlab.com/esr/intercal/-/archive/0.35/intercal-0.35.tar.gz
    sha256sum -c SHA256SUMS
    tar xzf intercal-0.35.tar.gz
    cd intercal-0.35/buildaux
    sh regenerate-build-system.sh
    mkdir /tmp/build
    cd /tmp/build
    /opt/src/intercal-0.35/configure --prefix=/opt/ick
    make
    make install
EOF

FROM debian:trixie-slim@sha256:a99cfc517144bc59b1978475ec53b46ecabec7e43635402ee5b77cc54cd1b20a AS runtime

# ick は INTERCAL を C に直して cc で作るので、実行側にも gcc が要る
# hadolint ignore=DL3008
RUN apt-get update && apt-get install -y --no-install-recommends \
        gcc libc6-dev \
    && rm -rf /var/lib/apt/lists/*

COPY --from=build /opt/ick /opt/ick
ENV PATH=/opt/ick/bin:$PATH
ENV LANG=C.UTF-8
WORKDIR /work
CMD ["bash"]
