# C# の実験環境 (2026-11-11 「古今東西 プログラミング言語紹介」)
#
# Microsoft の公式イメージは使わず、Debian に公式 .NET SDK の arm64 tarball を入れる。
# .NET 10.0.403 SDK (2026-10-25 リリース、LTS、C# 14)。tarball は SHA512 で固定する
# (Microsoft の releases.json が公開しているハッシュ。sha256 は公開されていない)。
FROM debian:trixie-slim@sha256:62bd423aeee912639ca8ee681c2b762cb3e25137e0a92b20be455898a9f034ad AS base

ARG DOTNET_SDK_VERSION=10.0.403
ARG DOTNET_SDK_SHA512=0966aa2b70f4677b8319be9df447a78a0dcd6164836425b55a68fd714f4023feb87b4cac21b9a996b79472ad54487cd0adcd2a9dfd570e2b2a1d26423a2baa9b

# .NET の Linux 実行に必要な最小の依存 (ICU・OpenSSL・zlib・libstdc++・証明書)
RUN <<'SH'
    set -eux
    apt-get update
    apt-get install -y --no-install-recommends ca-certificates curl libicu76 libssl3t64 zlib1g libstdc++6
    curl -fsSL -o /tmp/dotnet.tgz "https://builds.dotnet.microsoft.com/dotnet/Sdk/${DOTNET_SDK_VERSION}/dotnet-sdk-${DOTNET_SDK_VERSION}-linux-arm64.tar.gz"
    echo "${DOTNET_SDK_SHA512}  /tmp/dotnet.tgz" | sha512sum -c -
    mkdir -p /usr/share/dotnet
    tar -xzf /tmp/dotnet.tgz -C /usr/share/dotnet
    ln -s /usr/share/dotnet/dotnet /usr/local/bin/dotnet
    rm -rf /tmp/dotnet.tgz /var/lib/apt/lists/*
SH

ENV DOTNET_NOLOGO=1 \
    DOTNET_CLI_TELEMETRY_OPTOUT=1 \
    DOTNET_SKIP_FIRST_TIME_EXPERIENCE=1 \
    DOTNET_GENERATE_ASPNET_CERTIFICATE=false

WORKDIR /work
CMD ["bash"]
