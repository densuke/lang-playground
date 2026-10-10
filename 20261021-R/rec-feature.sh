# 収録用 (assets/feature.cast)。待ち時間は台詞の尺に合わせてある。
# 使い方: asciinema rec --overwrite --idle-time-limit 25 --window-size 68x16 -c 'container run --rm -it -v $PWD/demo:/work lang-r bash -c "$(cat rec-feature.sh)"' feature.cast
step() { printf '\n$ %s\n' "$1"; sleep 1.5; bash -c "$1"; sleep "$2"; }
sleep 2
step "sed -n '3,6p' /work/iris.R" 21.7
step 'Rscript /work/iris.R' 14.9
printf '\n$ '
