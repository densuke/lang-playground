# Prolog の実験環境 (2026-07-14 「古今東西 プログラミング言語紹介」)
#
# 処理系は SWI-Prolog。swi-prolog-nox は X11 (GUIツール類) を含まない分、
# 公式 swipl イメージより軽い。
FROM debian:trixie-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
        swi-prolog-nox locales \
    && rm -rf /var/lib/apt/lists/* \
    && sed -i '/en_US.UTF-8/s/^# //' /etc/locale.gen && locale-gen

# ソース中のコメントが日本語なので、UTF-8 ロケールが無いと
# "Illegal multibyte Sequence" 警告と文字化けが起きる。
ENV LANG=en_US.UTF-8

WORKDIR /work
CMD ["swipl"]
