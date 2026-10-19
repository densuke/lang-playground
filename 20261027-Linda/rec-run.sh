# 収録用 (assets/run.cast)。コマンドを打つ時刻は台詞の進行に合わせてある。
# 使い方: asciinema rec --overwrite --idle-time-limit 30 --window-size 68x16 -c './run.sh bash -c "$(cat rec-run.sh)"' run.cast
START=$(date +%s.%N)
OFFSET=3.1   # コンテナ起動の表示が終わるまでの秒数。at の時刻は録画の頭からの秒
at() { sleep "$(awk -v t="$1" -v o="$OFFSET" -v s="$START" -v n="$(date +%s.%N)" 'BEGIN{d=t-o-(n-s); print (d>0)?d:0}')"; }
step() { at "$1"; printf '\n$ %s\n' "$2"; sleep 1.5; bash -c "$2"; }
step 7.2 'cat /usr/local/lib/erlang/releases/27/OTP_VERSION'
step 10.6 'grep vsn /opt/espace/lib/espace/ebin/espace.app'
step 16.3 'sh /work/demo.sh hello'
at 43.5
printf '\n$ '
sleep 3
