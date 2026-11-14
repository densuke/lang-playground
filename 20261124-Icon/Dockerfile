# Icon の実験環境 (2026-11-24 「古今東西 プログラミング言語紹介」)
#
# 処理系は Arizona 大学の Icon 9.5.25a (2025-09-07)。公式のソースは GitHub (gtownsend/icon) で管理されている。
# タグ v9.5.25a のアーカイブを取得し、sha256 を検証してソースからビルドする (public domain)。
# Debian trixie の icon パッケージは 9.5.24b、sid は 9.5.25a。ここでは公式の最新タグをビルドする。
# arm64 / amd64 のどちらでも動く (グラフィックスなしの linux 構成)。
FROM debian:trixie-slim@sha256:a99cfc517144bc59b1978475ec53b46ecabec7e43635402ee5b77cc54cd1b20a AS build

ARG ICON_TAG=v9.5.25a
ARG ICON_SHA256=ab15b7fc5a96e8b4da1b76cc6c7935400879f8a54b0fcf94a947c02815f21006

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
# hadolint ignore=DL3003,DL3008
RUN <<'SH'
    set -eux
    apt-get update
    apt-get install -y --no-install-recommends gcc libc6-dev make curl ca-certificates
    cd /tmp
    curl -fsSL -o icon.tgz "https://github.com/gtownsend/icon/archive/refs/tags/${ICON_TAG}.tar.gz"
    echo "${ICON_SHA256}  icon.tgz" | sha256sum -c -
    tar xzf icon.tgz
    cd icon-*
    make Configure name=linux
    make
    make Install dest=/opt/icon
SH

FROM debian:trixie-slim@sha256:a99cfc517144bc59b1978475ec53b46ecabec7e43635402ee5b77cc54cd1b20a AS runtime
COPY --from=build /opt/icon /opt/icon
ENV PATH=/opt/icon/bin:$PATH
ENV LANG=C.UTF-8
WORKDIR /work
CMD ["bash"]
