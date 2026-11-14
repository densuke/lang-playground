// 失敗することが目的: Optional のまま Int として使うとコンパイルエラー
let n: Int? = Int("42")
let doubled: Int = n * 2
print(doubled)
