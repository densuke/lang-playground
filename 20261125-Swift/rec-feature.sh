# 収録用 (assets/feature.cast)。待ち時間は目安で、録画後に retime-cast で台詞の尺へ合わせる。
# 使い方: asciinema rec --overwrite --idle-time-limit 25 --window-size 68x16 -c './run.sh bash -c "$(cat rec-feature.sh)"' feature.cast
# 診断は -diagnostic-style llvm で短くする (既定の枠付き表示は 16 行に収まらない)。
# 範囲外アクセスはスタックトレースが 10 行ほど続くので、stderr を一旦ファイルへ逃がし、先頭 1 行だけを映す。
# (パイプにすると stdout がブロックバッファになり、止まる前の print が出ないため、stdout は端末のままにする)
step() { printf '\n$ %s\n' "$1"; sleep 1.5; bash -c "$1"; sleep "$2"; }
clear_screen() { printf '\033[H\033[2J'; }
cd /work
# 端末に対話式のバックトレーサ (30 秒待つ) が出ないようにする。表示するコマンドには出さない。
export SWIFT_BACKTRACE=enable=no
clear_screen
step 'cat missing_case.swift' 8
clear_screen
step 'swiftc -swift-version 6 -diagnostic-style llvm missing_case.swift' 11
clear_screen
step 'cat bounds_trap.swift' 8
clear_screen
step 'swiftc -swift-version 6 -o /tmp/s bounds_trap.swift; /tmp/s 2>/tmp/e; c=$?; head -1 /tmp/e; echo "終了コード $c"' 11
clear_screen
step 'sed -n 3,12p data_race.swift' 8
clear_screen
step 'swiftc -swift-version 6 -diagnostic-style llvm data_race.swift 2>&1 | head -3' 10
printf '\n$ '
