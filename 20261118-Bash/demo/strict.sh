#!/usr/local/bin/bash
# set -e と pipefail の効果。各ケースを子プロセスで試す
run() {
  out=$(bash -c "$2" 2>&1); rc=$?
  echo "$1: ${out//$'\n'/ } [終了コード $rc]"
}
run "既定"          'false; echo 続行'
run "-e"            'set -e; false; echo 続行'
run "既定のパイプ"  'false | true; echo "結果は $?"'
run "pipefail"      'set -o pipefail; false | true; echo "結果は $?"'
run "-e の落とし穴" 'set -e; f() { false; echo f続行; }; if f; then :; fi; echo 終了'
