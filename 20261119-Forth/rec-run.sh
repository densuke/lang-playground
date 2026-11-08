# 収録用 (assets/run.cast)。待ち時間は台詞の尺に合わせてある。
# 使い方: asciinema rec --overwrite --idle-time-limit 25 --window-size 68x16 -c './run.sh bash -c "$(cat rec-run.sh)"' run.cast
# 録画後: python3 align-cast.py run.cast 4.5   (最初のプロンプトを台詞の位置へ揃える)
step() { printf '\n$ %s\n' "$1"; sleep 1.5; bash -c "$1"; sleep "$2"; }
clear_screen() { printf '\033[H\033[2J'; }
clear_screen
step 'cat /work/hello.fs' 8.1
clear_screen
step 'gforth /work/hello.fs -e bye' 23.6
clear_screen
step 'cat /work/define.fs' 3.2
clear_screen
step 'gforth /work/define.fs -e bye' 24
printf '\n$ '
