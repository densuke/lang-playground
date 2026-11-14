# 収録用 (assets/run.cast)。待ち時間は台詞の尺に合わせてある。
# 使い方: asciinema rec --overwrite --idle-time-limit 30 --window-size 68x16 -c 'container run --rm -it -v $PWD/demo:/work lang-icon bash -c "$(cat rec-run.sh)"' run.cast
# 録画後: python3 align-cast.py run.cast <最初のプロンプトの秒数>
step() { printf '\n$ %s\n' "$1"; sleep 1.5; bash -c "$1"; sleep "$2"; }
clear_screen() { printf '\033[H\033[2J'; }
cd /tmp
clear_screen
step 'icon -V 2>&1 | head -1' 8.2
clear_screen
step 'cat /work/hello.icn' 2.5
clear_screen
step 'icon /work/hello.icn' 6.1
clear_screen
step 'cat /work/cast_every.icn' 7.2
clear_screen
step 'icon /work/cast_every.icn' 12.5
printf '\n$ '
