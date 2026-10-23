# PowerShell の実験環境 (2026-11-04 「古今東西 プログラミング言語紹介」)
#
# Microsoft の公式イメージは使わず、Debian に公式 arm64 tarball (GitHub Releases) を入れる。
# PowerShell 7.6.8 (2026-10-22 リリース、2026-10-24 時点の最新安定版)。tarball は SHA256 で固定する。
FROM debian:trixie-slim@sha256:62bd423aeee912639ca8ee681c2b762cb3e25137e0a92b20be455898a9f034ad AS base

ARG PWSH_VERSION=7.6.8
ARG PWSH_SHA256=3179e07fd98f026d39c730ebcb7626d071aac3351b171dda13f9f38d99efcef0

# PowerShell 7 の Linux 実行に必要な最小の依存 (ICU・OpenSSL・zlib・証明書)
RUN <<'SH'
    set -eux
    apt-get update
    apt-get install -y --no-install-recommends ca-certificates curl libicu76 libssl3t64 zlib1g less
    curl -fsSL -o /tmp/pwsh.tgz "https://github.com/PowerShell/PowerShell/releases/download/v${PWSH_VERSION}/powershell-${PWSH_VERSION}-linux-arm64.tar.gz"
    echo "${PWSH_SHA256}  /tmp/pwsh.tgz" | sha256sum -c -
    mkdir -p /opt/microsoft/powershell/7
    tar -xzf /tmp/pwsh.tgz -C /opt/microsoft/powershell/7
    chmod +x /opt/microsoft/powershell/7/pwsh
    ln -s /opt/microsoft/powershell/7/pwsh /usr/local/bin/pwsh
    rm -rf /tmp/pwsh.tgz /var/lib/apt/lists/*
SH

ENV POWERSHELL_TELEMETRY_OPTOUT=1 \
    POWERSHELL_UPDATECHECK=Off \
    DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=0

WORKDIR /work
CMD ["pwsh"]
