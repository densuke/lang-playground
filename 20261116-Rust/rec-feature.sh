# 収録用 (assets/feature.cast)。待ち時間は台詞の尺に合わせてある。
# 使い方: asciinema rec --overwrite --idle-time-limit 25 --window-size 68x16 -c './run.sh bash -c "$(cat rec-feature.sh)"' feature.cast
# 録画後: python3 align-cast.py feature.cast 4.5   (最初のプロンプトを台詞の位置へ揃える)
# コンパイルエラーは長いので、先頭の 11 行 (E0382) / 10 行 (E0502) だけを映す。
step() { printf '\n$ %s\n' "$1"; sleep 1.5; bash -c "$1"; sleep "$2"; }
clear_screen() { printf '\033[H\033[2J'; }
clear_screen
step 'cat /work/ownership_move.rs' 9.5
clear_screen
step 'rustc --edition 2024 /work/ownership_move.rs 2>&1 | head -11' 13.4
clear_screen
step 'cat /work/borrow_conflict.rs' 5.7
clear_screen
step 'rustc --edition 2024 /work/borrow_conflict.rs 2>&1 | head -10' 11.0
printf '\n$ '
