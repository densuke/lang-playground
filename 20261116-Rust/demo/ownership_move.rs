// 所有権: 代入すると持ち主が移る
fn main() {
    let a = String::from("hello");
    let b = a; // 持ち主が b へ移る
    println!("{b}");
    println!("{a}"); // a はもう使えない
}
