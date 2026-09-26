# LISP の実験環境 (2026-10-05 「古今東西 プログラミング言語紹介」)
#
# 原典の LISP は IBM 704 / 7090 の処理系で、手軽に動くものが無い。
# 代わりに Common Lisp の処理系 SBCL を使い、原典に近い書き方
# (car / cdr / cons / cond / 再帰) だけで書いたコードを動かす。
# SBCL は trixie の apt で入る。
FROM debian:trixie-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
        sbcl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /work
CMD ["sbcl", "--noinform"]
