# 収録用 (assets/feature.cast)。待ち時間は目安で、録画後に retime-cast で台詞の尺へ合わせる。
# 使い方: ./rec-all.sh <assets のパス> feature
step() { printf '\n$ %s\n' "$1"; sleep 1.5; bash -c "$1"; sleep "$2"; }
clear_screen() { printf '\033[H\033[2J'; }
cd /work
clear_screen
step "sed -n '/^func main/,\$p' sortsignal.go" 11
clear_screen
step 'go run sortsignal.go' 6
clear_screen
step "sed -n '/^func main/,\$p' race.go" 9
clear_screen
step 'for i in 1 2 3; do go run race.go; done' 10
clear_screen
step 'go run -race race.go 2>&1 | head -8' 8
printf '\n$ '
