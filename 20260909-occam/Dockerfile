# occam の実験環境 (2026-09-09 「古今東西 プログラミング言語紹介」)
#
# 処理系はケント大学の KRoC (Kent Retargetable occam Compiler)。GitHub の
# concurrency/kroc の master (2020-03-29 のコミット) をソースからビルドし、
# 実行には KRoC に含まれる Transterpreter (tvm, occam のバイトコード仮想マシン) を使う。
#
# KRoC は 32 ビットの x86 (i386) 向けにしかビルドできない。arm64 の Mac では
# Rosetta も 32 ビットの x86 は動かせない。そこで
#   1. ビルド段は linux/386 のイメージで KRoC を tvm 向けにビルドする
#      (ビルダーがエミュレーションで動かす)
#   2. 実行段は arm64 のイメージに qemu-user を入れ、コンパイラ occ21 と
#      仮想マシン tvm を qemu-i386 で動かす。リンカ plinker.pl は Perl なので
#      arm64 の perl でそのまま動かす
# という 2 段構えにしている。
#
# ビルド段は Debian 11 (bullseye) を使う。KRoC のビルドは Python 2 を前提にしていて、
# trixie には Python 2 が無いため。bullseye はサポートが終わって archive.debian.org に
# 移っている。Docker Hub の bullseye イメージはセキュリティ更新済みの libc6 / perl-base を
# 含み、archive の main にある版と合わないので、archive の版に入れ直す (--allow-downgrades)。
FROM --platform=linux/386 debian:bullseye-slim AS build

ARG KROC_COMMIT=46760395fa80aff0d320191db0bfe3deaa97f1bf
ARG KROC_SHA256=96f4d8d6b5b0798544a855984760c6b3737fbc34818074322dcebe44ad04277a

RUN echo "deb http://archive.debian.org/debian bullseye main" > /etc/apt/sources.list \
    && apt-get update && apt-get install -y --no-install-recommends --allow-downgrades \
        libc6=2.31-13+deb11u11 perl-base=5.32.1-4+deb11u3 \
        ca-certificates curl gcc libc6-dev make automake autoconf libtool pkg-config \
        gawk perl python2 python-is-python2 xsltproc \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL -o /tmp/kroc.tar.gz "https://github.com/concurrency/kroc/archive/${KROC_COMMIT}.tar.gz" \
    && echo "${KROC_SHA256}  /tmp/kroc.tar.gz" | sha256sum -c - \
    && mkdir /src && tar xzf /tmp/kroc.tar.gz -C /src --strip-components=1

# エミュレーションでのビルドなので、autoreconf / configure / make がそれぞれ 11〜13 分かかる。
# ログは普段は捨て、失敗したときだけ末尾を見せる。
# GCC 10 からは -fno-common が既定になり、occ21 のリンクで大域変数の多重定義エラーに
# なるので -fcommon で元に戻す。
WORKDIR /src
RUN autoreconf -f -i > /tmp/log 2>&1 || { tail -50 /tmp/log; exit 1; }
RUN ./configure --prefix=/opt/kroc --with-toolchain=tvm CFLAGS="-O2 -fcommon" > /tmp/log 2>&1 \
    || { tail -50 /tmp/log; exit 1; }
RUN make > /tmp/log 2>&1 || { tail -50 /tmp/log; exit 1; }
RUN make install > /tmp/log 2>&1 || { tail -50 /tmp/log; exit 1; }

FROM debian:trixie-slim
RUN dpkg --add-architecture i386 \
    && apt-get update && apt-get install -y --no-install-recommends \
        qemu-user perl libc6:i386 \
    && rm -rf /var/lib/apt/lists/*
COPY --from=build /opt/kroc /opt/kroc
COPY occam /usr/local/bin/occam

WORKDIR /work
CMD ["bash"]
