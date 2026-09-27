# Miranda の実験環境 (2026-09-03 「古今東西 プログラミング言語紹介」)
#
# 処理系は Miranda 2.068。2020 年に BSD ライセンス (2 条項) で公開されたソースを、
# いまの保守先 Codeberg (DATurner/miranda) のリリースから取ってきてビルドする。
# SHA-256 はリリースノートに載っている値。Debian にはパッケージが無い。
FROM debian:trixie-slim AS build

ARG MIRANDA_VERSION=2.068
ARG MIRANDA_SHA256=102a7d7cce1a6ff304aac552e7783f1d20201cacdb04489461e1db8bc794a2df

RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates curl gcc libc6-dev make \
    && rm -rf /var/lib/apt/lists/*

# Makefile の既定どおり最適化なしでビルドする。ガーベジコレクタが C のスタックを
# 走査する作りなので、最適化をかけると壊れることがあると README に書かれている。
RUN curl -fsSL -o /tmp/miranda.tar.gz \
        "https://codeberg.org/DATurner/miranda/releases/download/miranda-${MIRANDA_VERSION}/miranda-${MIRANDA_VERSION}.tar.gz" \
    && echo "${MIRANDA_SHA256}  /tmp/miranda.tar.gz" | sha256sum -c - \
    && tar xzf /tmp/miranda.tar.gz -C /tmp \
    && cd /tmp/miranda-${MIRANDA_VERSION} \
    && mkdir -p /usr/local/share/man/man1 \
    && make install

FROM debian:trixie-slim
COPY --from=build /usr/local/bin/mira /usr/local/bin/mira
COPY --from=build /usr/local/lib/miralib /usr/local/lib/miralib

# デモのコメントが日本語なので、UTF-8 ロケールにしておく。
ENV LANG=C.UTF-8

WORKDIR /work
CMD ["mira"]
