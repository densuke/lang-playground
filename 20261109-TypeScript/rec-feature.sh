# 収録用 (assets/feature.cast)。待ち時間は台詞の尺に合わせてある。
# 使い方: asciinema rec --overwrite --idle-time-limit 25 --window-size 68x16 -c './run.sh bash -c "$(cat rec-feature.sh)"' feature.cast
# 録画後: python3 align-cast.py feature.cast 6.3   (最初のプロンプトを台詞の位置へ揃える)
clear_screen() { printf '\033[H\033[2J'; }
step() { clear_screen; printf '$ %s\n' "$1"; sleep 1.5; bash -c "$1"; sleep "$2"; }
clear_screen
step 'cat /work/shape.ts' 11.1
step 'tsc --noEmit --pretty false shape.ts' 9.6
step 'tsc --outDir /tmp/out --pretty false erase.ts && cat /tmp/out/erase.js' 18.8
step 'node erase.ts' 15.0
printf '\n$ '
