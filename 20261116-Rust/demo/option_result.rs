// null も例外もない。「無いかもしれない」は Option、「失敗するかもしれない」は Result
use std::num::ParseIntError;

fn first_even(xs: &[i32]) -> Option<i32> {
    xs.iter().copied().find(|x| x % 2 == 0)
}

fn parse_and_double(s: &str) -> Result<i32, ParseIntError> {
    let n: i32 = s.trim().parse()?; // 失敗したらここで Err を呼び出し元へ返す
    Ok(n * 2)
}

fn main() {
    println!("{:?}", first_even(&[1, 3, 4, 5]));
    println!("{:?}", first_even(&[1, 3, 5]));

    for input in ["21", " 7 ", "abc", ""] {
        match parse_and_double(input) {
            Ok(v) => println!("{input:?} -> {v}"),
            Err(e) => println!("{input:?} -> エラー: {e}"),
        }
    }

    // Option を取り出すとき、None を無視するコードは書けない
    let n = first_even(&[1, 3, 5]).unwrap_or(-1);
    println!("既定値つき: {n}");
}
