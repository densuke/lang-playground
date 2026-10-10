# Iota の実験環境 (2026-10-23 「古今東西 プログラミング言語紹介」esolang 枠)
#
# 処理系は作者 Chris Barker 自身の R5RS Scheme 参照実装 (demo/iota.scm に原文のまま収録)。
# Scheme 処理系には、作者が自分の環境で使った guile を Debian trixie の apt で入れる。
FROM debian:trixie-slim@sha256:a99cfc517144bc59b1978475ec53b46ecabec7e43635402ee5b77cc54cd1b20a AS base

RUN apt-get update && apt-get install -y --no-install-recommends \
        guile-3.0=3.0.10* \
    && rm -rf /var/lib/apt/lists/*

ENV LANG=C.UTF-8
WORKDIR /work
CMD ["bash"]
