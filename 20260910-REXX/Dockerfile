# REXX の実験環境 (2026-09-10 「古今東西 プログラミング言語紹介」)
#
# 処理系は Regina REXX (オープンソースの REXX 実装)。
FROM debian:trixie-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
        regina-rexx locales \
    && rm -rf /var/lib/apt/lists/* \
    && sed -i '/en_US.UTF-8/s/^# //' /etc/locale.gen && locale-gen

# ソースと出力に日本語を含むので、UTF-8 ロケールにしておく。
ENV LANG=en_US.UTF-8

WORKDIR /work
CMD ["sh"]
