# Perl の実験環境 (2026-10-14 「古今東西 プログラミング言語紹介」)
#
# Perl 5 は Debian trixie の apt で入る (版は 5.40 系。本家の最新は 5.44.0)。
# perl パッケージはスリムイメージにも perl-base として一部入っているが、
# 標準モジュール一式をそろえるため明示的に入れる。
FROM debian:trixie-slim AS base

RUN apt-get update && apt-get install -y --no-install-recommends \
        perl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /work
CMD ["bash"]
