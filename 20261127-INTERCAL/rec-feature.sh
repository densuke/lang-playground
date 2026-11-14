# 収録用 (assets/feature.cast)。各コマンドは台詞の時刻 (MAIN5 の頭からの秒) に合わせて出す。
# 使い方: asciinema rec --overwrite --idle-time-limit 25 --window-size 68x16 -c './run.sh bash -c "$(cat rec-feature.sh)"' feature.cast
# 録画後: python3 align-cast.py feature.cast 5.2 && python3 clean-cast.py feature.cast
mkdir -p /tmp/w && cp /work/*.i /tmp/w && cd /tmp/w
t0=$EPOCHREALTIME
until_t() { awk -v t="$1" -v a="$t0" -v n="$EPOCHREALTIME" 'BEGIN { d = t - (n - a); printf "%.3f", (d > 0 ? d : 0) }' | xargs sleep; }
step() { until_t "$1"; printf '\n$ %s\n' "$3"; until_t "$2"; bash -c "$3"; }
clear_screen() { printf '\033[H\033[2J'; }
clear_screen
step 5.2 6.0 'head -7 rude.i'
step 10.0 11.0 'ick -b rude.i'
until_t 19.0; clear_screen
step 19.6 20.6 'head -7 servile.i'
step 24.4 25.4 'ick -b servile.i'
until_t 32.0; clear_screen
step 32.3 33.3 'cat comefrom.i'
step 37.0 42.0 'ick -b comefrom.i && ./comefrom'
until_t 50.8; clear_screen
step 51.2 52.0 "grep -v 'COME FROM' comefrom.i > n.i && ick -b n.i && ./n"
until_t 56.5; printf '\n$ '
until_t 59.0
