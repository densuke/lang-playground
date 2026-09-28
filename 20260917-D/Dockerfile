# D の実験環境 (2026-09-17 「古今東西 プログラミング言語紹介」)
#
# 処理系は LDC (LLVM ベースの D コンパイラ)。trixie の apt で入る。
# 動画で案内した DMD は arm64 向けのビルドが無く、Debian にもパッケージが無いので使わない。
# LDC に付いてくる ldmd2 は dmd と同じオプションを受け付ける (dmd -run の代わりになる)。
#
# ldc だけではリンクで止まるので、2 つ足している。
#   gcc        ... ldc2 はリンクを cc に任せる (無いと cannot find program `cc`)
#   libc6-dev  ... -lrt -ldl -lpthread -lm を解決する
FROM debian:trixie-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
        ldc gcc libc6-dev \
    && rm -rf /var/lib/apt/lists/*

# demo/ はホストと共有しているので、.o / 実行ファイルは /build に出す。
RUN mkdir /build

WORKDIR /work
CMD ["bash"]
