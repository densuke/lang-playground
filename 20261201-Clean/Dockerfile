# Clean の実験環境 (2026-12-01 「古今東西 プログラミング言語紹介」)
#
# 処理系は Clean 3.1 (公式の従来配布。BSD-2-Clause)。Linux の 64 ビット版を、アーキテクチャに合わせて選ぶ
#   arm64: clean3.1_64_arm.tar.gz (ARM 64 ビット版)  amd64: clean3.1_64.tar.gz (Intel 64 ビット版)
# どちらも sha256 を検証して展開し、make でライブラリを組み立てる。
# clm は生成したアセンブリを gcc でリンクするので gcc も入れる。
FROM debian:trixie-slim@sha256:a99cfc517144bc59b1978475ec53b46ecabec7e43635402ee5b77cc54cd1b20a

# hadolint ignore=DL3008,DL4006
RUN <<'SH'
    set -eux
    case "$(dpkg --print-architecture)" in
        arm64) file=clean3.1_64_arm.tar.gz; sha=542e5d5d198b9aecb55d972c7eb0fb99748bbc1ebb74668ba3556b4eec5998b6 ;;
        amd64) file=clean3.1_64.tar.gz;     sha=ffb03e65798246215a8c217cdbaf33fa29ae5b110cc54b144e989bb9537b3fbb ;;
        *) echo "未対応のアーキテクチャです" >&2; exit 1 ;;
    esac
    apt-get update
    apt-get install -y --no-install-recommends gcc libc6-dev make curl ca-certificates
    curl -fsSL -o /tmp/clean.tar.gz "https://ftp.cs.ru.nl/Clean/Clean31/linux/${file}"
    echo "${sha}  /tmp/clean.tar.gz" | sha256sum -c -
    tar xzf /tmp/clean.tar.gz -C /opt
    make -C /opt/clean
    rm -rf /tmp/clean.tar.gz /var/lib/apt/lists/*
SH

ENV CLEAN_HOME=/opt/clean PATH=/opt/clean/bin:$PATH LANG=C.UTF-8
WORKDIR /work
CMD ["bash"]
