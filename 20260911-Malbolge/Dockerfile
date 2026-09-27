# Malbolge の実験環境 (2026-09-11 「古今東西 プログラミング言語紹介」・難解言語枠)
#
# Debian に Malbolge のパッケージは無いので、ファクトチェックのときに仕様
# (https://esolangs.org/wiki/Malbolge) から書いた最小インタプリタ malbolge.c を
# イメージのビルド時にコンパイルする。コンパイラは実行用イメージに残さない。
FROM debian:trixie-slim AS build
RUN apt-get update && apt-get install -y --no-install-recommends \
        gcc libc6-dev \
    && rm -rf /var/lib/apt/lists/*
COPY malbolge.c /src/malbolge.c
RUN gcc -O2 -o /usr/local/bin/malbolge /src/malbolge.c

FROM debian:trixie-slim
COPY --from=build /usr/local/bin/malbolge /usr/local/bin/malbolge
WORKDIR /work
CMD ["sh"]
