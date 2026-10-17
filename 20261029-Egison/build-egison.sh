#!/usr/bin/env bash
# Egison 5.1.0 を Hackage の sdist からビルドし、build/ に bin と share (組み込みライブラリ) を出す。
# 公式の配布物はソースの tarball のみ (Releases にバイナリなし)。GHC でのビルドは重いので
# builder (共有) は使わず、通常のコンテナ (メモリ 8G) の中でビルドする。
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
mkdir -p "$here/build"
container run --rm -m 8G -c 4 -v "$here/build:/out" -v "$here/dist:/dist:ro" \
    docker.io/library/haskell:9.10.1-bullseye@sha256:87b1db498a795e08ac4861dfe1bbd2b2a8d4d7fbcf1b97933085db2d822ec3e9 \
    bash -euxc '
mkdir /src && tar xzf /dist/egison-5.1.0.tar.gz -C /src
cd /src/egison-5.1.0
cabal update
cabal install . --installdir=/out/bin --install-method=copy --overwrite-policy=always \
    --jobs=2 --ghc-options="-O1 +RTS -M6g -RTS"
d="$(find / -type d -path "*egison-5.1.0/lib/core" -not -path "/src/*" -not -path "/proc/*" 2>/dev/null | head -1)"
rm -rf /out/share && cp -r "$(dirname "$(dirname "$d")")" /out/share
ls -la /out/bin /out/share
'
