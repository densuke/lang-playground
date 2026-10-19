# 収録用 (assets/feature.cast)。コマンドの出る時刻は台詞の流れに合わせてある (at の引数は節の頭からの秒)。
# 使い方: asciinema rec --overwrite --idle-time-limit 20 --window-size 68x16 -c 'T0=$(python3 -c "import time;print(time.time())"); ./run.sh bash -c "T0=$T0; $(cat rec-feature.sh)"' feature.cast
# T0 は収録の開始時刻 (epoch 秒)。コンテナの時計はホストと合っているので、これを基準に待つ。
at() { sleep "$(awk -v t="$1" -v z="$T0" -v n="$(date +%s.%N)" 'BEGIN{d=z+t-n;if(d<0)d=0;print d}')"; }
step() { at "$1"; printf '\n$ %s\n' "$2"; sleep 1.5; bash -c "$2"; }
clear_screen() { printf '\033[H\033[2J'; }
at 5
clear_screen
step 6 "sed -n '31,34p' /work/poker.egi"
step 22.6 'egison -t /work/poker.egi'
at 33.8
clear_screen
step 34.3 "grep -v -e '^--' -e '^\$' /work/math.egi"
at 41.2
clear_screen
step 41.5 'egison -t /work/math.egi'
at 56
printf '\n$ '
at 59
