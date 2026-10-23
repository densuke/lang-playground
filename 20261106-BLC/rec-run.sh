# 収録用 (assets/run.cast)。待ち時間は台詞の尺に合わせてある。
# 使い方: asciinema rec --overwrite --idle-time-limit 25 --window-size 68x16 -c './run.sh bash -c "$(cat rec-run.sh)"' run.cast
# 録画後: python3 align-cast.py run.cast 1.0   (最初のプロンプトを台詞の位置へ揃える)
# step <コマンド> <実行前の待ち> <実行後の待ち>
step() { printf '\n$ %s\n' "$1"; sleep "$2"; bash -c "$1"; sleep "$3"; }
clear_screen() { printf '\033[H\033[2J'; }
clear_screen
step 'tail -n 1 id.lam' 1.5 5.7
step 'perl lam2blc.pl -s id.lam' 1.5 5.7
step '(perl lam2blc.pl -B id.lam; echo "Hello, BLC") | tromp' 5.0 5.8
printf '\n$ '
