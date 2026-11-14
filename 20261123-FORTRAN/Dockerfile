# FORTRAN の実験環境 (2026-11-23 「古今東西 プログラミング言語紹介」)
#
# 公式イメージ gcc (Docker Official Image) の trixie 版を使う。gfortran 入り。
# GCC 16.2.0 (2026-08-07 リリース。イメージのタグ更新は 2026-11-09)。マニフェスト (index) の digest で固定する。
FROM gcc:16.2.0-trixie@sha256:b8a42d6804296fbe7a54e17e9d60c3100d9e8dbe7ef88c748cae2ddb00d63ba2 AS runtime

ENV LANG=C.UTF-8
WORKDIR /work
CMD ["bash"]
