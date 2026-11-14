# 収録用 (assets/feature.cast)。待ち時間は台詞の尺に合わせてある。
# 使い方: asciinema rec --overwrite --idle-time-limit 30 --window-size 68x16 -c 'container run --rm -it -v $PWD/demo:/work lang-icon bash -c "$(cat rec-feature.sh)"' feature.cast
# 録画後: python3 align-cast.py feature.cast <最初のプロンプトの秒数>
step() { printf '\n$ %s\n' "$1"; sleep 1.5; bash -c "$1"; sleep "$2"; }
clear_screen() { printf '\033[H\033[2J'; }
cd /tmp
clear_screen
step 'cat /work/cast_fail.icn' 11.9
clear_screen
step 'icon /work/cast_fail.icn' 28.6
clear_screen
step 'cat /work/cast_gen.icn' 9.9
clear_screen
step 'icon /work/cast_gen.icn' 10.4
printf '\n$ '
