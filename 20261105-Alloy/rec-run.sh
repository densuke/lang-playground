# 収録用 (assets/run.cast)。待ち時間は台詞の尺に合わせてある。
# 使い方: asciinema rec --overwrite --idle-time-limit 20 --window-size 68x16 -c './run.sh bash -c "$(cat rec-run.sh)"' run.cast
# 録画後: python3 align-cast.py run.cast 6.5   (最初のプロンプトを台詞の位置へ揃える)
# alloy は起動時の警告行 (findPlatform / NativeCode) を除いて見せる。
alloy() { command alloy "$@" 2>&1 | grep -v -e NativeCode -e findPlatform; }
step() { printf '\n$ %s\n' "$1"; sleep 1.5; eval "$1"; sleep "$2"; }
clear_screen() { printf '\033[H\033[2J'; }
cd /work
step 'alloy version' 3.1
clear_screen
step "sed -n '2p;4,6p;9,11p;14p' smallscope.als" 12.9
clear_screen
step "alloy exec -f -c '*' -t text -o /tmp/s smallscope.als" 6.15
step "grep -E '^(-+State|this/Node)' /tmp/s/*-0.txt" 6.6
printf '\n$ '
