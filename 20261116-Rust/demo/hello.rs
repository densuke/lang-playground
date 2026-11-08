// Hello World。edition は 2024 を明示する (rustc 単体のときの既定は 2015)
fn main() {
    println!("Hello, world!");
    // 文字列の中の波括弧に変数を直接書ける
    let name = "Rust";
    println!("{name} の名前は {} 文字", name.len());
}
