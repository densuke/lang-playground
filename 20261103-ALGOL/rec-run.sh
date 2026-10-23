# 収録用 (assets/run.cast)。待ち時間は台詞の尺に合わせてある。
# 使い方: asciinema rec --overwrite --idle-time-limit 30 --window-size 68x16 -c './run.sh bash -c "$(cat rec-run.sh)"' run.cast
# 録画後: python3 align-cast.py run.cast 2.4   (最初のプロンプトを台詞の位置へ揃える)
step() { printf '\n$ %s\n' "$1"; sleep 1.5; bash -c "$1"; sleep "$2"; }
clear_screen() { printf '\033[H\033[2J'; }
step 'marst --version 2>&1 | grep Version' 1.75
step 'cat /work/hello.alg' 17.7
clear_screen
step 'alg /work/hello.alg' 4.7
step 'alg /work/blocks.alg' 6.4
printf '\n$ '
