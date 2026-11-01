# 収録用 (assets/run.cast.cast)。待ち時間は台詞の尺に合わせてある (台本の音声から逆算)。
# 使い方: asciinema rec --overwrite --idle-time-limit 25 --window-size 68x16 -c './run.sh bash -c "$(cat rec-run.sh)"' run.cast
# 録画後: python3 align-cast.py run.cast 1.0   (最初のプロンプトを台詞の位置へ揃える)
# step <コマンド> <実行前の待ち> <実行後の待ち>
step() { printf '\n$ %s\n' "$1"; sleep "$2"; bash -c "$1"; sleep "$3"; }
clear_screen() { printf '\033[H\033[2J'; }
clear_screen
step 'python3 ct.py bct 0 1011' 1.5 17.4
clear_screen
step 'python3 ct.py bct 00111 101 -n 9' 1.5 21.8
printf '\n$ '
