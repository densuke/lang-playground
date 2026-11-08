# 収録用 (assets/feature.cast)。待ち時間は台詞の尺に合わせてある。
# 使い方: asciinema rec --overwrite --idle-time-limit 30 --window-size 68x16 -c './run.sh bash -c "$(cat rec-feature.sh)"' feature.cast
# 録画後: python3 align-cast.py feature.cast 6.5   (最初のプロンプトを台詞の位置へ揃える)
step() { printf '\n$ %s\n' "$1"; sleep 1.5; bash -c "$1"; sleep "$2"; }
clear_screen() { printf '\033[H\033[2J'; }
clear_screen
step 'cat /work/procsub.sh' 9.25
clear_screen
step 'bash /work/procsub.sh' 17.95
clear_screen
step 'cat /work/strict.sh' 13.35
clear_screen
step 'bash /work/strict.sh' 19.4
printf '\n$ '
