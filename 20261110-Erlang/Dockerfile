# Erlang の実験環境 (2026-11-10 「古今東西 プログラミング言語紹介」)
#
# 公式イメージ erlang (Docker Official Image) の slim 版を使う。arm64 / amd64 の両方が配られている。
# Erlang/OTP 29.1.2 (2026-10-14 リリース、2026-10-31 時点の最新)。マニフェスト (index) の digest で固定する。
FROM erlang:29.1.2-slim@sha256:813a6c5508c5f7a52cca23a44b1858e717ff94f84ff5cebedaf1a304bdc63fdd AS runtime

ENV LANG=C.UTF-8
WORKDIR /work
CMD ["erl"]
