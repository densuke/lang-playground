# MUMPS の実験環境 (2026-08-31 「古今東西 プログラミング言語紹介」)
#
# 処理系は YottaDB r2.06 (GT.M の後継のオープンソース実装)。Debian には
# パッケージが無いので、公式の配布物 (GitLab のリリースに置かれた
# AARCH64 / Debian 13 向けのバイナリ tarball) を SHA-256 を確かめてから入れる。
# SHA-256 はリリースノートに載っている値。
FROM debian:trixie-slim

ARG YDB_URL=https://gitlab.com/-/project/7957109/uploads/20b5fe44b591ce11afc1bb908f182a7c/yottadb_r206_aarch64_debian13_pro.tgz
ARG YDB_SHA256=eb9aa7bcc58e6541abceee0dbc8e5db8d4ed699dec79630da2b779e6a0b789a7

ENV ydb_dist=/opt/yottadb/r2.06
# 付属の ydbinstall に、この tarball を展開した場所から入れさせる。
RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates curl wget file binutils procps libelf1t64 \
    && rm -rf /var/lib/apt/lists/* \
    && curl -fsSL -o /tmp/ydb.tgz "${YDB_URL}" \
    && echo "${YDB_SHA256}  /tmp/ydb.tgz" | sha256sum -c - \
    && mkdir /tmp/ydb && tar xzf /tmp/ydb.tgz -C /tmp/ydb --strip-components=1 \
    && /tmp/ydb/ydbinstall --installdir "${ydb_dist}" --nopkg-config \
    && rm -rf /tmp/ydb /tmp/ydb.tgz

# グローバル変数 (^ で始まる名前) を入れるデータベースを /data に作る。
# コンパイル結果 (.o) は /tmp/ydbobj に置き、/work (demo/) には書かない。
# ルーチンの実行時エラーで対話モード (direct mode) に入ると標準入力を読んでしまうので、
# エラーが出たら内容を表示して終わるようにする。
ENV ydb_gbldir=/data/yottadb.gld \
    ydb_routines="/tmp/ydbobj(/work) /opt/yottadb/r2.06/libyottadbutil.so" \
    ydb_etrap='write $zstatus,! zhalt 1' \
    PATH=/opt/yottadb/r2.06:$PATH
RUN mkdir -p /data /tmp/ydbobj /work \
    && printf 'change -segment DEFAULT -file_name=/data/yottadb.dat\nexit\n' \
        | yottadb -run GDE \
    && mupip create

WORKDIR /work
CMD ["bash"]
