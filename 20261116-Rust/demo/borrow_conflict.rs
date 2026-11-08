// 借用: 読む参照が生きている間は書き換えられない
fn main() {
    let mut scores = vec![10, 20, 30];
    let first = &scores[0]; // 読むだけの参照
    scores.push(40); // 書き換え。first が生きているので衝突
    println!("{first}");
}
