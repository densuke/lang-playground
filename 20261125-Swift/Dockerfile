# Swift の実験環境 (2026-11-25 「古今東西 プログラミング言語紹介」)
#
# 公式イメージ swift (Docker Official Image) の trixie 版 (Debian 13、コンパイラ入り) を使う。arm64 / amd64 の両方が配られている。
# Swift 6.4.2 (2026-10-29 リリース、2026-11-14 時点の最新)。マニフェスト (index) の digest で固定する。
FROM swift:6.4.2-trixie@sha256:9733821cc4c736ac43a2b400b2bd08aa54fc7d98c9f58270a7392d7623430097 AS runtime

ENV LANG=C.UTF-8
WORKDIR /work
CMD ["bash"]
