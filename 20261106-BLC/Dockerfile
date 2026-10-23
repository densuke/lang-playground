# Binary Lambda Calculus の実験環境 (2026-11-06 「古今東西 プログラミング言語紹介」)
#
# 処理系は John Tromp の IOCCC 2012 受賞作 (Most functional) の tromp.c。
# ioccc-src/winner のコミット 815fa1a6780979a47482234b0c8faf298209e99f に固定し、sha256 を検証してからビルドする。
# 付属データ (uni8.Blc / bf.Blc / hw.bf / primes.blc) も同じコミットのもの。
FROM debian:trixie-slim@sha256:a99cfc517144bc59b1978475ec53b46ecabec7e43635402ee5b77cc54cd1b20a AS base

RUN apt-get update && apt-get install -y --no-install-recommends \
        gcc=4:14.2.0-1 libc6-dev=2.41-12* \
    && rm -rf /var/lib/apt/lists/*

ADD https://raw.githubusercontent.com/ioccc-src/winner/815fa1a6780979a47482234b0c8faf298209e99f/2012/tromp/tromp.c /src/tromp.c
ADD https://raw.githubusercontent.com/ioccc-src/winner/815fa1a6780979a47482234b0c8faf298209e99f/2012/tromp/uni8.Blc /opt/blc/uni8.Blc
ADD https://raw.githubusercontent.com/ioccc-src/winner/815fa1a6780979a47482234b0c8faf298209e99f/2012/tromp/bf.Blc /opt/blc/bf.Blc
ADD https://raw.githubusercontent.com/ioccc-src/winner/815fa1a6780979a47482234b0c8faf298209e99f/2012/tromp/hw.bf /opt/blc/hw.bf
ADD https://raw.githubusercontent.com/ioccc-src/winner/815fa1a6780979a47482234b0c8faf298209e99f/2012/tromp/primes.blc /opt/blc/primes.blc

# 元の Makefile と同じ定義 (64bit: Int=long, X=8, 項領域 A=500000)。警告は古い C の書き方によるもの。
RUN <<'EOF'
    set -e
    cd /src
    sha256sum -c - <<'SUMS'
e9ef6649946a322e58211e63a50c008ddd5eab8ec98aed5c5395ab6f3b0d1d17  /src/tromp.c
2fac7112a26c56e1448ae2d22e562fe63f51be5fe48619ca6631c4af0d9a7aee  /opt/blc/uni8.Blc
c52d86779c88c5538b4de8e21625977a34d0969365b31eec075c95e7ed863df9  /opt/blc/bf.Blc
0e094f858c69a3f92c32bb6f7f78cf3778a7ddfcb2ac67c0d0f6984d9c1520a7  /opt/blc/hw.bf
da5ef72a6c4328033cfdcbcf9e5137d687720dc5ab94fb5e416019becc728b33  /opt/blc/primes.blc
SUMS
    gcc -O3 -w -std=gnu90 -DA=500000 -DInt=long -DX=8 tromp.c -o /usr/local/bin/tromp
EOF

ENV LANG=C.UTF-8
WORKDIR /work
CMD ["bash"]
