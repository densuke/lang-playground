#!/usr/bin/env bash
# 収録: ./rec.sh run|feature <出力先の cast>
set -euo pipefail
cd "$(dirname "$0")"
name="$1"; out="$2"
asciinema rec --overwrite --idle-time-limit 20 --window-size 68x16 \
    -c "T0=\$(python3 -c 'import time;print(time.time())'); ./run.sh bash -c \"T0=\$T0; \$(cat rec-$name.sh)\"" "$out"
