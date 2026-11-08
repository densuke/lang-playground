# 収録用 (assets/feature.cast)。待ち時間は台詞の尺に合わせてある。
# 使い方: asciinema rec --overwrite --idle-time-limit 30 --window-size 68x16 -c './run.sh bash -c "$(cat rec-feature.sh)"' feature.cast
# 録画後: python3 align-cast.py feature.cast 4.8   (最初のプロンプトを台詞の位置へ揃える)
# 生成物 (.o と実行ファイル) が demo/ に残らないよう、/tmp/b にコピーして動かす。
step() { printf '\n$ %s\n' "$1"; sleep 1.5; bash -c "$1"; sleep "$2"; }
clear_screen() { printf '\033[H\033[2J'; }
mkdir -p /tmp/b && cp /work/*.sim /tmp/b && cd /tmp/b
clear_screen
step 'cat coro.sim' 4.6
clear_screen
step 'cim coro.sim && ./coro' 16.7
clear_screen
step 'cat cars.sim' 9.1
clear_screen
step 'cim cars.sim && ./cars' 10.9
printf '\n$ '
