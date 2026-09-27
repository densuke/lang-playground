# Ada の実験環境 (2026-08-24 「古今東西 プログラミング言語紹介」)
#
# 処理系は GNAT (GCC の Ada フロントエンド)。trixie の apt で入る。
FROM debian:trixie-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
        gnat \
    && rm -rf /var/lib/apt/lists/*

# demo/ はホストと共有しているので、.o / .ali / 実行ファイルは /build に出す。
RUN mkdir /build

WORKDIR /work
CMD ["bash"]
