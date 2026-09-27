# PostScript の実験環境 (2026-09-02 「古今東西 プログラミング言語紹介」)
#
# 処理系は Ghostscript。画面を持たないコンテナなので、描画結果は
# txtwrite デバイスで文字として取り出すか、PNG / PDF に書き出して確かめる。
FROM debian:trixie-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
        ghostscript \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /work
CMD ["sh"]
