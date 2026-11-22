# 収録用 (assets/run.cast)。各コマンドは台詞の時刻 (MAIN3 の頭からの秒) に合わせて出す。
# 使い方: ./rec-all.sh <assets> run   (中身は asciinema rec --overwrite --idle-time-limit 25 --window-size 68x16)
# 録画後: python3 align-cast.py run.cast 2.5 && python3 clean-cast.py run.cast   (最初のプロンプトを台詞の位置へ揃え、起動スピナーを消す)
# /work (= demo/) を汚さないよう、/tmp/w へ写してから動かす。
mkdir -p /tmp/w && cp /work/* /tmp/w && cd /tmp/w
t0=$EPOCHREALTIME
until_t() { awk -v t="$1" -v a="$t0" -v n="$EPOCHREALTIME" 'BEGIN { d = t - (n - a); printf "%.3f", (d > 0 ? d : 0) }' | xargs sleep; }
step() { until_t "$1"; printf '\n$ %s\n' "$3"; until_t "$2"; bash -c "$3"; }
clear_screen() { printf '\033[H\033[2J'; }
clear_screen
step 2.5 3.3 'cat hello.b'
step 11.0 12.4 'beef hello.b'
until_t 16.8; printf '\n$ '
until_t 17.2
