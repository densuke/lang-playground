// match に漏れがあると、実行前にコンパイラが止める
enum Light {
    Red,
    Yellow,
    Green,
}

fn next(l: Light) -> &'static str {
    match l {
        Light::Red => "青へ",
        Light::Green => "黄へ",
        // Light::Yellow を書き忘れた
    }
}

fn main() {
    println!("{}", next(Light::Red));
    let _ = Light::Yellow;
}
