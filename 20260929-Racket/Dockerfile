# Racket の実験環境 (2026-09-29 「古今東西 プログラミング言語紹介」)
#
# 処理系は本家 Racket。trixie の apt で入る (8.16)。
# 公式イメージ (racket/racket) もあるが、apt のほうが arm64 で確実に入る。
FROM debian:trixie-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
        racket \
    && rm -rf /var/lib/apt/lists/*

# /work を collection の置き場にする。#lang mylang が /work/mylang/lang/reader.rkt を読む。
ENV PLTCOLLECTS=/work:
WORKDIR /work
CMD ["racket"]
