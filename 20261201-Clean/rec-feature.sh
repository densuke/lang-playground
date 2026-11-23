# 収録用 (assets/feature.cast)。
# 待ち時間は目安で、録画後に retime-cast で台詞の尺へ合わせる。
# clm は Clean System Files を作業ディレクトリに作るので、/work のコピーを /tmp に作って使う。
step() { printf '\n$ %s\n' "$1"; sleep 1.5; bash -c "$1"; sleep "$2"; }
clear_screen() { printf '\033[H\033[2J'; }
rm -rf /tmp/w && cp -r /work /tmp/w && cd /tmp/w
clear_screen
step 'cat write_file.icl' 14
clear_screen
step 'clm -ms write_file -o wf && ./wf -nt' 8
clear_screen
step 'cat shared_file.icl' 9
clear_screen
step 'clm -ms shared_file -o sf 2>&1 | head -1' 10
printf '\n$ '
