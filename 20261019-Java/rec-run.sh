# 収録用 (assets/run.cast)。待ち時間は台詞の尺に合わせてある。
# 使い方: asciinema rec --overwrite --idle-time-limit 20 --window-size 68x16 -c './run.sh bash -c "$(cat rec-run.sh)"' run.cast
# cast は節より短いとループするので、最後に ls を足して節の終わりまで画面を動かしている。
step() { printf '\n$ %s\n' "$1"; sleep 1.5; bash -c "$1"; sleep "$2"; }
sleep 2.8
step 'java --version | head -2' 7.4
step 'cat /work/Hello.java' 7.4
step 'java /work/Hello.java' 4
step 'ls /work' 3
