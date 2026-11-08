# 収録用 (assets/run.cast)。各コマンドは台詞の時刻 (MAIN3 の頭からの秒) に合わせて出す。
# 使い方: asciinema rec --overwrite --idle-time-limit 25 --window-size 68x16 -c './run.sh bash -c "$(cat rec-run.sh)"' run.cast
# 録画後: python3 align-cast.py run.cast 5.7 && python3 clean-cast.py run.cast   (最初のプロンプトを台詞の位置へ揃え、起動スピナーを消す)
t0=$EPOCHREALTIME
until_t() { awk -v t="$1" -v a="$t0" -v n="$EPOCHREALTIME" 'BEGIN { d = t - (n - a); printf "%.3f", (d > 0 ? d : 0) }' | xargs sleep; }
step() { until_t "$1"; printf '\n$ %s\n' "$3"; until_t "$2"; bash -c "$3"; }
clear_screen() { printf '\033[H\033[2J'; }
clear_screen
step 5.7 9.9 "echo hello | lazy -e ''"
until_t 33.4; clear_screen
step 33.5 35.0 'cat /opt/lazyk/eg/reverse.lazy'
until_t 45.6; clear_screen
step 45.7 48.2 'printf stressed | lazy /opt/lazyk/eg/reverse.lazy'
until_t 51.5; printf '\n$ '
