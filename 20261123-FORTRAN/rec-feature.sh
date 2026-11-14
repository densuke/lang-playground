# 収録用 (assets/feature.cast)。待ち時間は台詞の尺に合わせてある。
# 使い方: asciinema rec --overwrite --idle-time-limit 25 --window-size 68x16 -c './run.sh bash -c "$(cat rec-feature.sh)"' feature.cast
# 録画後: python3 align-cast.py feature.cast 1.5   (最初のプロンプトを台詞の位置へ揃える)
step() { printf '\n$ %s\n' "$1"; sleep 1.5; bash -c "$1"; sleep "$2"; }
clear_screen() { printf '\033[H\033[2J'; }
clear_screen
step "grep -v '^C' /work/implicit_trap.f" 12.4
clear_screen
step "gfortran -o /tmp/t /work/implicit_trap.f && /tmp/t" 16.9
clear_screen
step "grep -v '^C' /work/old_flow.f" 9.5
clear_screen
step "gfortran -o /tmp/o /work/old_flow.f 2>/dev/null && /tmp/o" 3.9
clear_screen
step "gfortran -std=f2018 -o /tmp/o /work/old_flow.f 2>&1 | grep Error" 7.4
printf '\n$ '
