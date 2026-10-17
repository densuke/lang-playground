# Whenever の実験環境 (2026-10-30 「古今東西 プログラミング言語紹介」esolang 枠)
#
# 処理系は itruffat/WheneverEverywhere (Python 製、作者の仕様ページが「Resources」で紹介している実装) を
# コミット固定で使う。独自の処理系は書いていない。
FROM debian:trixie-slim@sha256:a99cfc517144bc59b1978475ec53b46ecabec7e43635402ee5b77cc54cd1b20a AS base

ARG WE_COMMIT=737d928b7b6d9546941d53d4f074b248f4bc8c75

RUN <<EOF
    set -eux
    apt-get update
    apt-get install -y --no-install-recommends \
        ca-certificates=20250419 git=1:2.47.3-0+deb13u1 \
        python3=3.13.5-1 python3-ply=3.11-9
    git init /opt/we
    git -C /opt/we fetch --depth 1 https://github.com/itruffat/WheneverEverywhere.git "$WE_COMMIT"
    git -C /opt/we checkout FETCH_HEAD
    apt-get purge -y git
    apt-get autoremove -y
    rm -rf /var/lib/apt/lists/* /opt/we/.git
EOF

ENV LANG=C.UTF-8 PYTHONPATH=/opt/we/src PYTHONDONTWRITEBYTECODE=1
WORKDIR /work
CMD ["bash"]
