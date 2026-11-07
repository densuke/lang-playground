// 借用: 読む参照が生きている間は、書き換える参照を取れない
fn main() {
    let mut scores = vec![10, 20, 30];
    let first = &scores[0]; // 不変の借用
    scores.push(40); // 可変の借用 (push は &mut self)。first がまだ生きているので衝突
    println!("{first}");
}
