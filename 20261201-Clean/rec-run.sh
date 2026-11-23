# 収録用 (assets/run.cast)。
# 待ち時間は目安で、録画後に retime-cast で台詞の尺へ合わせる。
# clm は Clean System Files を作業ディレクトリに作るので、/work のコピーを /tmp に作って使う。
step() { printf '\n$ %s\n' "$1"; sleep 1.5; bash -c "$1"; sleep "$2"; }
clear_screen() { printf '\033[H\033[2J'; }
rm -rf /tmp/w && cp -r /work /tmp/w && cd /tmp/w
clear_screen
step 'clm --version | head -1' 3.5
clear_screen
step 'cat hello.icl' 9
clear_screen
step 'clm -ms hello -o hello && ./hello -nt' 7
clear_screen
step 'cat squares.icl' 10
clear_screen
step 'clm -ms squares -o squares && ./squares -nt' 7
printf '\n$ '
