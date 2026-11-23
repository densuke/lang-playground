# 収録用 (assets/feature.cast)。待ち時間は目安で、録画後に retime-cast で台詞の尺へ合わせる。
# 使い方: asciinema rec --overwrite --idle-time-limit 25 --window-size 68x16 -c './run.sh bash -c "$(cat rec-feature.sh)"' feature.cast
# エラーの全文は参照トレースが続いて 16 行に収まらないので、先頭 4 行だけを映す。
step() { printf '\n$ %s\n' "$1"; sleep 1.5; bash -c "$1"; sleep "$2"; }
clear_screen() { printf '\033[H\033[2J'; }
cd /work
clear_screen
step 'cat comptime_overflow.zig' 9
clear_screen
step 'zig build-exe comptime_overflow.zig -femit-bin=/tmp/c 2>&1 | head -4' 10
clear_screen
step 'zig build-exe hello.zig -target x86_64-windows -femit-bin=/tmp/h.exe && file /tmp/h.exe | cut -c1-140' 9
clear_screen
step 'zig build-exe hello.zig -target aarch64-macos -femit-bin=/tmp/h.mac && file /tmp/h.mac | cut -c1-100' 9
printf '\n$ '
