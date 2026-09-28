# Pascal の実験環境 (2026-08-13 「古今東西 プログラミング言語紹介」)
#
# 処理系は Free Pascal (fpc)。trixie の apt で入る。
# コンパイラモード ({$mode iso} / {$mode tp} / {$mode objfpc} / {$mode delphi}) を
# 切り替えると、標準 Pascal・Turbo Pascal・Delphi の方言をひとつの処理系で試せる。
FROM debian:trixie-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
        fp-compiler \
    && rm -rf /var/lib/apt/lists/*

# demo/ はホストと共有しているので、.o / .ppu / 実行ファイルは /build に出す。
RUN mkdir /build

WORKDIR /work
CMD ["bash"]
