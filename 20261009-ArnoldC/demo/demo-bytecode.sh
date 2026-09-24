#!/usr/bin/env bash
# 収録用 (後半)。生成された .class が「Java から生まれた」と名乗る件。
set -u
step() { printf '\n$ %s\n' "$1"; sleep 1; eval "$1" 2>/dev/null; sleep 2; }
cd /work
step 'javap -c hello | head -14'
sleep 9
printf '\n'
