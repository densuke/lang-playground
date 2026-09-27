# Logo の実験環境 (2026-08-18 「古今東西 プログラミング言語紹介」)
#
# 処理系は Berkeley Logo (UCBLogo) 6.2.4。
# Debian の ucblogo パッケージは wxWidgets (GUI) 版で、画面の無いコンテナでは
# 起動できない。そのため公式リリースのソースを --disable-wx で文字だけの版に
# ビルドする。タートルの絵は描かれないが、位置と向きは内部で計算される。
FROM debian:trixie-slim AS build

ARG UCBLOGO_VERSION=6.2.4
ARG UCBLOGO_SHA256=668889ab9bfa7e9415e63ac154baba5afaed989df5bc74201b54fcb011df9d06

RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates curl gcc g++ make libncurses-dev \
    && rm -rf /var/lib/apt/lists/*

# GCC 14 では古い C の書き方がエラー扱いになるので -fpermissive で警告に戻す。
# 文書 (texinfo) のビルドは不要なので --disable-docs。
# 画面なし版は描画記録用バッファの大きさ (GR_SIZE) が 1 になっていて、
# forward を 1 回呼ぶだけでヒープを壊して落ちる。他の版と同じ 60000 に直す。
RUN curl -fsSL -o /tmp/ucblogo.tar.gz \
        "https://github.com/jrincayc/ucblogo-code/releases/download/version_${UCBLOGO_VERSION}/ucblogo-${UCBLOGO_VERSION}.tar.gz" \
    && echo "${UCBLOGO_SHA256}  /tmp/ucblogo.tar.gz" | sha256sum -c - \
    && tar xzf /tmp/ucblogo.tar.gz -C /tmp \
    && cd /tmp/ucblogo-${UCBLOGO_VERSION} \
    && sed -i 's/^#define GR_SIZE 1$/#define GR_SIZE 60000/' nographics.h \
    && grep -q '^#define GR_SIZE 60000$' nographics.h \
    && ./configure --disable-wx --disable-docs CFLAGS="-O2 -fpermissive" \
    && make \
    && make install

FROM debian:trixie-slim
COPY --from=build /usr/local/bin/ucblogo /usr/local/bin/ucblogo
COPY --from=build /usr/local/share/ucblogo /usr/local/share/ucblogo

WORKDIR /work
CMD ["ucblogo"]
