# R の実験環境 (2026-10-21 「古今東西 プログラミング言語紹介」)
#
# rocker/r-ver (R 公式イメージではなく Rocker Project 製) の R 4.6.1 を digest で固定する。
# 追加パッケージは入れない。demo は base R と組み込みデータセット (iris 等) だけで動く。
FROM rocker/r-ver:4.6.1@sha256:4e6e6696ff54a86625c7f80046478e67014a2184e942b85eeff43db7b992d93e AS base

WORKDIR /work
CMD ["bash"]
