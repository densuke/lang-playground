// Optional: 「値が無いかも」が型に出る (? が付く)
func firstEven(_ xs: [Int]) -> Int? {
    xs.first { $0 % 2 == 0 }
}

func describe(_ xs: [Int]) -> String {
    guard let n = firstEven(xs) else { return "偶数なし" }
    return "最初の偶数は \(n)"
}
print(describe([1, 3, 4, 6]))
print(describe([1, 3, 5]))
