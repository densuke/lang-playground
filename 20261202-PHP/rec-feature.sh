# 収録用 (assets/feature.cast)。待ち時間は台詞の尺に合わせてある。
# 使い方: ./rec-all.sh <出力先の assets ディレクトリ> feature
# 録画後: python3 retime-cast.py feature.cast 53.4 3.0 14.2 35.0   (同上。台本を変えたら秒数を合わせ直す)
step() { printf '\n$ %s\n' "$1"; sleep 1.5; bash -c "$1"; sleep "$2"; }
clear_screen() { printf '\033[H\033[2J'; }
clear_screen
step "cat /work/array.php" 12.0
clear_screen
step "php /work/array.php" 15.0
clear_screen
step "php /work/version_check.php" 20.0
printf '\n$ '
