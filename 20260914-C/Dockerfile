# C の実験環境 (2026-09-14 「古今東西 プログラミング言語紹介」)
#
# 処理系は GCC。trixie の apt で入る。build-essential (make など) までは要らないので、
# コンパイラ本体の gcc と、標準ライブラリのヘッダの libc6-dev だけを入れている。
FROM debian:trixie-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
        gcc libc6-dev \
    && rm -rf /var/lib/apt/lists/*

# demo/ はホストと共有しているので、実行ファイルは /build に出す。
RUN mkdir /build

WORKDIR /work
CMD ["bash"]
