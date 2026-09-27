# Unlambda の実験環境 (2026-08-28 「古今東西 プログラミング言語紹介」・難解言語枠)
#
# 処理系は Debian の unlambda パッケージ (Ørjan Johansen 氏らによる Haskell 実装, GPL-2+)。
# 継続を扱う c や遅延の d は挙動が繊細で、自作の処理系は静かに間違うので、
# 自作はせずにパッケージをそのまま使う。
FROM debian:trixie-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
        unlambda \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /work
CMD ["sh"]
