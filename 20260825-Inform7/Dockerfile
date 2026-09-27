# Inform 7 の実験環境 (2026-08-25 「古今東西 プログラミング言語紹介」)
#
# 処理系は Inform 10.1.2 (Inform 7 言語の処理系の最新リリース, 2022-08-31)。
# 公式の配布物は GUI アプリ (macOS dmg / Linux deb・rpm・Flatpak) だけで、
# deb / rpm は amd64 のみ。そこで公式 README の Build Instructions どおり、
# inweb / intest / inform の 3 つのリリースをソースからビルドする。
# Debian の inform パッケージは Inform 6 (別の言語) なので使わない。
#
# できたゲームは、inform のテスト用に同梱されている glulxe (cheapglk 版。
# 画面制御を使わない文字だけの版) で動かす。
FROM debian:trixie-slim AS build

ARG INFORM_VERSION=10.1.2
ARG INFORM_SHA256=145cae27638c2dde4979f37b67d60de3243f6ee6456b808426fb9dcbda850dd0
ARG INWEB_VERSION=7.2.0
ARG INWEB_SHA256=0fa772ed3b2e7c7242be6dbfad319bc213f49881eba56549248f90ea1a47fbcf
ARG INTEST_VERSION=2.1.0
ARG INTEST_SHA256=3a5c86005212b3aa68064e133abed54529a83c7c6963a845afadbcc7db1d647e

# clang が必須。gcc だけだと inweb の first.sh が失敗する。
RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates curl clang make \
    && rm -rf /var/lib/apt/lists/*

# 3 つは同じディレクトリに inweb / intest / inform という名前で並べる決まり。
WORKDIR /build
RUN fetch() { \
        curl -fsSL -o "/tmp/$1.tar.gz" "https://github.com/ganelson/$1/archive/refs/tags/v$2.tar.gz" \
        && echo "$3  /tmp/$1.tar.gz" | sha256sum -c - \
        && mkdir "$1" && tar xzf "/tmp/$1.tar.gz" -C "$1" --strip-components=1; } \
    && fetch inweb "$INWEB_VERSION" "$INWEB_SHA256" \
    && fetch intest "$INTEST_VERSION" "$INTEST_SHA256" \
    && fetch inform "$INFORM_VERSION" "$INFORM_SHA256"

# first.sh は同じ名前でも呼び方が違う。inweb / intest は親から、引数に linux。
# inform は自分の中から引数なし。最後の段で glulxe などの解釈系もできる。
RUN bash inweb/scripts/first.sh linux \
    && bash intest/scripts/first.sh linux \
    && cd inform && bash scripts/first.sh

FROM debian:trixie-slim
COPY --from=build /build/inform/inform7/Tangled/inform7 /opt/inform/inform7
COPY --from=build /build/inform/inform7/Internal /opt/inform/Internal
COPY --from=build /build/inform/inform6/Tangled/inform6 /opt/inform/inform6
COPY --from=build /build/inform/inform6/Tests/Assistants/dumb-glulx/glulxe/glulxe /opt/inform/glulxe
COPY i7 /usr/local/bin/i7

WORKDIR /work
CMD ["bash"]
