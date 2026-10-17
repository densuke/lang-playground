#!/bin/sh
# hello は main を持つ普通のプログラム、残りは式を評価して値を表示する (-t)。
cd /work
echo "=== hello.egi"
egison hello.egi
for f in multiset twin poker math; do
    echo "=== $f.egi"
    egison -t $f.egi
done
