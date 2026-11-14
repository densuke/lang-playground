# コンテナ内で bash -s に流して使う。バイナリは /tmp へ出す (demo/ を汚さない)
set -u
cd /work
# 拡張子 .f は固定形式、.f90 は自由形式として扱われる。昔のコードは -std=legacy で通す
run() { gfortran -J /tmp "${@:2}" -o "/tmp/${1%.*}" "$1" 2>&1 && "/tmp/${1%.*}"; }
# 失敗が見せ場のもの。コンパイラの出力と終了コードを見せる
fails() { gfortran "${@:2}" -o /tmp/x "$1" 2>&1; echo "gfortran の終了コード: $?"; }

gfortran --version | head -1
echo "--- hello (自由形式 .f90)"; run hello.f90
echo "--- fixed_form (固定形式 .f)"; run fixed_form.f
echo "--- old_flow (算術 IF。既定では警告つきで通る)"; run old_flow.f 2>&1
echo "--- old_flow -std=f2018 (算術 IF は削除済みなのでエラー)"; fails old_flow.f -std=f2018
echo "--- implicit_trap (DO 10 I = 1.10 はループではない)"; run implicit_trap.f
echo "--- hollerith -std=f2018 (ホレリス定数はエラー)"; fails hollerith.f -std=f2018
echo "--- hollerith -std=legacy (昔の規格外の書き方を通す)"; run hollerith.f -std=legacy
echo "--- modern (配列演算・where・do concurrent)"; run modern.f90 -std=f2018 -Wall
