# TypeScript の実験環境 (2026-11-09 「古今東西 プログラミング言語紹介」)
#
# ベースは JavaScript 回 (11-02) と同じ公式 node イメージ 26.12.1 (digest 固定)。
# TypeScript 7.0.2 (Go 製ネイティブ版、npm の typescript) は package-lock.json で
# 版と integrity (sha512) を固定し、npm ci が検証する。ライフサイクルスクリプトは走らせない。
# 型を剥がして実行する node 自身の機能 (type stripping) も demo で使う。
FROM node:26.12.1-trixie-slim@sha256:36793bcbb160a6a16cede1e62b93f84e26b78a972a8a4c0b879c1c12f22761ec AS base

WORKDIR /opt/ts
COPY package.json package-lock.json ./
RUN npm ci --ignore-scripts --no-audit --no-fund

ENV PATH=/opt/ts/node_modules/.bin:$PATH
WORKDIR /work
CMD ["bash"]
