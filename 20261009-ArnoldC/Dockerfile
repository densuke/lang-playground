# ArnoldC の実験環境 (2026-10-09 「古今東西 プログラミング言語紹介」esolang 枠)
#
# 処理系は lhartikk/ArnoldC。Scala 製で、ASM を使って JVM バイトコードを直接吐く。
# apt には無いので配布されている jar を焼く。
FROM eclipse-temurin:21-jdk

# 配布元は作者の GitHub Pages。ビルド時に一度だけ取る。
ADD https://lhartikk.github.io/ArnoldC.jar /opt/ArnoldC.jar

# 毎回 java -jar /opt/ArnoldC.jar と打つのは収録で画が持たない。
RUN printf '#!/bin/sh\nexec java -jar /opt/ArnoldC.jar "$@"\n' > /usr/local/bin/arnoldc \
    && chmod 755 /usr/local/bin/arnoldc /opt/ArnoldC.jar

WORKDIR /work
CMD ["bash"]
