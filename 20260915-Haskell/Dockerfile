# Haskell の実験環境 (2026-09-15 「古今東西 プログラミング言語紹介」)
#
# 処理系は GHC。公式の haskell イメージは Stack/Cabal 込みで 1GB 超えるため、
# ghci と runghc が動けば十分なこの用途では Debian の ghc パッケージを使う方が軽い。
FROM debian:trixie-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
        ghc \
    && rm -rf /var/lib/apt/lists/*

# glibc 組み込みの C.UTF-8 を使う。ロケール生成なしで日本語の出力が文字化けしない。
ENV LANG=C.UTF-8

WORKDIR /work
CMD ["ghci"]
