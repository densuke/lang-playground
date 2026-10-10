# JOSS の実験環境 (2026-10-20 「古今東西 プログラミング言語紹介」)
#
# 1963 年の JOSS 本体 (JOHNNIAC 上) はいま動かせない。ここで動かすのは
# James Haggerty の TypeScript 製再実装 wryun/joss-language (MIT)。
# IBM System/360 版の方言 MATH(JOSS) の参考書に基づく作りかけで、RAND の JOSS そのものではない。
# リポジトリを特定のコミットに固定して取り込む。
FROM oven/bun:1.3.14-alpine@sha256:5acc90a93e91ff07bf72aa90a7c9f0fa189765aec90b47bdbf2152d2196383c0

# main の最新 (2025-08-03 "claude: add docs")。
ARG JOSS_COMMIT=acad0c05aee113940e7b86b1616012b16cb381ca
RUN wget -q -O /tmp/joss.tgz "https://codeload.github.com/wryun/joss-language/tar.gz/${JOSS_COMMIT}" \
    && tar xzf /tmp/joss.tgz -C /opt \
    && rm /tmp/joss.tgz \
    && mv "/opt/joss-language-${JOSS_COMMIT}" /opt/joss

# 再実装は対話ループを持たない (ライブラリとテストだけ) ので、
# 標準入力を 1 行ずつ eval するだけの入口 (repl.ts) を別に置く。
COPY repl.ts /opt/repl.ts
RUN printf '#!/bin/sh\nexec bun /opt/repl.ts\n' > /usr/local/bin/joss \
    && chmod 755 /usr/local/bin/joss

WORKDIR /work
CMD ["sh"]
