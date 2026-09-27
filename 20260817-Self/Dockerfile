# Self の実験環境 (2026-08-17 「古今東西 プログラミング言語紹介」)
#
# 処理系は公式の Self 2024.1 (https://github.com/russellallen/self)。
# Self の VM は 32 ビットの x86 (i386) 専用で、実行時に i386 の機械語を作る。
# arm64 の Mac では、Rosetta も 32 ビットの x86 は動かせない。そこで
#   1. ビルド段は linux/386 のイメージで VM をソースからビルドし (ビルダーが
#      エミュレーションで動かす)、画面なし (-o none) の Self の世界を組み立てて
#      スナップショットに保存する
#   2. 実行段は arm64 のイメージに qemu-user を入れ、i386 の VM を
#      qemu-i386 で動かす
# という 2 段構えにしている。X11 は使わない (-DSELF_X11=OFF)。
FROM --platform=linux/386 debian:trixie-slim AS build

ARG SELF_VERSION=2024.1
ARG SELF_SHA256=6703a0453f9df0411282965561113d726ba24f5b39450871fe225a67e5a2b615

RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates curl cmake g++ make pkg-config libncurses-dev \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL -o /tmp/self.tar.gz \
        "https://github.com/russellallen/self/archive/refs/tags/${SELF_VERSION}.tar.gz" \
    && echo "${SELF_SHA256}  /tmp/self.tar.gz" | sha256sum -c - \
    && mkdir /opt/self && tar xzf /tmp/self.tar.gz -C /opt/self --strip-components=1

# エミュレーションでのビルドなので 10 分ほどかかる。
WORKDIR /opt/self/build
RUN cmake -DSELF_X11=OFF .. && make -j2

# 世界 (オブジェクトの集まり) をソースから組み立てて保存する。
# -o none で GUI (Morphic / UI1) を読み込まない。組み立て後のプロンプトに
# saveAs: と _Quit を流し込んで、スナップショットを書かせて終わらせる。
WORKDIR /opt/self/objects
RUN printf "saveAs: '/opt/self/world.snap'\n_Quit\n" \
        | ../build/vm/Self -f worldBuilder.self -o none > /tmp/world.log 2>&1 \
    ; tail -5 /tmp/world.log && test -s /opt/self/world.snap

FROM debian:trixie-slim
RUN dpkg --add-architecture i386 \
    && apt-get update && apt-get install -y --no-install-recommends \
        qemu-user libc6:i386 libstdc++6:i386 libncurses6:i386 \
    && rm -rf /var/lib/apt/lists/*
COPY --from=build /opt/self/build/vm/Self /opt/self/Self
COPY --from=build /opt/self/world.snap /opt/self/world.snap
COPY self /usr/local/bin/self

WORKDIR /work
CMD ["bash"]
