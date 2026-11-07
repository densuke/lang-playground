// 所有権: 代入すると中身の持ち主が移る。移した後の元の変数は使えない
fn main() {
    let a = String::from("hello");
    let b = a; // a の持つ文字列の所有権が b へ移る (move)
    println!("{b}");
    println!("{a}"); // コンパイルエラー: a はもう持っていない
}
