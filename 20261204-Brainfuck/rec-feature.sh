# 収録用 (assets/feature.cast)。各コマンドは台詞の時刻 (MAIN5 の頭からの秒) に合わせて出す。
# 使い方: ./rec-all.sh <assets> feature
# 録画後: python3 align-cast.py feature.cast 7.0 && python3 clean-cast.py feature.cast
mkdir -p /tmp/w && cp /work/* /tmp/w && cd /tmp/w
t0=$EPOCHREALTIME
until_t() { awk -v t="$1" -v a="$t0" -v n="$EPOCHREALTIME" 'BEGIN { d = t - (n - a); printf "%.3f", (d > 0 ? d : 0) }' | xargs sleep; }
step() { until_t "$1"; printf '\n$ %s\n' "$3"; until_t "$2"; bash -c "$3"; }
clear_screen() { printf '\033[H\033[2J'; }
clear_screen
step 7.0 7.8 'sed -n 11,20p mini.c'
until_t 14.0; clear_screen
step 14.3 15.0 'sed -n 21,34p mini.c'
until_t 19.8; clear_screen
step 20.1 22.4 'gcc -o mini mini.c && ./mini hello.b'
until_t 27.4; clear_screen
step 27.6 28.4 'cat add.b'
step 38.5 39.4 './mini add.b'
until_t 45.0; printf '\n$ '
until_t 45.5
