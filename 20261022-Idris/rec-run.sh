# 収録用 (assets/run.cast)。待ち時間は台詞の尺に合わせてある。
# 使い方: asciinema rec --overwrite --idle-time-limit 20 --window-size 68x16 -c './run.sh bash -c "$(cat rec-run.sh)"' run.cast
step() { printf '\n$ %s\n' "$1"; sleep 1.5; bash -c "$1"; sleep "$2"; }
clear_screen() { printf '\033[H\033[2J'; }
sleep 6
step 'idris2 --version' 9
step 'cat /work/hello.idr' 4.4
step 'idris2 --build-dir /tmp/b /work/hello.idr --exec main' 4.4
clear_screen
step 'idris2 --build-dir /tmp/b /work/vect.idr --exec main' 6
step 'printf ":t append\n:q\n" | idris2 --no-banner --build-dir /tmp/b /work/vect.idr' 5.2
printf '\n$ '
sleep 3
