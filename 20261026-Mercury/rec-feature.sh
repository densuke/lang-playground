# 収録用 (assets/feature.cast)。時刻は台詞の尺に合わせてある。
# 使い方 (イメージは ./run.sh で作ってある前提):
#   asciinema rec --overwrite --idle-time-limit 20 --window-size 68x16 \
#     -c 'container run --rm -it -v "$PWD/demo:/work" lang-mercury bash -c "$(cat rec-lib.sh rec-feature.sh)"' feature.cast
step 7.0 "sed -n '10,12p' /work/bad_type.m"
step 11.7 'mmc --make bad_type'
clear_at 18.3
step 18.6 "sed -n '10,11p' /work/bad_det.m"
step 24.0 'mmc --make bad_det'
clear_at 33.8
step 34.2 "sed -n '13,14p' /work/bad_mode.m"
step 40.0 'mmc --make bad_mode'
prompt_at 48.6
sleep 3
