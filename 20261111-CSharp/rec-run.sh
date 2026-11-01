# 収録用 (assets/run.cast)。待ち時間は台詞の尺に合わせてある。
# 使い方: asciinema rec --overwrite --idle-time-limit 25 --window-size 68x16 -c './run.sh bash -c "$(cat rec-run.sh)"' run.cast
# 録画後: python3 align-cast.py run.cast 5.5   (最初のプロンプトを台詞の位置へ揃える)
cd /work
# SDK の初回起動 (十数秒) は画面に映さない。各ファイルのビルドは映る。
echo 'return;' > /tmp/warmup.cs && dotnet run /tmp/warmup.cs > /dev/null 2>&1
step() { printf '\n$ %s\n' "$1"; sleep 1.5; bash -c "$1"; sleep "$2"; }
clear_screen() { printf '\033[H\033[2J'; }
step 'dotnet --version' 7
step 'cat hello.cs' 9
clear_screen
step 'dotnet run hello.cs' 19
printf '\n$ '
