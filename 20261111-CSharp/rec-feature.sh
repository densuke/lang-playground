# 収録用 (assets/feature.cast)。待ち時間は台詞の尺に合わせてある。
# 使い方: asciinema rec --overwrite --idle-time-limit 25 --window-size 68x16 -c './run.sh bash -c "$(cat rec-feature.sh)"' feature.cast
# 録画後: python3 align-cast.py feature.cast 5   (最初のプロンプトを台詞の位置へ揃える)
cd /work
echo 'return;' > /tmp/warmup.cs && dotnet run /tmp/warmup.cs > /dev/null 2>&1
step() { printf '\n$ %s\n' "$1"; sleep 1.5; bash -c "$1"; sleep "$2"; }
clear_screen() { printf '\033[H\033[2J'; }
step 'cat query.cs' 14
clear_screen
step 'dotnet run query.cs' 20
printf '\n$ '
