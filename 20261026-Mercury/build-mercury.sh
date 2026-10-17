#!/usr/bin/env bash
# Mercury 22.01.9 をソースからビルドし、build/mercury-prefix.tar.gz を作る。
# 公式の Debian パッケージは amd64/i386 のみ (arm64 なし) なので自前ビルドする。
# 重いので builder (共有) は使わず、通常のコンテナ (メモリ 8G) の中でビルドする。
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
mkdir -p "$here/build"
container run --rm -m 8G -c 8 -v "$here/build:/out" \
    debian:trixie-slim@sha256:a99cfc517144bc59b1978475ec53b46ecabec7e43635402ee5b77cc54cd1b20a \
    bash -euxc '
apt-get update
apt-get install -y --no-install-recommends build-essential ca-certificates curl \
    libreadline-dev flex bison
cd /tmp
curl -fsSLO http://dl.mercurylang.org/release/mercury-srcdist-22.01.9.tar.gz
echo "35f10827c42f70c39d84e2948b378da10671f6ac41a7dddffdb7b1abb06d6f10bd02e24d0ad781cc4b75839aa23017af0137d2d20fe8df7c4ebb48b76586241b  mercury-srcdist-22.01.9.tar.gz" | sha512sum -c -
tar xzf mercury-srcdist-22.01.9.tar.gz
cd mercury-srcdist-22.01.9
./configure --prefix=/opt/mercury --disable-java-grades --disable-csharp-grades --disable-erlang-grades
make -j8 PARALLEL=-j8
make install PARALLEL=-j8
tar czf /out/mercury-prefix.tar.gz -C /opt mercury
'
