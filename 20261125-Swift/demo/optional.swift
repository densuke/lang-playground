// Optional: 「値が無いかも」が型に出る。nil を入れられるのは Optional だけ
func firstEven(_ xs: [Int]) -> Int? {
    xs.first { $0 % 2 == 0 }
}

func describe(_ xs: [Int]) -> String {
    // guard let: 値が無ければここで抜ける。以降は取り出した値を安全に使える
    guard let n = firstEven(xs) else { return "偶数なし" }
    return "最初の偶数は \(n)"
}

print(describe([1, 3, 4, 6]))
print(describe([1, 3, 5]))

let maybe: String? = nil
if let s = maybe { print("あった: \(s)") } else { print("maybe は nil") }
print("既定値つき: \(maybe ?? "(なし)")")
print("チェーン: \(String(describing: maybe?.count))")  // nil なら以降を飛ばして nil

// Int("abc") は失敗するかもしれないので Int? を返す
for text in ["42", "abc", ""] {
    if let n = Int(text) { print("\"\(text)\" -> \(n * 2)") } else { print("\"\(text)\" -> 数ではない") }
}
