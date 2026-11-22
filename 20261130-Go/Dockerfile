# Go の実験環境 (2026-11-30 「古今東西 プログラミング言語紹介」)
#
# 公式イメージ golang (Docker Official Image) の trixie 版 (Debian 13、go コマンド入り) を使う。arm64 / amd64 の両方が配られている。
# Go 1.27.4 (2026-11-10 リリース、2026-11-22 時点の最新)。マニフェスト (index) の digest で固定する。
FROM golang:1.27.4-trixie@sha256:f18c3d73a184fb0582828510722e723b63a93f7188d11dd223d9be6f6880e65d AS runtime

ENV LANG=C.UTF-8
WORKDIR /work
CMD ["bash"]
