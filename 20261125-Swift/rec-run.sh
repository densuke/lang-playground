# 収録用 (assets/run.cast)。待ち時間は目安で、録画後に retime-cast で台詞の尺へ合わせる。
# 使い方: asciinema rec --overwrite --idle-time-limit 25 --window-size 68x16 -c './run.sh bash -c "$(cat rec-run.sh)"' run.cast
step() { printf '\n$ %s\n' "$1"; sleep 1.5; bash -c "$1"; sleep "$2"; }
clear_screen() { printf '\033[H\033[2J'; }
cd /work
clear_screen
step 'swift --version' 3.5
clear_screen
step 'cat hello.swift' 7
clear_screen
step 'swiftc -swift-version 6 -o /tmp/s hello.swift && /tmp/s' 6
clear_screen
step 'cat first_even.swift' 9
clear_screen
step 'swiftc -swift-version 6 -o /tmp/s first_even.swift && /tmp/s' 10
printf '\n$ '
