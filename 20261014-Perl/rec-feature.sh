# 収録用 (assets/feature.cast)。待ち時間は台詞の尺に合わせてある。
# 使い方: asciinema rec --overwrite --idle-time-limit 2 --window-size 68x16 -c './run.sh bash -c "$(cat rec-feature.sh)"' feature.cast
step() { printf '\n$ %s\n' "$1"; sleep 1.5; bash -c "$1"; sleep "$2"; }
sleep 2
step "sed -n '9,10p' /work/report.pl" 13.1
step 'perl /work/report.pl' 7.7
step "printf 'foo bar\\nbaz foo\\n' | perl -pe 's/foo/FOO/g'" 11.5
