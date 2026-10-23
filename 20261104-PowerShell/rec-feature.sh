# 収録用 (assets/feature.cast)。待ち時間は台詞の尺に合わせてある。
# 使い方: asciinema rec --overwrite --idle-time-limit 25 --window-size 68x16 -c './run.sh bash -c "$(cat rec-feature.sh)"' feature.cast
# 録画後: python3 align-cast.py feature.cast 6.2   (最初のプロンプトを台詞の位置へ揃える)
step() { printf '\n$ %s\n' "$1"; sleep 1.5; bash -c "$1"; sleep "$2"; }
clear_screen() { printf '\033[H\033[2J'; }
step 'cat /work/pipe.ps1' 10.4
clear_screen
step 'pwsh /work/pipe.ps1' 9.9
clear_screen
step 'cat /work/types.ps1' 7.6
step 'pwsh /work/types.ps1' 9
printf '\n$ '
