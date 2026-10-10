# 収録用 (assets/feature.cast)。待ち時間は台詞の尺に合わせてある。
# 使い方: asciinema rec --overwrite --idle-time-limit 20 --window-size 68x16 -c './run.sh bash -c "$(cat rec-feature.sh)"' feature.cast
# cast は節より短いとループするので、仮想スレッドの結果を節の終わり近くに出している。
step() { printf '\n$ %s\n' "$1"; sleep 1.5; bash -c "$1"; sleep "$2"; }
sleep 2.0
step "sed -n '2,5p' /work/Shapes.java" 13.5
step "sed -n '8,13p' /work/Shapes.java" 6.8
step 'java /work/Shapes.java' 17.4
step 'java /work/Threads.java' 4
