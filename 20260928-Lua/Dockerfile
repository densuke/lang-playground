# Lua の実験環境 (2026-09-28 「古今東西 プログラミング言語紹介」)
#
# 処理系は本家 PUC-Rio の lua5.4。trixie の apt で入る (5.4.7)。
# LuaJIT や Lua 5.1 系 (Love2D・Neovim が使う) とは細部が違う。
FROM debian:trixie-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
        lua5.4 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /work
CMD ["lua5.4"]
