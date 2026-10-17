# Linda の実験環境 (2026-10-27 「古今東西 プログラミング言語紹介」)
#
# 処理系は Fred Youhanaie 作の Erlang 実装 espace (Apache-2.0) の v0.9.0 タグ。
# out / in / rd / eval / inp / rdp の 6 操作が揃っている現役の Linda 実装。
# ビルドは Erlang/OTP 27 の通常イメージ (rebar3 入り)、実行は slim に成果物だけ移す。
FROM erlang:27.3.4.19@sha256:b944db88c674b941248f67562c6e7d56972d6ad9663876ff5ddeafebd8f28e35 AS build

WORKDIR /src
RUN <<'EOF'
    set -eu
    git clone --quiet https://github.com/fredyouhanaie/espace.git .
    git checkout --quiet v0.9.0
    rebar3 compile
EOF

FROM erlang:27.3.4.19-slim@sha256:e672f86167feb3947b3330a05ec5cb7fca75cd2a720411e47444b1abda4c332e AS base

COPY --from=build /src/_build/default/lib /opt/espace/lib
ENV ERL_LIBS=/opt/espace/lib
ENV LANG=C.UTF-8
WORKDIR /work
CMD ["bash"]
