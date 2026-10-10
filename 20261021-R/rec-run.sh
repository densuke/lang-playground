# 収録用 (assets/run.cast)。待ち時間は台詞の尺に合わせてある。
# 使い方: asciinema rec --overwrite --idle-time-limit 25 --window-size 68x16 -c 'container run --rm -it -v $PWD/demo:/work lang-r bash -c "$(cat rec-run.sh)"' run.cast
step() { printf '\n$ %s\n' "$1"; sleep 1.5; bash -c "$1"; sleep "$2"; }
sleep 6.4
step 'R --version | head -1' 4.6
step 'cat /work/hello.R' 17.4
step 'Rscript /work/hello.R' 4.4
printf '\n$ '
