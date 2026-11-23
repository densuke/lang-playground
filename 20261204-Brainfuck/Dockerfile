# Brainfuck の実験環境 (2026-12-04 「古今東西 プログラミング言語紹介」esolang 枠)
#
# 原典 (Urban Müller の brainfuck-2.lha) は Amiga (m68k) 専用で、配布物にライセンスの記述が無いため、
# 同梱もビルド時取得もしない (参照のみ)。実行は Debian の beef パッケージ (第三者の再実装) を使う。
# 自作の 20 行の処理系 (demo/mini.c) を gcc でビルドして並べるので、gcc も入れる。
FROM debian:trixie-slim@sha256:a99cfc517144bc59b1978475ec53b46ecabec7e43635402ee5b77cc54cd1b20a AS runtime

# hadolint ignore=DL3008
RUN apt-get update && apt-get install -y --no-install-recommends \
        beef gcc libc6-dev \
    && rm -rf /var/lib/apt/lists/*

ENV LANG=C.UTF-8
WORKDIR /work
CMD ["bash"]
