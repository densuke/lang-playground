#!/usr/local/bin/bash
# set -euo pipefail の効果。各ケースを子プロセスで試す
run() { echo "== $1"; bash -c "$2"; echo "終了コード=$?"; }

run "既定: false の後も続く"        'false; echo 続行'
run "-e: 失敗で止まる"              'set -e; false; echo 続行'
run "既定: 未定義変数は空"          'echo "[$undefined]"'
run "-u: 未定義変数でエラー"        'set -u; echo "[$undefined]"'
run "既定: パイプは最後の終了コード" 'false | true; echo "パイプの結果=$?"'
run "pipefail: 途中の失敗を拾う"    'set -o pipefail; false | true; echo "パイプの結果=$?"'
run "-e の落とし穴: if の条件内では効かない" 'set -e; f() { false; echo f続行; }; if f; then :; fi; echo 終了'
