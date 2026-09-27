# Eiffel の実験環境 (2026-08-19 「古今東西 プログラミング言語紹介」)
#
# 処理系は動画で紹介した EiffelStudio 25.12 (Eiffel Software 公式)。
# ftp.eiffel.com で linux-arm64 版のビルド済みアーカイブが登録なしで配られて
# いるので、それを SHA-256 を確かめて展開する。GUI は使わず、コマンドラインの
# コンパイラ ec だけを使う (ec 自体が GTK 3 にリンクされているので、その
# ライブラリだけは入れる)。ec は Eiffel を C に変換してから gcc でコンパイルする。
FROM debian:trixie-slim

ARG ES_VERSION=25.12
ARG ES_REV=98922
ARG ES_SHA256=9d28fffb0c8fb46a12d4a714bc1e8f05c9b2a2d514420e2731d6c61f42ac6769

RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates curl bzip2 gcc libc6-dev make libgtk-3-0t64 \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL -o /tmp/es.tar.bz2 \
        "https://ftp.eiffel.com/pub/download/${ES_VERSION}/Eiffel_${ES_VERSION}_rev_${ES_REV}-linux-arm64.tar.bz2" \
    && echo "${ES_SHA256}  /tmp/es.tar.bz2" | sha256sum -c - \
    && tar xjf /tmp/es.tar.bz2 -C /opt \
    && rm /tmp/es.tar.bz2

ENV ISE_EIFFEL=/opt/Eiffel_25.12 ISE_PLATFORM=linux-arm64
ENV ISE_LIBRARY=$ISE_EIFFEL ISE_PRECOMP=$ISE_EIFFEL/precomp/spec/linux-arm64
ENV PATH=$ISE_EIFFEL/studio/spec/linux-arm64/bin:$PATH

# 標準ライブラリ (EiffelBase) を前もってコンパイルしておく。これが無いと、
# 小さなプログラムでも毎回ライブラリ全体を C にしてコンパイルすることになり、
# 何分もかかる (メモリ 1GB のコンテナでは gcc が足りずに落ちる)。
# ec は失敗しても終了コード 0 を返すことがあるので、できた物を ls で確かめる。
RUN cd "$ISE_PRECOMP" \
    && ec -batch -precompile -config base-safe.ecf -c_compile \
    && ls EIFGENs/*/W_code/preobj.o

COPY eiffel /usr/local/bin/eiffel
# 動作確認をかねて 1 本コンパイルしておく。
RUN mkdir /tmp/warm && cd /tmp/warm \
    && printf 'class HELLO create make feature make do print ("ok%%N") end end\n' > hello.e \
    && eiffel hello.e && rm -rf /tmp/warm

WORKDIR /work
CMD ["bash"]
