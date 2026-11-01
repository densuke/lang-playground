# 収録用 (assets/run.cast)。待ち時間は台詞の尺に合わせてある。
# 使い方: asciinema rec --overwrite --idle-time-limit 25 --window-size 68x16 -c './run.sh bash -c "$(cat rec-run.sh)"' run.cast
# 録画後: python3 align-cast.py run.cast 7.6   (最初のプロンプトを台詞の位置へ揃える)
clear_screen() { printf '\033[H\033[2J'; }
step() { clear_screen; printf '$ %s\n' "$1"; sleep 1.5; bash -c "$1"; sleep "$2"; }
clear_screen
step 'tsc --version' 4.4
step 'cat /work/errors.ts' 13.9
step 'tsc --noEmit --pretty false errors.ts; echo "exit code: $?"' 18.2
printf '\n$ '
