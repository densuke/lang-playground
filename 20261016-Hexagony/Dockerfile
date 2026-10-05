# Hexagony の実験環境 (2026-10-16 「古今東西 プログラミング言語紹介」esolang 枠)
#
# 処理系は作者 Martin Ender の Ruby 製リファレンス実装 (m-ender/hexagony)。
# パッケージ配布は無いので、リポジトリを特定のコミットに固定して取り込む。
FROM ruby:3.4-slim AS fetch

RUN apt-get update \
    && apt-get install -y --no-install-recommends git ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# master の最新 (2021-04-25 "Add list of implementations to README")。
ARG HEXAGONY_COMMIT=b674f59a0c9e10c1867bd9cf34f676ba89f0fc1c
RUN git clone https://github.com/m-ender/hexagony.git /opt/hexagony \
    && git -C /opt/hexagony checkout "$HEXAGONY_COMMIT" \
    && rm -rf /opt/hexagony/.git

FROM ruby:3.4-slim AS runtime

COPY --from=fetch /opt/hexagony /opt/hexagony

# 毎回 ruby /opt/hexagony/interpreter.rb と打つのは収録で画が持たない。
RUN printf '#!/bin/sh\nexec ruby /opt/hexagony/interpreter.rb "$@"\n' > /usr/local/bin/hexagony \
    && chmod 755 /usr/local/bin/hexagony

WORKDIR /work
CMD ["bash"]
