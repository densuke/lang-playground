# 収録用 (assets/feature.cast)。待ち時間は台詞の尺に合わせてある。
# 使い方: asciinema rec --overwrite --idle-time-limit 25 --window-size 68x16 -c './run.sh bash -c "$(cat rec-feature.sh)"' feature.cast
# 録画後: python3 align-cast.py feature.cast 1.5   (最初のプロンプトを台詞の位置へ揃える)
step() { printf '\n$ %s\n' "$1"; sleep 1.5; bash -c "$1"; sleep "$2"; }
clear_screen() { printf '\033[H\033[2J'; }
step 'sed -n 2,5p /work/blocks.rb' 9.75
step 'sed -n 2,5p /work/blocks.rb | ruby' 10.95
clear_screen
step 'sed -n 2,5p /work/objects.rb' 5.65
step 'sed -n 2,5p /work/objects.rb | ruby' 4.45
printf '\n$ '
