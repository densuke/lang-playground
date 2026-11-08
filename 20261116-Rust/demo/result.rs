// 失敗するかもしれない処理は Result で返す
use std::num::ParseIntError;

fn double(s: &str) -> Result<i32, ParseIntError> {
    let n: i32 = s.parse()?; // 失敗したら Err を返す
    Ok(n * 2)
}

fn main() {
    println!("{:?}", double("21"));
    println!("{:?}", double("abc"));
}
