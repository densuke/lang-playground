# BASIC の実験環境 (2026-10-07 「古今東西 プログラミング言語紹介」)
#
# 処理系は Bywater BASIC (bwBASIC)。Debian の apt で入る。
# 行番号つきの古典的な書き方をそのまま動かせる。
FROM debian:trixie-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
        bwbasic \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /work
CMD ["bwbasic"]
