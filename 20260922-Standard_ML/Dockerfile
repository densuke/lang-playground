# Standard ML の実験環境 (2026-09-22 「古今東西 プログラミング言語紹介」)
#
# 処理系は Poly/ML。対話環境で式を打つと型が表示されるので、型推論を見るのに向く。
# trixie には polyml が無いので bookworm を使う (2026-09 時点)。
FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
        polyml \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /work
CMD ["poly"]
