# 収録用 (assets/run.cast)。待ち時間は台詞の尺に合わせてある。
# 使い方: asciinema rec --overwrite --idle-time-limit 2 --window-size 68x16 -c './run.sh bash -c "$(cat rec-run.sh)"' run.cast
step() { printf '\n$ %s\n' "$1"; sleep 1.5; bash -c "$1"; sleep "$2"; }
sleep 5.5
step 'perl -v | head -2' 6
step 'cat /work/hello.pl' 14.5
step 'perl /work/hello.pl' 8.5
