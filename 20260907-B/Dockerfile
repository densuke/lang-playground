# B の実験環境 (2026-09-07 「古今東西 プログラミング言語紹介」)
#
# 1969 年の B そのものの処理系は残っていないので、動画で紹介した現代の再実装
# bext-lang/b (Rust 製、MIT ライセンス) を使う。aarch64 Linux 向けのアセンブリを
# 出して cc でリンクするので、Apple container の arm64 でそのまま動く。
# タグ付きのリリースが無いため、2025-10-29 時点の main のコミットを固定している。
FROM debian:trixie-slim AS build

ARG B_COMMIT=078429a578202d8f6c4c667c780fc48f3711567f
ARG B_SHA256=848cb19131813612888ab38b2b850d78e153a3488d4fff02ab551ce2853a7f93

RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates curl gcc libc6-dev make rustc \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL -o /tmp/b.tar.gz \
        "https://github.com/bext-lang/b/archive/${B_COMMIT}.tar.gz" \
    && echo "${B_SHA256}  /tmp/b.tar.gz" | sha256sum -c - \
    && tar xzf /tmp/b.tar.gz -C /tmp \
    && cd /tmp/b-${B_COMMIT} \
    && make build/b \
    && mkdir -p /opt/b \
    && cp build/b /opt/b/b \
    && cp -r build/libb /opt/b/libb

# b は生成したアセンブリを cc に渡してリンクするので、実行用イメージにも gcc が要る。
FROM debian:trixie-slim
RUN apt-get update && apt-get install -y --no-install-recommends \
        gcc libc6-dev \
    && rm -rf /var/lib/apt/lists/*
COPY --from=build /opt/b /opt/b
RUN ln -s /opt/b/b /usr/local/bin/b
WORKDIR /work
CMD ["bash"]
