# 収録用 (assets/run.cast)。待ち時間は台詞の尺に合わせてある。
# 使い方: ./rec-all.sh <出力先の assets ディレクトリ> run
# 録画後: python3 retime-cast.py run.cast 36.0 2.5 9.0 28.2   (各ステップの開始を台詞に合わせる。引数は終了秒と各ステップの開始秒)
step() { printf '\n$ %s\n' "$1"; sleep 1.5; bash -c "$1"; sleep "$2"; }
clear_screen() { printf '\033[H\033[2J'; }
clear_screen
step "php -v | head -1" 4.0
clear_screen
step "cat /work/index.php" 11.0
clear_screen
step "php /work/index.php" 12.0
printf '\n$ '
