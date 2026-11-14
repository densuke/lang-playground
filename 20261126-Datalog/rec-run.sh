# 収録用 (assets/run.cast)。待ち時間は台詞の尺に合わせて取る。
# 使い方は rec-all.sh を参照 (run.sh は毎回 container build を呼ぶので使わない)。
step() { printf '\n$ %s\n' "$1"; sleep 1.5; bash -c "$1"; sleep "$2"; }
clear_screen() { printf '\033[H\033[2J'; }
cd /work
clear_screen
step 'souffle --version | head -3' 3.5
clear_screen
step 'cat ancestor.dl' 8
clear_screen
step 'souffle ancestor.dl -D-' 7
clear_screen
step 'grep ":-" left_recursion.dl' 5
clear_screen
step 'diff <(souffle ancestor.dl -D-) <(souffle left_recursion.dl -D-) && echo "出力は同じ"' 7
printf '\n$ '
