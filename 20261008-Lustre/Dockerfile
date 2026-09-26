# Lustre の実験環境 (2026-10-08 「古今東西 プログラミング言語紹介」)
#
# 処理系は Verimag の Lustre V6 (lv6)。opam パッケージ lustre-v6 で入る。
# 生成した C をその場でコンパイルできるよう gcc も入れる。
FROM ocaml/opam:debian-12-ocaml-5.2

RUN opam update && opam install -y lustre-v6 && opam clean -a -c -s --logs

USER root
RUN apt-get update && apt-get install -y --no-install-recommends gcc libc6-dev make \
    && rm -rf /var/lib/apt/lists/*
USER opam
ENV PATH=/home/opam/.opam/5.2/bin:$PATH
WORKDIR /work
CMD ["bash"]
