# Tcl の実験環境 (2026-09-23 「古今東西 プログラミング言語紹介」)
#
# 処理系は Debian の tcl パッケージ (Tcl 8.6 系、tclsh)。
FROM debian:trixie-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
        tcl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /work
CMD ["tclsh"]
