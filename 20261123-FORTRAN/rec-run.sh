# 収録用 (assets/run.cast)。待ち時間は台詞の尺に合わせてある。
# 使い方: asciinema rec --overwrite --idle-time-limit 25 --window-size 68x16 -c './run.sh bash -c "$(cat rec-run.sh)"' run.cast
# 録画後: python3 align-cast.py run.cast 2.0   (最初のプロンプトを台詞の位置へ揃える)
step() { printf '\n$ %s\n' "$1"; sleep 1.5; bash -c "$1"; sleep "$2"; }
clear_screen() { printf '\033[H\033[2J'; }
clear_screen
step "gfortran --version | head -1" 3.2
clear_screen
step "cat /work/hello.f90" 11.1
clear_screen
step "gfortran -o /tmp/h /work/hello.f90 && /tmp/h" 6.4
clear_screen
step "grep -v '^C' /work/fixed_form.f" 10.6
clear_screen
step "gfortran -o /tmp/f /work/fixed_form.f && /tmp/f" 3.8
printf '\n$ '
