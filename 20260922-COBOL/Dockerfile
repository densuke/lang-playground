# COBOL の実験環境 (2026-09-22 「古今東西 プログラミング言語紹介」パイロット版)
#
# 処理系は GnuCOBOL。trixie の apt で入る。
FROM debian:trixie-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
        gnucobol \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /work
CMD ["bash"]
