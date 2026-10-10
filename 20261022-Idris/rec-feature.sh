# 収録用 (assets/feature.cast)。待ち時間は台詞の尺に合わせてある。
# 使い方: asciinema rec --overwrite --idle-time-limit 20 --window-size 68x16 -c './run.sh bash -c "$(cat rec-feature.sh)"' feature.cast
step() { printf '\n$ %s\n' "$1"; sleep 1.5; bash -c "$1"; sleep "$2"; }
clear_screen() { printf '\033[H\033[2J'; }
sleep 1.3
step "sed -n '5,7p' /work/bad_length.idr" 8.8
step 'idris2 --build-dir /tmp/b --check /work/bad_length.idr 2>&1 | head -9' 6
clear_screen
step "sed -n '5,8p' /work/bad_total.idr" 6.5
step 'idris2 --build-dir /tmp/b --check /work/bad_total.idr 2>&1' 8
printf '\n$ '
sleep 2
