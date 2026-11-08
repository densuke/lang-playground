# Bash の実験環境 (2026-11-18 「古今東西 プログラミング言語紹介」)
#
# 公式イメージ bash (Docker Official Image) を使う。arm64 / amd64 の両方が配られている。
# Bash 5.3 (パッチレベル 20、イメージ 5.3.20 は 2026-11-05 公開)。マニフェスト (index) の digest で固定する。
FROM bash:5.3.20@sha256:bfe8f6d356f2944ec5ad456e44620924862263aa0717036b3c2cdce0ee4c0af0 AS runtime

ENV LANG=C.UTF-8
WORKDIR /work
CMD ["bash"]
