# 収録用 (assets/feature.cast)。待ち時間は台詞の尺に合わせてある。
# 使い方: asciinema rec --overwrite --idle-time-limit 25 --window-size 68x16 -c './run.sh bash -c "$(cat rec-feature.sh)"' feature.cast
# 録画後: python3 align-cast.py feature.cast 7.6   (最初のプロンプトを台詞の位置へ揃える)
step() { printf '\n$ %s\n' "$1"; sleep 1.5; bash -c "$1"; sleep "$2"; }
clear_screen() { printf '\033[H\033[2J'; }
step 'cat /work/bad_claim.v' 5.85
clear_screen
step 'rocq compile /work/bad_claim.v; echo exit=$?' 12.5
clear_screen
step 'cat /work/bad_cheat.v' 7.55
clear_screen
step 'rocq compile /work/bad_cheat.v; echo exit=$?' 5.9
printf '\n$ '
