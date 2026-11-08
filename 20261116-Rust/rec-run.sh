# 収録用 (assets/run.cast)。待ち時間は台詞の尺に合わせてある。
# 使い方: asciinema rec --overwrite --idle-time-limit 25 --window-size 68x16 -c './run.sh bash -c "$(cat rec-run.sh)"' run.cast
# 録画後: python3 align-cast.py run.cast 4.5   (最初のプロンプトを台詞の位置へ揃える)
step() { printf '\n$ %s\n' "$1"; sleep 1.5; bash -c "$1"; sleep "$2"; }
clear_screen() { printf '\033[H\033[2J'; }
clear_screen
step 'rustc --version' 3.1
clear_screen
step 'cat /work/hello.rs' 8.5
clear_screen
step 'rustc --edition 2024 -o /tmp/r /work/hello.rs && /tmp/r' 6.8
clear_screen
step 'cat /work/result.rs' 5.9
clear_screen
step 'rustc --edition 2024 -o /tmp/r /work/result.rs && /tmp/r' 11.7
printf '\n$ '
