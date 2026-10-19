# 収録用 (assets/run.cast)。時刻は台詞の尺に合わせてある。
# 使い方 (イメージは ./run.sh で作ってある前提):
#   asciinema rec --overwrite --idle-time-limit 20 --window-size 68x16 \
#     -c 'container run --rm -it -v "$PWD/demo:/work" lang-mercury bash -c "$(cat rec-lib.sh rec-run.sh)"' run.cast
step 2.8 'mmc --version | head -1'
step 10.0 "grep -v '^%' /work/hello.m"
step 17.0 'mmc --make hello && ./hello'
clear_at 23.3
step 23.5 "sed -n '12,15p' /work/modes.m | sed 's/ *%.*//'"
step 29.0 'mmc --make modes && ./modes'
prompt_at 41.0
sleep 3
