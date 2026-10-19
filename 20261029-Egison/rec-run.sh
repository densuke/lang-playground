# 収録用 (assets/run.cast)。コマンドの出る時刻は台詞の流れに合わせてある (at の引数は節の頭からの秒)。
# 使い方: asciinema rec --overwrite --idle-time-limit 20 --window-size 68x16 -c 'T0=$(python3 -c "import time;print(time.time())"); ./run.sh bash -c "T0=$T0; $(cat rec-run.sh)"' run.cast
# T0 は収録の開始時刻 (epoch 秒)。コンテナの時計はホストと合っているので、これを基準に待つ。
at() { sleep "$(awk -v t="$1" -v z="$T0" -v n="$(date +%s.%N)" 'BEGIN{d=z+t-n;if(d<0)d=0;print d}')"; }
step() { at "$1"; printf '\n$ %s\n' "$2"; sleep 1.5; bash -c "$2"; }
clear_screen() { printf '\033[H\033[2J'; }
at 5
clear_screen
step 6 'egison --version'
step 13.3 'tail -n 1 /work/hello.egi'
step 20.2 'egison /work/hello.egi'
at 25.9
clear_screen
step 26.5 "sed -n '4,5p;8,9p' /work/multiset.egi"
step 37.1 'egison -t /work/multiset.egi'
at 56.8
clear_screen
step 57.0 "sed -n '2,4p' /work/twin.egi"
step 61.1 'egison -t /work/twin.egi'
at 72.3
printf '\n$ '
at 75.4
