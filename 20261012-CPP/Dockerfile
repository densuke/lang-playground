# C++ の実験環境 (2026-10-12 「古今東西 プログラミング言語紹介」)
#
# コンパイラは Debian trixie の apt が配る GCC (g++) を使う。
# C++23 の std::println も試せる (GCC 14 の libstdc++ が対応)。
FROM debian:trixie-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
        g++ \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /work
CMD ["bash"]
