# 収録用 (assets/feature.cast)。待ち時間は台詞の尺に合わせて取る。
# diverge は timeout で 3 秒で打ち切る (3 秒待っても終わらなかった、までを見せる)。
step() { printf '\n$ %s\n' "$1"; sleep 1.5; bash -c "$1"; sleep "$2"; }
clear_screen() { printf '\033[H\033[2J'; }
cd /work
clear_screen
step 'sed -n 9,20p reachability.dl' 9
clear_screen
step 'souffle reachability.dl -D-' 9
clear_screen
step 'tail -2 diverge.dl' 6
step 'timeout 3 souffle diverge.dl -D-; echo "終了コード $?"' 7
clear_screen
step 'tail -3 not_stratified.dl' 6
step 'souffle not_stratified.dl -D-; echo "終了コード $?"' 11
printf '\n$ '
