# Cyclic Tag System の実験環境 (2026-11-13 「古今東西 プログラミング言語紹介」)
#
# 処理系は demo/ct.py (このリポジトリのオリジナル。標準ライブラリのみ・数十行)。
# 第三者コードは使わない (Cyclic Tag / BCT の既存実装は MIT だが、仕様どおり動く自作で足りる)。
FROM debian:trixie-slim@sha256:a99cfc517144bc59b1978475ec53b46ecabec7e43635402ee5b77cc54cd1b20a

RUN apt-get update && apt-get install -y --no-install-recommends \
        python3-minimal \
    && rm -rf /var/lib/apt/lists/*

ENV LANG=C.UTF-8
WORKDIR /work
CMD ["bash"]
