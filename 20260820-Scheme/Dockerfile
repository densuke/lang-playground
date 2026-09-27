# Scheme の実験環境 (2026-08-20 「古今東西 プログラミング言語紹介」)
#
# 処理系は動画で紹介した Gauche (gosh)。trixie の apt に 0.9.15 がある。
FROM debian:trixie-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
        gauche \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /work
CMD ["gosh"]
