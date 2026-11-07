# コンテナ内で bash -s に流して使う。バイナリは /tmp へ出す (demo/ を汚さない)
set -u
run() { rustc --edition 2024 -o "/tmp/${1%.rs}" "/work/$1" && "/tmp/${1%.rs}"; }
# 失敗が見せ場のもの。コンパイルエラーを出し、終了コードも見せる
fails() { rustc --edition 2024 -o /tmp/x "/work/$1" 2>&1; echo "rustc の終了コード: $?"; }

rustc --version; cargo --version
echo "--- hello"; run hello.rs
echo "--- option_result"; run option_result.rs
echo "--- patterns"; run patterns.rs
echo "--- ownership_move (コンパイルエラーになる)"; fails ownership_move.rs
echo "--- borrow_conflict (コンパイルエラーになる)"; fails borrow_conflict.rs
echo "--- non_exhaustive (コンパイルエラーになる)"; fails non_exhaustive.rs
echo "--- cargo"
cd /work/cargo-demo && CARGO_TARGET_DIR=/tmp/target cargo run --quiet && CARGO_TARGET_DIR=/tmp/target cargo test --quiet
