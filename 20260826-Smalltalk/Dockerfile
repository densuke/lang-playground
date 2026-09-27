# Smalltalk の実験環境 (2026-08-26 「古今東西 プログラミング言語紹介」)
#
# 処理系は GNU Smalltalk 3.2.5。動画の「試すなら」で紹介した gst そのもの。
# Debian では bullseye (11) を最後にパッケージが無くなったため、GNU の公式
# リリースのソースからビルドする。Pharo / Squeak は GUI 前提のイメージ環境なので、
# ファイルを渡して文字で結果を見るこの枠には gst のほうが合う。
FROM debian:trixie-slim AS build

ARG GST_VERSION=3.2.5
ARG GST_SHA256=819a15f7ba8a1b55f5f60b9c9a58badd6f6153b3f987b70e7b167e7755d65acc

RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates curl xz-utils gawk zip gcc g++ make pkg-config \
        libffi-dev libltdl-dev libgmp-dev libsigsegv-dev zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# GCC 14 では古い C の書き方がエラー扱いになるので -fpermissive と -std=gnu11 で戻す。
# -fwrapv が無いと、整数のあふれ検査が最適化で消されて 100 factorial が負の数になる。
# GUI (Tk / GTK) と Emacs 連携は使わないので外す。
RUN curl -fsSL -o /tmp/gst.tar.xz \
        "https://ftp.gnu.org/gnu/smalltalk/smalltalk-${GST_VERSION}.tar.xz" \
    && echo "${GST_SHA256}  /tmp/gst.tar.xz" | sha256sum -c - \
    && tar xJf /tmp/gst.tar.xz -C /tmp \
    && cd /tmp/smalltalk-${GST_VERSION} \
    && ./configure --without-emacs --disable-gtk --without-tk \
        CFLAGS="-O2 -fwrapv -fno-strict-aliasing -fpermissive -std=gnu11 -fcommon" \
    && make -j4 \
    && make install

FROM debian:trixie-slim
RUN apt-get update && apt-get install -y --no-install-recommends \
        libffi8 libltdl7 libgmp10 libsigsegv2 zlib1g \
    && rm -rf /var/lib/apt/lists/*
COPY --from=build /usr/local /usr/local
RUN ldconfig

WORKDIR /work
CMD ["gst"]
