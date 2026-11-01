# 収録用 (assets/feature.cast.cast)。待ち時間は台詞の尺に合わせてある (台本の音声から逆算)。
# 使い方: asciinema rec --overwrite --idle-time-limit 25 --window-size 68x16 -c './run.sh bash -c "$(cat rec-feature.sh)"' feature.cast
# 録画後: python3 align-cast.py feature.cast 1.0   (最初のプロンプトを台詞の位置へ揃える)
# step <コマンド> <実行前の待ち> <実行後の待ち>
step() { printf '\n$ %s\n' "$1"; sleep "$2"; bash -c "$1"; sleep "$3"; }
clear_screen() { printf '\033[H\033[2J'; }
clear_screen
step 'python3 ct.py ct "011,10,101" 1 -n 6' 1.5 14.4
step 'python3 ct.py tobct "011,10,101"' 11 15.9
clear_screen
step 'python3 collatz_bct.py 3' 14 8.4
step 'python3 collatz_bct.py 7' 1 10.1
printf '\n$ '
