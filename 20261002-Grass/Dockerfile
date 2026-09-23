# Grass の実験環境 (2026-10-02 「古今東西 プログラミング言語紹介」)
#
# 処理系は作者 UENO Katsuhiro 氏本人による Ruby 実装 grass.rb (BSD ライセンス)。
# 今の Ruby で動くよう 1 行だけ直した TryItOnline のミラー版を使う。
# 自作の処理系は静かに間違うので、公式実装をそのまま使う。
FROM debian:trixie-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
        ruby \
    && rm -rf /var/lib/apt/lists/*

COPY grass.rb /usr/local/lib/grass.rb
RUN printf '#!/bin/sh\nexec ruby /usr/local/lib/grass.rb "$@"\n' > /usr/local/bin/grass \
    && chmod +x /usr/local/bin/grass

WORKDIR /work
CMD ["sh"]
