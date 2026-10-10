# Java の実験環境 (2026-10-19 「古今東西 プログラミング言語紹介」practical 枠)
#
# 処理系は Eclipse Temurin (Adoptium の OpenJDK ビルド) の 25.0.4.1+1 = 最新の LTS (Java 25)。
# 最新の機能リリース JDK 27 (2026-09-15 GA) は非 LTS。デモが使う record・switch のパターンマッチ・
# 単一ファイル実行・`void main()` (JEP 512) はいずれも Java 25 で正式機能。
# タグ 25.0.4.1_1-jdk の manifest list を digest で固定する (2026-10-10 確認)。
FROM eclipse-temurin:25.0.4.1_1-jdk@sha256:8c0a84ea11c8f6ed52600fc19f1040121f2a162998e9f50a5faebbbad9172dcc AS base

# jshell の初回起動時に出る「preferences directory を作った」INFO を、収録の画に出さないよう先に作っておく。
RUN mkdir -p /root/.java/.userPrefs \
    && chmod 700 /root/.java/.userPrefs

WORKDIR /work
CMD ["bash"]
