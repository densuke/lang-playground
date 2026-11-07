// enum は中身を持てる。match は全部の場合を書かないとコンパイルが通らない
enum Shape {
    Circle { r: f64 },
    Rect { w: f64, h: f64 },
    Triangle(f64, f64, f64),
}

fn area(s: &Shape) -> f64 {
    match s {
        Shape::Circle { r } => std::f64::consts::PI * r * r,
        Shape::Rect { w, h } => w * h,
        Shape::Triangle(a, b, c) => {
            let p = (a + b + c) / 2.0; // ヘロンの公式
            (p * (p - a) * (p - b) * (p - c)).sqrt()
        }
    }
}

fn classify(n: i32) -> &'static str {
    match n {
        i32::MIN..=-1 => "負",
        0 => "ゼロ",
        x if x % 2 == 0 => "正の偶数",
        _ => "正の奇数",
    }
}

fn main() {
    let shapes = [
        Shape::Circle { r: 1.0 },
        Shape::Rect { w: 3.0, h: 4.0 },
        Shape::Triangle(3.0, 4.0, 5.0),
    ];
    for s in &shapes {
        println!("面積 {:.3}", area(s));
    }
    for n in [-5, 0, 8, 9] {
        println!("{n} は {}", classify(n));
    }
    // タプルや配列も同じ書き方で分解できる
    let [head, .., last] = [1, 2, 3, 4, 5];
    println!("先頭 {head}, 末尾 {last}");
}
