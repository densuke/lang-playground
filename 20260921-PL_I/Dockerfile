# PL/I の実験環境 (2026-09-21 「古今東西 プログラミング言語紹介」)
#
# 処理系は動画で紹介した Iron Spring PL/I 1.4.1 (Linux 版)。配布物に入っている
# コンパイラ plic とランタイム libprf.a は 32 ビット x86 (i386) 専用で、コンパイラの
# ソースは公開されていない (ランタイムのソースは同梱されているが i386 向け)。Apple container は arm64 で、--platform linux/amd64 (Rosetta) でも
# 32 ビットの実行ファイルは Exec format error になって動かない。そこで arm64 の
# イメージに qemu-user (qemu-i386) を入れて plic を動かし、i386 向けの ld
# (binutils-i686-linux-gnu) で libc 無しの静的実行ファイルにリンクする。
#
# 配布サイトの HTTPS は自己署名証明書なので HTTP で取ってくる。改ざんされていない
# ことは SHA-256 で確かめる。
FROM debian:trixie-slim AS fetch

ARG PLI_VERSION=1.4.1
ARG PLI_SHA256=1f58a7be72b03158c2e1f97f6faae41a2a60118839c667186199075884e6f878

RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates curl \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL -o /tmp/pli.tgz "http://www.iron-spring.com/pli-${PLI_VERSION}.tgz" \
    && echo "${PLI_SHA256}  /tmp/pli.tgz" | sha256sum -c - \
    && tar xzf /tmp/pli.tgz -C /tmp \
    && mkdir -p /opt/pli/lib \
    && cp /tmp/pli-${PLI_VERSION}/plic /opt/pli/plic \
    && cp /tmp/pli-${PLI_VERSION}/lib/libprf.a /opt/pli/lib/libprf.a \
    && cp /tmp/pli-${PLI_VERSION}/readme_linux.html /tmp/pli-${PLI_VERSION}/lgpl.html /opt/pli/

FROM debian:trixie-slim
RUN apt-get update && apt-get install -y --no-install-recommends \
        qemu-user binutils-i686-linux-gnu \
    && rm -rf /var/lib/apt/lists/*
COPY --from=fetch /opt/pli /opt/pli
COPY pli /usr/local/bin/pli
WORKDIR /work
CMD ["bash"]
