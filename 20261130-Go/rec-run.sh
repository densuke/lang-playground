# 収録用 (assets/run.cast)。待ち時間は目安で、録画後に retime-cast で台詞の尺へ合わせる。
# 使い方: ./rec-all.sh <assets のパス> run
step() { printf '\n$ %s\n' "$1"; sleep 1.5; bash -c "$1"; sleep "$2"; }
clear_screen() { printf '\033[H\033[2J'; }
cd /work
clear_screen
step 'go version' 3.5
clear_screen
step 'cat hello.go' 9
clear_screen
step 'go run hello.go' 6
clear_screen
step 'go build -o /tmp/hello hello.go && ls -l /tmp/hello && /tmp/hello' 8
printf '\n$ '
