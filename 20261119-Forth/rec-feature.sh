# 収録用 (assets/feature.cast)。待ち時間は台詞の尺に合わせてある。
# 使い方: asciinema rec --overwrite --idle-time-limit 25 --window-size 68x16 -c './run.sh bash -c "$(cat rec-feature.sh)"' feature.cast
# 録画後: python3 align-cast.py feature.cast 5.6   (最初のプロンプトを台詞の位置へ揃える)
step() { printf '\n$ %s\n' "$1"; sleep 1.5; bash -c "$1"; sleep "$2"; }
clear_screen() { printf '\033[H\033[2J'; }
clear_screen
step 'cat /work/control.fs' 7.35
clear_screen
step 'gforth /work/control.fs -e bye' 13.2
clear_screen
step 'cat /work/defining.fs' 3.05
clear_screen
step 'gforth /work/defining.fs -e bye' 16.5
printf '\n$ '
