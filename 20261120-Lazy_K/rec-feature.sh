# 収録用 (assets/feature.cast)。各コマンドは台詞の時刻 (MAIN5 の頭からの秒) に合わせて出す。
# 使い方: asciinema rec --overwrite --idle-time-limit 25 --window-size 68x16 -c './run.sh bash -c "$(cat rec-feature.sh)"' feature.cast
# 録画後: python3 align-cast.py feature.cast 3.5 && python3 clean-cast.py feature.cast   (最初のプロンプトを台詞の位置へ揃え、起動スピナーを消す)
t0=$EPOCHREALTIME
until_t() { awk -v t="$1" -v a="$t0" -v n="$EPOCHREALTIME" 'BEGIN { d = t - (n - a); printf "%.3f", (d > 0 ? d : 0) }' | xargs sleep; }
step() { until_t "$1"; printf '\n$ %s\n' "$3"; until_t "$2"; bash -c "$3"; }
clear_screen() { printf '\033[H\033[2J'; }
clear_screen
step 3.5 4.5 'cat /opt/lazyk/eg/ab.lazy'
until_t 8.9; clear_screen
step 9.0 12.5 'lazy /opt/lazyk/eg/ab.lazy | head -c 40'
until_t 26.4; clear_screen
step 26.5 27.5 'cat /work/ski-trace.scm'
until_t 31.3; clear_screen
step 31.4 33.9 "guile --no-auto-compile /work/ski-trace.scm 'KI(SII(SII))'"
until_t 49.2; clear_screen
step 49.3 51.3 "guile --no-auto-compile /work/ski-trace.scm 'SII(SII)'"
until_t 61.0; printf '\n$ '
