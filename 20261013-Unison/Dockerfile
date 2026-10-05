# Unison の実験環境 (2026-10-13 「古今東西 プログラミング言語紹介」)
#
# 処理系は本家 (unisonweb/unison) の公式リリースの ucm (Unison Codebase Manager)。
# linux-arm64 / linux-x64 のバイナリが配られているので、アーキテクチャに合わせて落とす。
FROM debian:trixie-slim

ARG UCM_VERSION=1.5.0

RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates curl tar \
    && rm -rf /var/lib/apt/lists/*

RUN <<EOS
    set -eu
    case "$(uname -m)" in
        aarch64|arm64) arch=arm64 ;;
        x86_64) arch=x64 ;;
        *) echo "unsupported arch" >&2; exit 1 ;;
    esac
    mkdir -p /opt/ucm
    curl -fsSL "https://github.com/unisonweb/unison/releases/download/release%2F${UCM_VERSION}/ucm-linux-${arch}.tar.gz" \
        | tar -xz -C /opt/ucm
    ln -s /opt/ucm/ucm /usr/local/bin/ucm
EOS

WORKDIR /work
CMD ["ucm"]
