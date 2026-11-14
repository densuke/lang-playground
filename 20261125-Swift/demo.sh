# コンテナ内で bash -s に流して使う。バイナリは /tmp へ出す (demo/ を汚さない)
# 言語モードは Swift 6 (データ競合検査が既定でエラー)
set -u
run() { swiftc -swift-version 6 -o "/tmp/${1%.swift}" "/work/$1" && "/tmp/${1%.swift}"; }
# 失敗が見せ場のもの。コンパイルエラーを出し、終了コードも見せる
fails() { swiftc -swift-version 6 -o /tmp/x "/work/$1" 2>&1; echo "swiftc の終了コード: $?"; }

swift --version 2>&1
echo "--- hello"; run hello.swift
echo "--- optional"; run optional.swift
echo "--- enum_switch"; run enum_switch.swift
echo "--- value_types"; run value_types.swift
echo "--- bounds_trap (実行時に止まる)"; SWIFT_BACKTRACE=enable=no run bounds_trap.swift 2>&1; echo "実行ファイルの終了コード: $?"
echo "--- missing_case (コンパイルエラーになる)"; fails missing_case.swift
echo "--- force_optional (コンパイルエラーになる)"; fails force_optional.swift
echo "--- data_race (コンパイルエラーになる)"; fails data_race.swift
echo "--- actor_ok"; run actor_ok.swift
