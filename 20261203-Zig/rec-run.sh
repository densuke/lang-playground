# 収録用 (assets/run.cast)。待ち時間は目安で、録画後に retime-cast で台詞の尺へ合わせる。
# 使い方: asciinema rec --overwrite --idle-time-limit 25 --window-size 68x16 -c './run.sh bash -c "$(cat rec-run.sh)"' run.cast
step() { printf '\n$ %s\n' "$1"; sleep 1.5; bash -c "$1"; sleep "$2"; }
clear_screen() { printf '\033[H\033[2J'; }
cd /work
clear_screen
step 'zig version' 3.5
clear_screen
step 'cat hello.zig' 8
clear_screen
step 'zig build-exe hello.zig -femit-bin=/tmp/h && /tmp/h' 6
clear_screen
step 'cat fib_test.zig' 10
clear_screen
step 'zig test fib_test.zig' 10
printf '\n$ '
