# Coq / Rocq の実験環境 (2026-11-12 「古今東西 プログラミング言語紹介」)
#
# 公式の rocq/rocq-prover イメージは amd64 のみ (arm64 なし) のため使わない。
# Debian に opam で Rocq 9.3.0 をソースからビルドして入れる。
#   - rocq-runtime / rocq-core 9.3.0 (2026-09-19 リリース)
#   - rocq-stdlib 9.2.0 (2026-10-31 時点の最新。stdlib の 9.3 系はまだ無い)
# opam-repository は commit 固定の tarball (sha256 検証) を使うので、再現できる。
FROM debian:trixie-slim@sha256:62bd423aeee912639ca8ee681c2b762cb3e25137e0a92b20be455898a9f034ad AS base

ARG OPAM_REPO_COMMIT=a1f0fcbd9384bce190ac51678bf1c2637a6a5cf4
ARG OPAM_REPO_SHA256=26a7a4218e7375a68da3b3213a556883a9c5e6957b71acb91e6d8b0486888e60

RUN <<'SH'
    set -eux
    apt-get update
    apt-get install -y --no-install-recommends \
        ca-certificates curl build-essential git unzip rsync m4 pkg-config \
        opam ocaml-nox libgmp-dev linux-libc-dev
    rm -rf /var/lib/apt/lists/*
SH

RUN <<'SH'
    set -eux
    curl -fsSL -o /tmp/repo.tgz "https://github.com/ocaml/opam-repository/archive/${OPAM_REPO_COMMIT}.tar.gz"
    echo "${OPAM_REPO_SHA256}  /tmp/repo.tgz" | sha256sum -c -
    mkdir -p /opt/opam-repository
    tar -xzf /tmp/repo.tgz -C /opt/opam-repository --strip-components=1
    rm /tmp/repo.tgz
    opam init --bare --disable-sandboxing --no-setup -y default /opt/opam-repository
    opam switch create default ocaml-system -y
    opam install -y -j2 rocq-runtime.9.3.0 rocq-core.9.3.0 rocq-stdlib.9.2.0
    opam clean -a -c -s --logs -y
SH

ENV PATH=/root/.opam/default/bin:$PATH \
    OPAMYES=1

WORKDIR /work
CMD ["bash"]
