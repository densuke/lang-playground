# Rust の実験環境 (2026-11-16 「古今東西 プログラミング言語紹介」)
#
# 公式イメージ rust (Docker Official Image) の slim 版 (Debian trixie) を使う。arm64 / amd64 の両方が配られている。
# Rust 1.99.1 (2026-10-15 リリース、2026-11-08 時点の最新安定版)。マニフェスト (index) の digest で固定する。
FROM rust:1.99.1-slim-trixie@sha256:7eab7ce19273ce785e0ca7578bdf7bc1fcbae621775a8197379a04c9f6e03cd5 AS runtime

ENV LANG=C.UTF-8
WORKDIR /work
CMD ["bash"]
