# 収録用 (assets/feature.cast)。待ち時間は台詞の尺に合わせてある。
# 使い方: asciinema rec --overwrite --idle-time-limit 25 --window-size 68x16 -c './run.sh bash -c "$(cat rec-feature.sh)"' feature.cast
# 録画後: python3 align-cast.py feature.cast 1.0   (最初のプロンプトを台詞の位置へ揃える)
# step <コマンド> <実行前の待ち> <実行後の待ち>
step() { printf '\n$ %s\n' "$1"; sleep "$2"; bash -c "$1"; sleep "$3"; }
clear_screen() { printf '\033[H\033[2J'; }
clear_screen
step "grep -v '^--' uni.dbj" 1.5 11.9
clear_screen
step 'perl lam2blc.pl -d uni.dbj | wc -c' 1.5 5.7
step '(perl lam2blc.pl -d uni.dbj; perl lam2blc.pl id.lam; echo -n 0100100001101001) | tromp -b' 12.4 3.5
printf '\n$ '
