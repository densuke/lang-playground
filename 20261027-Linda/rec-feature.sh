# 収録用 (assets/feature.cast)。コマンドを打つ時刻は台詞の進行に合わせてある。
# 使い方: asciinema rec --overwrite --idle-time-limit 30 --window-size 68x16 -c './run.sh bash -c "$(cat rec-feature.sh)"' feature.cast
START=$(date +%s.%N)
OFFSET=3.1   # コンテナ起動の表示が終わるまでの秒数。at の時刻は録画の頭からの秒
at() { sleep "$(awk -v t="$1" -v o="$OFFSET" -v s="$START" -v n="$(date +%s.%N)" 'BEGIN{d=t-o-(n-s); print (d>0)?d:0}')"; }
step() { at "$1"; printf '\n$ %s\n' "$2"; sleep 1.5; bash -c "$2"; }
step 3.6 "sed -n '14,19p' /work/prodcons.erl"
step 15.6 'sh /work/demo.sh prodcons'
at 34.6
printf '\033[H\033[2J'
step 35.0 'sh /work/demo.sh taskbag'
at 47.0
printf '\n$ '
sleep 3
