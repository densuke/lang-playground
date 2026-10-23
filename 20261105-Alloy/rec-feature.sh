# 収録用 (assets/feature.cast)。待ち時間は台詞の尺に合わせてある。
# 使い方: asciinema rec --overwrite --idle-time-limit 20 --window-size 68x16 -c './run.sh bash -c "$(cat rec-feature.sh)"' feature.cast
# 録画後: python3 align-cast.py feature.cast 1.5   (最初のプロンプトを台詞の位置へ揃える)
# alloy は起動時の警告行 (findPlatform / NativeCode) を除いて見せる。
alloy() { command alloy "$@" 2>&1 | grep -v -e NativeCode -e findPlatform; }
step() { printf '\n$ %s\n' "$1"; sleep 1.5; eval "$1"; sleep "$2"; }
clear_screen() { printf '\033[H\033[2J'; }
cd /work
step "sed -n '5,6p;8p;11,18p' temporal.als" 11.8
clear_screen
step "sed -n '26p;29p' temporal.als" 4.1
step "alloy exec -f -c '*' -t text -o /tmp/t temporal.als" 12.35
clear_screen
step "grep -E '^-+State|Critical' /tmp/t/NeverEnters-*-0.txt" 7.0
printf '\n$ '
