# Alloy の実験環境 (2026-11-05 「古今東西 プログラミング言語紹介」)
#
# Alloy 6.2.0 (2026-10-24 時点の最新リリース、2025-01-09) の配布 jar を sha256 固定で取り込み、
# 公式 Temurin JRE 21 (digest 固定) で動かす。GUI は使わず CLI (exec サブコマンド) だけ。
FROM eclipse-temurin:21-jre-noble@sha256:35501d3f93173b420ac9001658eb68157e813316b865087e345c187fca422c4c AS base

ADD --checksum=sha256:6b8c1cb5bc93bedfc7c61435c4e1ab6e688a242dc702a394628d9a9801edb78d \
    https://github.com/AlloyTools/org.alloytools.alloy/releases/download/v6.2.0/org.alloytools.alloy.dist.jar /opt/alloy.jar
COPY alloy /usr/local/bin/alloy

WORKDIR /work
CMD ["bash"]
